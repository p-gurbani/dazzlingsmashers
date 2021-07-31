import {
    LightningElement,
    api,
    track
} from 'lwc';

import {
    LABELS
} from 'c/labels';

import {
    showToast
} from 'c/util';

import getActiveOrPendingTournaments from '@salesforce/apex/TournamentDashboardController.getActiveOrPendingTournaments';
import buildTournament from '@salesforce/apex/TournamentDashboardController.buildTournament';

export default class TournamentDashboard extends LightningElement {
    @api contactId;
    @track activeOrPendingTournaments = [];
    selectedPlayerIds = [];

    connectedCallback() {
        this.changeHeading(LABELS.activeTournaments);
        this.fetchActiveOrPendingTournaments();
    }

    changeHeading(heading) {
        this.dispatchEvent(new CustomEvent('changeheading', {
            detail: {
                heading: heading
            }
        }));
    }

    fetchActiveOrPendingTournaments() {
        getActiveOrPendingTournaments({
            includeOnlyTodays: false
        }).then((res) => {
            this.activeOrPendingTournaments = res;
        }).catch((err) => {
            showToast(this, '', LABELS.somethingWentWrong, 'error');
        })
    }

    onNewTournament(_) {
        this.template.querySelector('c-modal').show();
    }

    handlePlayerSelectionChanged(evt) {
        this.selectedPlayerIds = evt.detail.selectedPlayerIds;
    }

    onTournamentCreate(evt) {
        this.template.querySelector('c-modal').hide();
        if (this.selectedPlayerIds && this.selectedPlayerIds.length && this.selectedPlayerIds.length >= 2) {
            buildTournament({
                playerIds: this.selectedPlayerIds,
                countPerTeam: 2
            }).then(res => {
                console.log(res);
            }).catch(err => {
                console.log(err);
                showToast(this, '', LABELS.somethingWentWrong, 'error');
            })
        } else {
            showToast(this, '', LABELS.pleaseSelectPlayers, 'error');
        }
    }
}