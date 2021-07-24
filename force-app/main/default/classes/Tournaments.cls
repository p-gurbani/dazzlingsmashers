public without sharing class Tournaments {
    public static List<Tournament> getActiveOrPendingTournaments(Boolean includeOnlyTodays) {
        List<Tournament__c> tournaments = new List<Tournament__c>();
        if(includeOnlyTodays) {
            tournaments = [
                SELECT Id, Status__c, Name, Winning_Team__c
                FROM Tournament__c
                WHERE (Status__c = 'Active' OR Status__c = 'Pending') 
                AND CreatedDate = TODAY
            ];
        } else {
            tournaments = [
                SELECT Id, Status__c, Name, Winning_Team__c
                FROM Tournament__c
                WHERE (Status__c = 'Active' OR Status__c = 'Pending')
            ];
        }

        return Tournament.wrap(tournaments);
    }

    public static Tournament createNewTournament(String status) {
        Tournament__c tn = new Tournament__c(Status__c = status);
        INSERT tn;
        tn = [SELECT Id, Name, Status__c FROM Tournament__c WHERE Id = :tn.Id];
        return Tournament.wrap(tn);
    }
}
