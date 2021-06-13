import {
    LightningElement
} from 'lwc';

export default class App extends LightningElement {
    isLoggedIn = false;
    contactId;
    currentTab = 'play';

    get isPlayPage() {
        return this.currentTab == 'play';
    }

    get isOnTheGroundPage() {
        return this.currentTab == 'ontheground';
    }

    connectedCallback() {}

    onLoggedIn(e) {
        this.isLoggedIn = true;
        this.contactId = e.detail.contactId;
    }

    onTabChanged(e) {
        this.currentTab = e.detail.tabId;
    }

}