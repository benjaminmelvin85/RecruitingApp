import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';
import RecordModal from 'c/recordModal';

export default class OppCard extends NavigationMixin(LightningElement) {
    @api name; //need to define opportunity name
    @api stage;
    @api amount;
    @api closeDate;
    @api oppId;
    openModal = false;

    toastTitle;
    toastMessage;
    toastVariant;
    toastMode;
    toastType;
    viewRecord() {
        this[NavigationMixin.GenerateUrl]({

            type: 'standard__recordPage',
            attributes: {
            recordId: this.oppId,
            actionName: 'view',
            }
        }).then(url => {
            window.open(url)
        });
    }
    openModWindow() {
        // this.openModal = true;
        RecordModal.open({
            size: 'small',
            recordId: this.oppId,
            objectApiName: 'Opportunity',
            formMode: 'edit',
            layoutType: 'Compact',
            headerLabel: 'Edit Opportunity'
        }).then((result) => {
            console.log(result);
            if(result != 'modcancel' && result != 'undefined') {
                this.handleSuccess();
            }
        });

    }
    closeModWindow() {
        this.openModal = false;
        
    }
    handleSuccess() {
        this.openModal = false;
        this.dispatchEvent( new CustomEvent('modx'));
        this.toastTitle ='Opportunity Saved Successfully';
        this.toastMessage =`Opportunity ${this.name} was saved`;
        this.toastVariant = 'success';
        this.toastMode = 'dismissable';
        this.toastType = 'Notification';
        this.showToast();
        
    }
 showToast() {
    
    const evt = new ShowToastEvent({
        title: this.toastTitle,
        message: this.toastMessage,
        variant: this.toastVariant,
        mode: this.toastMode
    });
    this.dispatchEvent(evt);
 }

}