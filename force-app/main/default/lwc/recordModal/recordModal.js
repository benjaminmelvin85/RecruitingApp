import { api } from 'lwc';
import LightningModal from 'lightning/modal';

export default class RecordModal extends LightningModal {
    //public properties to hold values for displaying/editing/creating a record
    @api recordId;
    @api objectApiName;
    @api formMode;
    @api layoutType;
    @api headerLabel;
    @api recordTypeid;

    //method to cancel the event raised by the lightning-record-form
    handleCancel() {
        this.close('modcancel');
    }
    //method to hand success event
    handleSuccess(event) {
        this.close(event.detail);
    }
    
}