import { LightningElement, wire } from 'lwc';
import getTopAccounts from '@salesforce/apex/AccountController.getTopAccounts';
import AccountMC from '@salesforce/messageChannel/AccountMessageChannel__c';
import { publish, MessageContext} from 'lightning/messageService';
import RecordModal from 'c/recordModal';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account'

export default class AcctList extends LightningElement {
    records;
    results;
    error;
    accounts = [];
   

    @wire(MessageContext) 
    messageContext; 
    @wire(getObjectInfo, {objectApiName: ACCOUNT_OBJECT})
    acctObjInfo;
    // @wire(getTop5Accounts)
    // getWiredAccounts(value) {
    //     this.results = value;
    //     if (this.results.data) {
    //         this.records = this.results.data;
    //         this.error = undefined;
    //         this.selectedAccountId = this.records[0].Id;
    //         this.sendMessageService(this.selectedAccountId, this.records[0].Name);
    //         this.createMapMarkers();
    //     } else if (this.results.error) {
    //         this.records = undefined;
    //         this.error = this.results.error;
    //     }
    // }

    @wire(getTopAccounts)
    getWiredAccounts(value) {
        this.results=value;
        if(this.results.data) {
            this.records = this.results.data;
            this.sendMessageService(this.records[0].Id);
        } else if( this.results.error) {
            this.error = this.results.error;
        }
    }
    // handleSelect(event) {
    //     console.log(event.detail);
    //     this.sendMessageService(event.detail.prop1, event.detail.prop2);
    // }

    // sendMessageService(accountId, accountName){
    //     publish(this.messageContext, AccountMC, {recordId: accountId, accountName: accountName});
    // }
    handleSelect(event) {
        this.sendMessageService(event.detail);
    }
    sendMessageService(accountId) {
        publish(this.messageContext, AccountMC, {recordId: accountId});
    }
    @wire(getTopAccounts)
    getWiredAccountsForMap({error, data}) {
        if (data) {
            this.accounts = data;
            console.log('myMapdata: ' + this.accounts);
            this.handleSuccess(data);
            
        }
        else if(error) {
            console.log(error);
        }
    }
   async handleSuccess(data) {
        this.accounts = await this.generateMapMarkers(data)
        
    }
    generateMapMarkers(accounts) {
        console.log('generateMapMarker called');
        console.log(accounts);
        return accounts.map((account) => {
          return {
            location: {
              Street: account.BillingStreet,
              City: account.BillingCity,
              State: account.BillingState,
              PostalCode: account.BillingPostalCode
            },
            title: account.Name,
            description: `${account.BillingStreet}, ${account.BillingCity}, ${account.BillingState} ${account.BillingPostalCode}`
          };
        });
      }
      //create method to open a modal window and allow the user to create a new accoutn record
      createAcct() {
        console.log(this.acctObjInfo.data.recordTypeInfos);

        RecordModal.open({
            size: 'medium',
            objectApiName: 'Account',
            formMode: 'edit',
            layoutType: 'Full',
            headerLabel: 'Create New Account',
            recordTypeId: this.acctObjInfo.data.defaultRecordTypeId
        }).then((result) => {
            if (result != 'modcancel' && result != undefined) {
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Account Created Successfully',
                    message: 'the account record for ' + result.fields.Name.value + ' was successfully created',
                    variant: 'success',
                    mode: 'sticky'
                }))
            }
        });
      }
    
}