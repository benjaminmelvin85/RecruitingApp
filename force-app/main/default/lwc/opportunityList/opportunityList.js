import { LightningElement,api,wire,track} from 'lwc';
import getOpportunities from '@salesforce/apex/opportunityController.getOpportunities';
import { refreshApex } from '@salesforce/apex';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import STAGE_FIELD from '@salesforce/schema/Opportunity.StageName';
import { subscribe, unsubscribe, onError } from 'lightning/empApi';
import { NavigationMixin } from 'lightning/navigation';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';

const actions = [
    {label: 'Show details', name: 'show_details' },
    {label: 'Quick edit', name: 'quick_edit'   },
    ];
export default class OpportunityList extends NavigationMixin(LightningElement) {

    @api recordId;
   

    displayedOpps = []; //will hold the opp records currently displaying
    allOpps = []; //will hold master list of opps
    results;

    dataToDisplay = false;
    totalRecords; // will calc as needed
    totalAmount; //will calc as needed
    status = 'All';

    subscription = {};
    channelName = '/topic/Opportunities';

    tableMode = false;
    selectedMode = 'Card';
    openModal = false;
    oppId;
    actionName;
    row;
    draftValues = [];
    get displayOptions() {
        return [
            { label: 'Card', value: 'Card' },
            { label: 'Table', value: 'Table' },
        ];
    }
   
columns = [
    {label: 'Opportunity Name', fieldName: 'Name', type: 'text'},
    {label: 'Amount', fieldName: 'Amount', type: 'currency', editable: true},
    {label: 'Stage', type: 'customPlType', typeAttributes: {
        plValue: { fieldName: 'StageName'},
        options: { value: this.plOptions }
    }},
    {label: 'Close Date', fieldName: 'CloseDate', type: 'date', editable: true},
    {
        type: 'action',
        typeAttributes: {rowActions: actions},
    }
];


@wire(getOpportunities, { accountId: '$recordId'})
wiredOpportunities(opps) {
    this.results = opps;
    console.log(opps);
    console.log(this.results.data);
    if (this.results.data) {
        this.allOpps = this.results.data;
        this.dispatchEvent(new CustomEvent('oppcount', {detail: this.allOpps.length}));
        this.updateList();
    }
    else if (this.results.error){
        console.log(this.results.error);
    }
}

@track options = [
    { value: 'All', label: 'All'},
    { value: 'Open', label: 'Open'},
    { value: 'Closed', label: 'Closed' }
   /* { value: 'ClosedWon', label: 'Closed Won'},
    { value: 'ClosedLost', label: 'Closed Lost'}, */
];
@track plOptions =[];
@wire(getPicklistValues, { recordTypeId: '012000000000000AAA', fieldApiName: STAGE_FIELD})
wiredPicklist({ data, error}) {
    console.log(STAGE_FIELD);
    if (data){
        console.log(data);
        for ( let item of data.values){
            this.options.push({ value: item.value, label: item.label });
            this.plOptions.push({ value: item.value, label: item.label });
        }
        this.options = this.options.slice();
        this.plOptions = this.options.slice();
        console.log(this.options);
    } else if (error) {
        console.log('Error occured: '+ error);
    }
}

handleChange(event){
    this.status = event.detail.value;
    this.updateList();
}
    updateList() {
        this.displayedOpps = [];
        this.totalAmount = 0;
        this.totalRecords = 0;
        this.dataToDisplay = false;
        for (let i = 0; i < this.allOpps.length; i++){
            if (this.status === 'All'){
                this.displayedOpps.push(this.allOpps[i]);
            } else if (this.status === 'Closed'){
                if (this.allOpps[i].IsClosed) {
                    this.displayedOpps.push(this.allOpps[i]);
                }
            } /* else if (this.status === 'ClosedLost'){
                if (this.allOpps[i].IsClosed & !this.allOpps[i].IsWon) {
                    this.displayedOpps.push(this.allOpps[i]);
                }
            }*/ else if (this.status === 'Open'){
                if (!this.allOpps[i].IsClosed) {
                    this.displayedOpps.push(this.allOpps[i]);
                }
            } else if (this.status === this.allOpps[i].StageName) {
                this.displayedOpps.push(this.allOpps[i]);
            }

        }
        if(this.displayedOpps.length > 0) {
            this.dataToDisplay = true;
        }
        this.totalRecords = this.displayedOpps.length;
        this.totalAmount = this.displayedOpps.reduce((a, b) => a + b.Amount,0);
    }

    handleOppUpdate(){
        return refreshApex(this.results);
    }

    handleSubscribe() {
        const messageCallback = response => {
            if (response.data.event == 'deleted') {
                if(this.allOpps.find(elem => { return elem.Id === response.data.sobject.id})) {
                    this.handleOppUpdate();
                } 
            } else {
                if(response.data.sobject.AccountId === this.recordId) {
                    this.handleOppUpdate();
                }
            }
        }       
        subscribe(this.channelName, -1, messageCallback)
              .then(response => {
                this.subscription = response;
              });
    }

    handleUnsubscribe() {
        unsubscribe(this.subscription, response => {
            console.log('Unsubscribed');
        });
    }

    registerErrorListener() {
        onError(error => {
            console.log('Error received: '+ error);
        })
    }

    connectedCallback(){
        this.handleSubscribe();
        this.registerErrorListener();
    }

    disconnectedCallback(){
        this.handleUnsubscribe();
    }

    handleModeChange(event) {
        this.selectedMode = event.detail.value;
        console.log(this.selectedMode);
        if (this.selectedMode === 'Table'){ 
            this.tableMode = true; 
        } else { 
            this.tableMode = false;
        }
    }
    handleRowAction(event) {
        this.actionName = event.detail.action.name;
        this.row = event.detail.row;
        // console.log(this.row);
        // console.log(this.actionName);
        this.oppId = this.row.Id;
        switch (this.actionName) {
            case 'quick_edit':
            
            
            this.openModal = true; 
            break;
            case 'show_details':
                this[NavigationMixin.GenerateUrl]({

                    type: 'standard__recordPage',
                    attributes: {
                    recordId: this.oppId,
                    actionName: 'view',
                    }
                }).then(url => {
                    window.open(url)
                });
            break;
            default:
            }
    }

    closeModWindow() {
        this.openModal = false;
    }
    handleSuccess() {
        this.openModal = false;
        this.handleOppUpdate();
    }
    async handleStuff(event){
        console.log('we made it');
        console.log(event.detail);
        const records = event.detail.draftValues.slice().map((draftValue) => {
            const fields = Object.assign({}, draftValue);
            return { fields };
        });
    console.log(this.draftValues);
    console.log(records);
    this.draftValues = [];

    try {

        const recordUpdatePromises = records.map((record) => 
            updateRecord(record)
    );
        await Promise.all(recordUpdatePromises);

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Opportunities updated',
                variant: 'success'
            })
        );
        await handleOppUpdate();

    } catch (error) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error processing opportunities',
                message: error.body.message,
                variant: 'error'
            })
        );
    }

    }
}
