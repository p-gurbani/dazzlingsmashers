public class Match {
    @AuraEnabled
    public String id;
    @AuraEnabled
    public String matchNumber;
    @AuraEnabled
    public Team winningTeam;
    @AuraEnabled
    public List<Team> teams;
    @AuraEnabled
    public Integer teamsPerMatch;

    public Match(String id, String matchNumber, Team winningTeam) {
        this.id = id;
        this.matchNumber = matchNumber;
        this.winningTeam = winningTeam;
    }

    public static List<Match> wrap(List<Match__c> matches, Tournament tn) {
        List<Match> matchesWrapped = new List<Match>();
        for(Match__c mt : matches) {
            matchesWrapped.add(wrap(mt));
        }
        return matchesWrapped;
    }

    public static Match wrap(Match__c mt) {
        return new Match(mt?.Id, mt?.Name, null);
    }

    public Match setWinningTeam(Team winningTeam) {
        this.winningTeam = winningTeam;
        return this;
    }

    public Match setTeams(List<Team> teams) {
        this.teams = teams;
        return this;
    }

    public Match addTeam(Team t) {
        if(this.teams == null) {
            this.teams = new List<Team>();
        }
        this.teams.add(t);
        return this;
    }

    public Match setTeamsPerMatch(Integer teamsPerMatch) {
        this.teamsPerMatch = teamsPerMatch;
        return this;
    }
}
