import { LightningElement, api } from 'lwc';

import isPlayerOnTheGround from '@salesforce/apex/OnTheGroundController.isPlayerOnTheGround';
import setPlayerOnTheGround from '@salesforce/apex/OnTheGroundController.setPlayerOnTheGround';

import { showToast } from 'c/util';

const LABELS = {
    somethingWentWrong: 'Oops something went terribly wrong, call Pankaj'
}

export default class OnTheGround extends LightningElement {
    @api contactId;
    isMeOnTheGround = false;

    connectedCallback() {
        this.checkIfPlayerIsOnTheGround();
    }

    checkIfPlayerIsOnTheGround() {
        isPlayerOnTheGround({
            contactId: this.contactId
        }).then(result => {
            this.isMeOnTheGround = result;
        }).catch(err => {
            showToast(this, '', LABELS.somethingWentWrong, 'error');
        });
    }

    setPlayerOnTheGround() {
        setPlayerOnTheGround({
            contactId: this.contactId,
            inOrOut: this.isMeOnTheGround
        }).then(result => {})
        .catch(err => {
            console.log(err);
            showToast(this, '', LABELS.somethingWentWrong, 'error');
        });
    }

    onToggleChange(e) {
        this.isMeOnTheGround = e.target.checked;
        this.setPlayerOnTheGround();
    }
}