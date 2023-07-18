import { LightningElement, api } from 'lwc';
import RecordModal from 'c/recordModal';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CaseCard extends LightningElement {

    @api caseNumber;
    @api subject;
    @api status;
    @api priority;
    @api caseId;

    //method to open the recordmodal

    editCase() {
        // open modal window
        RecordModal.open({
            size: 'medium',
            recordId: this.caseId,
            objectApiName: 'Case',
            formMode: 'edit',
            layoutType: 'Compact',
            headerLabel: 'Edit Case'
        }).then((result) => {
            console.log(result);
            if (result != 'modcancel' && result != undefined) {
                const myToast = new ShowToastEvent({
                    title: 'Case Saved Success',
                    message: 'Case number ' + result.fields.CaseNumber.value + ' was successfully updated.',
                    variant: 'success',
                    mode: 'dismissible'
                });
                this.dispatchEvent(myToast);

            }
        });
    }
    
}