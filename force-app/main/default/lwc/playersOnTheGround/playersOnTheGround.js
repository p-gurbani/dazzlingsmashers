import {
    LightningElement,
    api
} from 'lwc';

import getPlayersOnTheGround from '@salesforce/apex/OnTheGroundController.getPlayersOnTheGround';

import {
    showToast
} from 'c/util';
import {
    LABELS
} from 'c/labels';

export default class PlayersOnTheGround extends LightningElement {
    playersOnTheGround = [];
    labels = LABELS;

    connectedCallback() {
        this.getPlayers();
    }

    get noPlayerOnGround() {
        return !(this.playersOnTheGround && this.playersOnTheGround.length);
    }

    @api
    getPlayers() {
        getPlayersOnTheGround()
            .then(result => {
                this.playersOnTheGround = result;
            })
            .catch(err => {
                showToast(this, '', LABELS.somethingWentWrong, 'error');
            })
    }
}