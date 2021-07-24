public with sharing class TournamentDashboardController {
    @AuraEnabled
    public static List<Tournament> getActiveOrPendingTournaments(Boolean includeOnlyTodays){
        try {
            return Tournaments.getActiveOrPendingTournaments(includeOnlyTodays);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Tournament buildTournament(){
        try {
            return TournamentBuilder.getActiveOrPendingTournaments(includeOnlyTodays);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
