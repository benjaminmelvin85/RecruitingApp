import { LightningElement, wire } from 'lwc';
import AccountMC from '@salesforce/messageChannel/AccountMessageChannel__c';
import { subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';


export default class AcctRelated extends LightningElement {

    accountId;
    subscription = null;
    oppLabel = "Opportunities";
    caseLabel = "Cases";

    
    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    disconnectedCallback() {
        this.unsubscribeFromMessageChannel();
    }

    subscribeToMessageChannel() {
        console.log('acctRelated is subscribing');
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                AccountMC,
                (message) => this.handleMessage(message),
                { scope: APPLICATION_SCOPE }
            )
        }
    }

    unsubscribeFromMessageChannel() {
        console.log('acctRelated is unsubscribing');
        unsubscribe(this.subscription);         // unsubscribe from Message Channel
        this.subscription = null;
    }

    handleMessage(message) {
        this.accountId = message.recordId;
    }

    updateOppLabel(event) {
        this.oppLabel = "Opportunities" + ' (' + event.detail + ')';
    }

    updateCaseLabel(event) {
        this.caseLabel = "Cases" + ' (' + event.detail + ')';
    }



}