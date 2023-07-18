import { LightningElement, api} from 'lwc';

export default class OppRecordForm extends LightningElement {
    @api recordId; //will automatically populate
    editMode = false;
    buttonLabel = 'Edit'
    changeMode() {
        this.editMode = !this.editMode;
        this.buttonLabel = this.editMode ? 'View' : 'Edit';
    }

}