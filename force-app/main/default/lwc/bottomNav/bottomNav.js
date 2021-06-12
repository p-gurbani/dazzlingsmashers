import { LightningElement } from 'lwc';

export default class BottomNav extends LightningElement {
    onTabChange(e) {
        this.template.querySelector('.active').classList.remove('active');
        e.target.classList.add('active');
        this.dispatchEvent(new CustomEvent(
            'tabchange', {detail: {
                tabId: e.target.dataset.id
            }}
        ));
    }
}