import {
    LightningElement
} from 'lwc';

import logIn from '@salesforce/apex/DSLoginController.logIn';

import {
    showToast
} from 'c/util';

import RESOURCES from '@salesforce/resourceUrl/DazzlingSmashers';

const LABELS = {
    incorrectCreds: 'No, not accepting incorrect credentials at this moment',
    loginError: 'Looks like something\'s wrong with the login machine, try calling Pankaj.',
    welcome: 'Welcome, '
}

export default class Login extends LightningElement {
    backgroundUrl = RESOURCES + '/Images/badminton-smasher-vector.jpg';
    email;
    password;
    disableLogin = false;

    get isLogInDisabled() {
        return !(this.email && this.password) || this.disableLogin;
    }

    getContainerDivStyle() {
        return 'background: url(' + this.backgroundUrl + ');';
    }

    renderedCallback() {
        this.setBackground();
    }

    setBackground() {
        var root = this.template.querySelector('.root-container');
        if (root) {
            root.setAttribute('style', this.getContainerDivStyle());
        }
    }

    onEmailChange(e) {
        this.email = e.target.value;
    }

    onPasswordChange(e) {
        this.password = e.target.value;
    }

    onLogIn(e) {
        this.disableLogin = true;
        logIn({
            email: this.email,
            password: this.password
        }).then((result) => {
            try {
                if (result.isSuccessful) {
                    this.dispatchEvent(new CustomEvent('login', {
                        detail: {
                            contactId: result.contactId
                        }
                    }));
                } else {
                    showToast(this, '', LABELS.incorrectCreds, 'error');
                }
            } catch (err) {
                console.log(err);
            }
        }).catch((err) => {
            showToast(this, '', LABELS.loginError, 'error');
            this.disableLogin = false;
        });
    }
}