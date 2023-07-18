import { LightningElement, wire } from 'lwc';
import AccountMC from '@salesforce/messageChannel/AccountMessageChannel__c';
import { subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import {ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class AcctDetails extends LightningElement {

    accountId;
    subscription = null;

    @wire(MessageContext) 
    messageContext; 

    subscribeToMessageChannel() {
        if(!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,  AccountMC, (message) => this.handleMessage(message), 
                { scope: APPLICATION_SCOPE
                });
        }
    }
    handleMessage(message) {
        this.accountId = message.recordId;
    }
    unsubscribeFromMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription =null;
    }
    connectedCallback() {
        this.subscribeToMessageChannel();
    }
    disconnectedCallback() {
        this.unsubscribeFromMessageChannel();
    }
    //method to handle the success event raised by the lightning record form successful save
    detailsSaved(event) {
        console.log(event.detail);
        this.dispatchEvent(new ShowToastEvent({
            title: 'Account Updated',
            message: 'Account ' + event.detail.fields.Name.value + ' was successfully updated!',
            variant: 'success',
            mode: 'dismissible'
        }));
    }
}