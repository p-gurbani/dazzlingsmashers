import { ShowToastEvent } from 'lightning/platformShowToastEvent'

const showToast = (context, title, message, variant) => {
    const event = new ShowToastEvent({
        title: title,
        message: message,
        variant: variant
    });
    context.dispatchEvent(event);
}

export {showToast}