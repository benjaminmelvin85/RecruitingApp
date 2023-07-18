import { LightningElement, wire, api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import TITLE_FIELD from '@salesforce/schema/Contact.Title';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';

const fields = [NAME_FIELD, TITLE_FIELD, PHONE_FIELD, EMAIL_FIELD];

export default class GetRecordForm extends LightningElement {
    @api recordId;
    contact;
    get name() {
        return getFieldValue(this.contact, NAME_FIELD);
    }
    get title() {
        return getFieldValue(this.contact, TITLE_FIELD);
    }
    get phone() {
        return getFieldValue(this.contact, PHONE_FIELD);
    }
    get email() {
        return getFieldValue(this.contact, EMAIL_FIELD);
    }
    @wire(getRecord, {recordId: '$recordId', fields: fields})
    wiredContact({error, data}) {
        if (data) {
            console.log(data);
            this.contact = data
        }
        if (error) {
            console.log(error)
        }
    };

}