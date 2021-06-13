import {
    LightningElement,
    api
} from 'lwc';

import {
    LABELS
} from 'c/labels';

export default class Play extends LightningElement {
    @api contactId;
    labels = LABELS;

}