import {
    LightningElement,
    api
} from 'lwc';

export default class IconButton extends LightningElement {
    @api label;
    @api iconName;
    @api btnDisabled = false;

    onButtonClick(e) {
        if (!this.btnDisabled) {
            this.dispatchEvent(new CustomEvent('btnclick', {
                detail: {
                    originalEvent: e
                }
            }));
        }
    }

    get containerDivClass() {
        return this.btnDisabled ? 'iconButtonDiv disabled' : 'iconButtonDiv';
    }
}