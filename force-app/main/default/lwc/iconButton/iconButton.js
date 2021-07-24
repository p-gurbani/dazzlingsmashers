import {
    LightningElement,
    api
} from 'lwc';

export default class IconButton extends LightningElement {
    @api label;
    @api iconName;

    onButtonClick(e) {
        this.dispatchEvent(new CustomEvent('btnclick', {
            detail: {
                originalEvent: e
            }
        }));
    }
}