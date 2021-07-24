import {
    LightningElement,
    api
} from 'lwc';

import {
    LABELS
} from 'c/labels';

export default class Play extends LightningElement {
    @api contactId;
    selectedGameType;
    heading = LABELS.letsPlay;

    get showGameTypes() {
        return !this.selectedGameType;
    }

    get isTournamentSelected() {
        return this.selectedGameType === 'tournament';
    }

    onGameTypeClicked(e) {
        this.selectedGameType = e.detail.gameType;
    }

    handleReturnToMainScreen(e) {
        this.selectedGameType = null;
        this.resetHeading();
    }

    handleChangeHeading(e) {
        this.heading = e.detail.heading;
    }

    resetHeading() {
        this.heading = LABELS.letsPlay;
    }

}