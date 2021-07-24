import {
    LightningElement
} from 'lwc';

import RESOURCES from '@salesforce/resourceUrl/DazzlingSmashers';

const BACKGROUNDS = {
    tournament: RESOURCES + '/Images/tournament-background.jpg',
    manualquickmatch: RESOURCES + '/Images/tournament-background.jpg',
    randomquickmatch: RESOURCES + '/Images/tournament-background.jpg',
}

export default class GameTypes extends LightningElement {

    gameTypes = [{
            name: "tournament",
            label: "Tournament"
        },
        {
            name: "manualquickmatch",
            label: "Manual Quick Match"
        },
        {
            name: "randomquickmatch",
            label: "Random Quick Match"
        },
    ];

    isInitialized = false;

    renderedCallback() {
        if (!this.isInitialized) {
            this.setBackgrounds();
            this.isInitialized = true;
        }
    }

    setBackgrounds() {
        this.gameTypes.forEach(gt => {
            const el = this.template.querySelector(`[data-name="${gt.name}"]`);
            if (el) {
                el.setAttribute('style', this.getBackgroundStyle(gt.name));
            }
        })
    }

    getBackgroundStyle(gameType) {
        return 'background: url(' + BACKGROUNDS[gameType] + ');';
    }

    onGameTypeClick(e) {
        const gameType = e.target.dataset.name;
        if (gameType) {
            this.dispatchEvent(new CustomEvent('gametypeclick', {
                detail: {
                    gameType: gameType
                }
            }));
        }
    }
}