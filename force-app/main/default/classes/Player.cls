public class Player {
    @AuraEnabled
    public String id;
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String playerName;
    @AuraEnabled
    public String teamId;
    @AuraEnabled
    public String contactId;

    public Player(String id, String name, String playerName, String contactId, String teamId) {
        this.id = id;
        this.name = name;
        this.playerName = playerName;
        this.contactId = contactId;
        this.teamId = teamId;
    }

    public static List<Player> wrap(List<Player_In_Team__c> playersInTeam) {
        List<Player> playersInTeamWrapped = new List<Player>();
        for(Player_In_Team__c pit : playersInTeam) {
            playersInTeamWrapped.add(
                new Player(pit.Id, pit.Name, pit.Person__r?.Name, pit.Person__c, pit.Team__c)
            );
        }
        return playersInTeamWrapped;
    }
}
