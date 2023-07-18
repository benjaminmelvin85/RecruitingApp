import { LightningElement, api } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';
import creditCheckApi from '@salesforce/apexContinuation/CreditCheckContinuation.creditCheckApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class AcctCard extends LightningElement {
   
    @api name;
    @api accountId;
    @api annualRevenue;
    @api phone;
    @api website;
    displayContacts = false;
    contacts;
    error;
    creditObj = {};
    dataLoaded= true;
    handleSelect() {
        const myEvent = new CustomEvent('select', {detail: this.accountId});
        this.dispatchEvent(myEvent);
    }
    // handleSelect(){
    //     const myEvent = new CustomEvent('select', {detail: {'prop1': this.accountId, 'prop2': this.name} });
    //     this.dispatchEvent(myEvent);
    // }
    contactDisplay() {
        // this.displayContacts = !this.displayContacts;
      
        if(this.displayContacts) {
            this.displayContacts = false;
        } else {
            this.dataLoaded = false;
        
            getContactList({accountId: this.accountId})
            .then((result) => {
                this.contacts = result;
                this.displayContacts = true;
            })
            .catch((error) => {
                this.error = error;
            })
            .finally(() => {
                this.dataLoaded = true;
            })
        }
    }
    checkCredit() {
        creditCheckApi({accountId: this.accountId})
        .then( response => {
            console.log(response);
            this.creditObj = JSON.parse(response);
            console.log(this.creditObj.Company_Name__c);

            let toastMessage = 'Credit Check approved for ' + this.creditObj.Company_Name__c;

            const toastEvent = new ShowToastEvent({
                title: 'Credit Check Complete',
                message: toastMessage,
                variant: 'success',
                mode: 'sticky'
            });
            this.dispatchEvent(toastEvent);
        })
        .catch( error => {
            console.error(JSON.stringify(error));
        })
    }
   

}
