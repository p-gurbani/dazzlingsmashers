public with sharing class DSLoginController {

    private without sharing class SystemContext {
        public List<Contact> getContact(String email, String password) {
            return [SELECT Id, FirstName FROM Contact WHERE Email = :email AND Password__c = :password LIMIT 1];
        }
    }
    
    @AuraEnabled
    public static LoginDetails logIn(String email, String password){
        try {
            List<Contact> contacts = new SystemContext().getContact(email, password);
            if(!contacts.isEmpty()) {
                return new LoginDetails(true)
                .setContactId(contacts[0].Id)
                .setContactName(contacts[0].FirstName);
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return new LoginDetails(false);
    }

    public class LoginDetails {
        @AuraEnabled
        public Boolean isSuccessful;
        @AuraEnabled
        public String contactId;
        @AuraEnabled
        public String contactName;

        public LoginDetails(Boolean isSuccessful) {
            this.isSuccessful = isSuccessful;
        }

        public LoginDetails setContactId(String contactId) {
            this.contactId = contactId;
            return this;
        }

        public LoginDetails setContactName(String contactName) {
            this.contactName = contactName;
            return this;
        }
    }
}
