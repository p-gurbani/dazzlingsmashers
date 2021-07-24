import {
    LightningElement,
    api
} from 'lwc';

import getPlayersOnTheGround from '@salesforce/apex/OnTheGroundController.getPlayersOnTheGround';

export default class SelectPlayers extends LightningElement {
    players = [];

    connectedCallback() {
        this.getPlayers();
    }

    get noPlayer() {
        return !(this.players && this.players.length);
    }

    @api
    getPlayers() {
        getPlayersOnTheGround()
            .then(result => {
                this.players = result;
            })
            .catch(err => {
                showToast(this, '', LABELS.somethingWentWrong, 'error');
            })
    }
}