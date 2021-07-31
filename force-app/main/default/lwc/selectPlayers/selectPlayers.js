import {
    LightningElement,
    api,
    track
} from 'lwc';

import getPlayersOnTheGround from '@salesforce/apex/OnTheGroundController.getPlayersOnTheGround';

export default class SelectPlayers extends LightningElement {
    @track players = [];

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
                this.players.forEach(pl => pl.isSelected = true);
                this.fireSelectionChangeEvent();
            })
            .catch(err => {
                showToast(this, '', LABELS.somethingWentWrong, 'error');
            })
    }

    onTogglePlayerSelection(evt) {
        const playerId = evt.target.dataset.id;
        const player = playerId && this.players && this.players.find(pl => pl.id === playerId);
        if (player) {
            player.isSelected = !player.isSelected;
            this.fireSelectionChangeEvent();
        }
    }

    fireSelectionChangeEvent() {
        let selectedPlayerIds = [];
        this.players.forEach(pl => {
            if (pl.isSelected) {
                selectedPlayerIds.push(pl.id);
            }
        });
        this.dispatchEvent(new CustomEvent('playerselectionchanged', {
            detail: {
                selectedPlayerIds: selectedPlayerIds
            }
        }));
    }
}