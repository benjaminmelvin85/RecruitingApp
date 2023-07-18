import { LightningElement, api } from 'lwc';

export default class OppRecordForm extends LightningElement {
        @api recordId;
        @api objectApiName;

        closeModal() {
                this.dispatchEvent(new CustomEvent('close'));
            }
            handleSuccess() {
                this.dispatchEvent(new CustomEvent('success'));
                console.log('success detected');
            }
            handleCancel() {
                this.dispatchEvent(new CustomEvent('cancel'));
                console.log('cancel detected');
            }
}