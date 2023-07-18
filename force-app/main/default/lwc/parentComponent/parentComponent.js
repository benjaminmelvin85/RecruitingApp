import { LightningElement, api } from 'lwc';

export default class ParentComponent extends LightningElement {
        

    constructor() {
        super();
        console.log('parent comp constructing')

    }
    connectedCallback(){
        console.log('parent comp connected callback fired')
    }
    renderedCallback(){
        console.log('parent comp renderedcallback fired')
    }
    handleMyEvent(event) {
        console.log('my event was detected')
        console.log(event.detail);
    }
}
