public without sharing class TournamentBuilder {

    public static Tournament buildTournament(Set<Id> playerIds, Integer countPerTeam) {
        List<List<Id>> groupedPlayerIds = TeamBuilder.groupPlayersInTeam(playerIds, countPerTeam);
        List<Team> teams = TeamBuilder.buildOrRetrieveTeams(groupedPlayerIds);
        Tournament tn = Tournaments.createNewTournament('Pending');
        return tn.setMatches(MatchBuilder.buildMatches(tn, teams));
    }
}
