public without sharing class MatchBuilder {
    public static Integer teamsPerMatch = 2;

    public static List<Match> buildMatches(Tournament tn, List<Team> teams) {
        Integer numberOfTeams = teams.size();
        Integer matchImperfectionNumber = Math.mod(numberOfTeams, teamsPerMatch);
        Integer numOfMatchesToCreate = getNumberOfMatchesToCreate(numberOfTeams, matchImperfectionNumber);
        List<Match> matches = createMatches(tn, numOfMatchesToCreate);
        CollectionUtil.randomizeList(matches);
        addTeamsToMatches(matches, teams);
        return matches;
    }

    private static void addTeamsToMatches(List<Match> matches, List<Team> teams) {
        Integer numberOfTeams = teams.size();
        List<Team_In_Match__c> teamInMatchesToCreate = new List<Team_In_Match__c>();
        Integer index = 0;
        for(Match m : matches) {
            m.setTeamsPerMatch();
            Integer teamsAddedToThisMatch = 0;
            while(index < numberOfTeams && teamsAddedToThisMatch < teamsPerMatch) {
                m.addTeam(teams[index]);
                teamInMatchesToCreate.add(new Team_In_Match__c(
                    Match__c = m.id,
                    Team__c = teams[index].id
                ));
                index++;
                teamsAddedToThisMatch++;
            }
        }
        INSERT teamInMatchesToCreate;
    }

    private static Integer getNumberOfMatchesToCreate(Integer teamSize, Integer matchImperfectionNumber) {
        return matchImperfectionNumber == 0 ? 
        teamSize / teamsPerMatch : 
        ((teamSize - matchImperfectionNumber) / teamsPerMatch) + 1;
    }

    private static List<Match> createMatches(Tournament tn, Integer numOfMatchesToCreate) {
        List<Match__c> matchesToCreate = new List<Match__c>();
        for(Integer i = 0; i < numOfMatchesToCreate; i++) {
            matchesToCreate.add(new Match__c(Tournament__c = tn.id));
        }
        INSERT matchesToCreate;
        List<Match__c> matchesInserted = [SELECT Id, Name, Tournament__c FROM Match__c WHERE Id IN :matchesToCreate];
        return Match.wrap(matchesInserted, tn);
    }


}
