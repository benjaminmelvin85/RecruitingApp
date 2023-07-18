import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api childName;
        @api age;
        @api relatedType;
        datatopass =''
    constructor() {
        

        super();
        console.log('child comp constructing')

    }
    connectedCallback(){
        console.log('child comp connected callback fired')
    }
    renderedCallback(){
        console.log('child comp renderedcallback fired')
    }
    handleClick(event) {
        console.log('Click Event detected');
        console.log(event.detail);
        const myEvent = new CustomEvent('myevent', {detail:this.datatopass});
        this.dispatchEvent(myEvent);
        this.datatopass = this.childName + ' was the sending componenet';
    }
}
