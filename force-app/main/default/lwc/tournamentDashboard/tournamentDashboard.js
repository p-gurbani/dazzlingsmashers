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

export default class TournamentDashboard extends LightningElement {
    @api contactId;
    @track activeOrPendingTournaments = [];

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

    onNewTournament(e) {
        this.template.querySelector('c-modal').show();
    }
}