import { LightningElement, wire, api } from 'lwc';
import topFiveQuerier from '@salesforce/apex/dynamicTopFiveHandler.topFiveQuerier';

export default class DynamicTop5LWC extends LightningElement {
    displayRecords = [];
    @api vfieldName;
    @api objectName; 
    results;

    @wire(topFiveQuerier, { objectName:'$objectName' , fieldName:'$vfieldName' })
    wiredRecords(recs) {
        console.log('topFiveQuery Wire');
        this.results = recs;
        if(this.results.data) {
            this.displayRecords = this.results.data
        }
        else if (this.results.error){
            console.log(error); 
        }
}
}