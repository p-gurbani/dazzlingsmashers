public with sharing class OnTheGroundController {
    private without sharing class SystemContext {
        public List<Contact> getContactsOnTheGround() {
            return [SELECT Id, Name FROM Contact WHERE On_The_Ground__c = true];
        }

        public List<Contact> getContact(Id contactId) {
            return [SELECT Id, On_The_Ground__c FROM Contact WHERE Id = :contactId LIMIT 1];
        }

        public void updateContacts(List<Contact> contacts) {
            UPDATE contacts;
        }
    }

    @AuraEnabled
    public static List<PlayerDetails> getPlayersOnTheGround(){
        try {
            List<Contact> contacts = new SystemContext().getContactsOnTheGround();
            List<PlayerDetails> players = new List<PlayerDetails>();
            for(Contact con : contacts) {
                players.add(new PlayerDetails(con.Id, con.Name));
            }
            return players;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Boolean isPlayerOnTheGround(Id contactId){
        try {
            List<Contact> con = new SystemContext().getContact(contactId);
            if(!con.isEmpty()) {
                return con[0].On_The_Ground__c;
            }
            return false;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void setPlayerOnTheGround(Id contactId, Boolean inOrOut){
        SystemContext sc = new SystemContext();
        try {
            List<Contact> con = sc.getContact(contactId);
            if(!con.isEmpty()) {
                con[0].On_The_Ground__c = inOrOut;
                sc.updateContacts(con);
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class PlayerDetails {
        @AuraEnabled
        public String id;
        @AuraEnabled
        public String name;

        public PlayerDetails(String id, String name) {
            this.id = id;
            this.name = name;
        }
    }
}
