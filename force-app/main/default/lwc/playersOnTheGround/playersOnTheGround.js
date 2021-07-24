import {
    LightningElement,
    api
} from 'lwc';

import getPlayersOnTheGround from '@salesforce/apex/OnTheGroundController.getPlayersOnTheGround';
import setPlayerOnTheGround from '@salesforce/apex/OnTheGroundController.setPlayerOnTheGround';

import {
    showToast
} from 'c/util';
import {
    LABELS
} from 'c/labels';

export default class PlayersOnTheGround extends LightningElement {
    @api contactId;
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
                result.forEach(r => {
                    if (r.id === this.contactId)
                        r.isCurrentPlayer = true;
                });
                this.playersOnTheGround = result;
            })
            .catch(err => {
                showToast(this, '', LABELS.somethingWentWrong, 'error');
            })
    }

    onRemovePlayer(e) {
        const playerId = e.target.dataset.id;
        this.setPlayerOnTheGround(playerId, false);
        this.playersOnTheGround = this.playersOnTheGround.filter(pl => pl.id !== playerId);
    }

    setPlayerOnTheGround(playerId, inOrOut) {
        setPlayerOnTheGround({
                contactId: playerId,
                inOrOut: inOrOut
            }).then(result => {
                this.getPlayers();
            })
            .catch(err => {
                console.log(err);
                showToast(this, '', LABELS.somethingWentWrong, 'error');
            });
    }
}