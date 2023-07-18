import { LightningElement, api, wire } from 'lwc';
import getCases from '@salesforce/apex/CaseController.getCases';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';
export default class CaseList extends LightningElement {

    @api accountId;                 // public property to accept the Account ID
    records;
    errors;
    results; //property to hold the object provisioned by the wire service

    @wire(getRelatedListRecords, {parentRecordId: '$accountId', relatedListId: 'Cases', 
                fields: ['Case.Id', 'Case.CaseNumber', 'Case.Subject', 'Case.Status', 'Case.Priority']})
    wiredCases(caseRecords) {
        this.results = caseRecords;

        if(this.results.data) {
            this.records = this.results.data.records;

            this.dispatchEvent(new CustomEvent('casecount', {detail: this.records.length}));
            this.errors = undefined;
        }
        if(this.results.error) {
            console.error('Error retrieving records');
            this.errors = error;
        }

    }

    // @wire(getCases, { accountId: '$accountId' })
    // wiredCases({ data, error }) {
    //     if (data) {
    //         this.records = data;
    //         this.errors = undefined;
    //         this.dispatchEvent(new CustomEvent('casecount', { detail: this.records.length }));
    //     }

    //     if (error) {
    //         this.records = undefined;
    //         this.errors = error;
    //     }
    // };
}