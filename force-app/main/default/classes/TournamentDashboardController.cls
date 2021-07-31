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
    public static Tournament buildTournament(List<Id> playerIds, Integer countPerTeam){
        try {
            return TournamentBuilder.buildTournament(new Set<Id>(playerIds), countPerTeam);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
