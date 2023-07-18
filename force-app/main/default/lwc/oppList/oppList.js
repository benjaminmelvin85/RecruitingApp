import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity';
import NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import STAGE_FIELD from '@salesforce/schema/Opportunity.StageName';
import AMOUNT_FIELD from '@salesforce/schema/Opportunity.Amount';

const fields = [NAME_FIELD, STAGE_FIELD, AMOUNT_FIELD];

export default class COpportunityList extends LightningElement {
    @api accountId;
    @wire(getRecord, { recordId: '$accountId', fields: fields })
    account;

    get opportunities() {
        if (this.account.data) {
            return this.account.data.fields.Opportunities.value;
        }
        return null;
    }
}