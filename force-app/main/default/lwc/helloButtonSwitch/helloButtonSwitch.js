import { LightningElement } from 'lwc';

export default class HelloButtonSwitch extends LightningElement {
    isHelloWorld = true;
    myStyle = false;
    get myMessage() {
        return this.isHelloWorld ? 'Hello World' : 'Hello Universe';
    }
    get myStyles() {
        return this.myStyle ? 'example1' : 'example2';
    }

    handleButtonClick() {
        this.isHelloWorld = !this.isHelloWorld;
    }
    handleStyleClick() {
        this.myStyle = !this.myStyle;
    }
}