public without sharing class TeamSelector {
    public static List<Team__c> retrieveTeamsByContactIds(List<Id> contactIds) {
        return [
            SELECT Id, Name, Team_Name__c,
            (SELECT Id, Name, Team__c, Person__c, Person__r.Name FROM Players_In_Team__r)
            FROM Team__c
            WHERE Id IN (SELECT Team__c FROM Player_In_Team__c WHERE Person__c IN :contactIds AND Team__c != null)
        ];
    }

    public static List<Team__c> retrieveTeams(List<Id> teamIds) {
        return [
            SELECT Id, Name, Team_Name__c,
            (SELECT Id, Name, Team__c, Person__c, Person__r.Name FROM Players_In_Team__r)
            FROM Team__c
            WHERE Id IN :teamIds
        ];
    }
}
