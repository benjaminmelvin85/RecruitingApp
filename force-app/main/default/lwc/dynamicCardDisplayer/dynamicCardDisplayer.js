import { LightningElement, api } from 'lwc';
export default class DynamicCardDisplayer extends LightningElement {
    @api recordName;
    @api fieldName; 
    @api fieldValue;
}