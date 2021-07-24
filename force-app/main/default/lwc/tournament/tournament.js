import {
    LightningElement,
    api
} from 'lwc';

const STATUS = {
    COMPLETED: 'Completed',
    CANCELLED: 'Cancelled',
    ACTIVE: 'Active',
    PENDING: 'Pending'
}

export default class Tournament extends LightningElement {
    @api tournament;

    connectedCallback() {
        this.changeHeading('Active Tournaments');
        this.fetchActiveTournaments
    }

    get isStatusCompleted() {
        return this.tournament && this.tournament.status === STATUS.COMPLETED;
    }

    get isStatusCancelled() {
        return this.tournament && this.tournament.status === STATUS.CANCELLED;
    }

    get isStatusPending() {
        return this.tournament && this.tournament.status === STATUS.PENDING;
    }

    get isStatusActive() {
        return this.tournament && this.tournament.status === STATUS.ACTIVE;
    }

    changeHeading(heading) {
        this.dispatchEvent(new CustomEvent('changeheading', {
            detail: {
                heading: heading
            }
        }));
    }
}