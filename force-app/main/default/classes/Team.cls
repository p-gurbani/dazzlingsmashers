public class Team {
    @AuraEnabled
    public String id;
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String teamNumber;
    @AuraEnabled
    public List<Player> playersInTeam;

    public Team(String id, String teamNumber) {
        this.id = id;
        this.teamNumber = teamNumber;
    }

    public Team setTeamName(String teamName) {
        this.name = teamName;
        return this;
    }

    public Team setPlayersInTeam(List<Player> players) {
        this.playersInTeam = players;
        return this;
    }

    public static List<Team> wrap(List<Team__c> teams) {
        List<Team> teamsWrapped = new List<Team>();
        for(Team__c t : teams) {
            teamsWrapped.add(
                new Team(t.Id, t.Name)
                .setTeamName(t.Team_Name__c)
                .setPlayersInTeam(Player.wrap(t.Players_In_Team__r))
            );
        }
        return teamsWrapped;
    }
}
