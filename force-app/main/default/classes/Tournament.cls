public class Tournament {
    @AuraEnabled
    public String id;
    @AuraEnabled
    public String tournamentNumber;
    @AuraEnabled
    public Team winningTeam;
    @AuraEnabled
    public String status;
    @AuraEnabled
    public List<Match> matches;

    public Tournament(String id, String tournamentNumber, Team winningTeam) {
        this.id = id;
        this.tournamentNumber = tournamentNumber;
        this.winningTeam = winningTeam;
    }

    public static List<Tournament> wrap(List<Tournament__c> tns) {
        List<Tournament> tnsWrapped = new List<Tournament>();
        for(Tournament__c tn : tns) {
            tnsWrapped.add(wrap(tn));
        }
        return tnsWrapped;
    }

    public static Tournament wrap(Tournament__c tn) {
        return new Tournament(tn?.Id, tn?.Name, null).setStatus(tn.Status__c);
    }

    public Tournament setWinningTeam(Team winningTeam) {
        this.winningTeam = winningTeam;
        return this;
    }

    public Tournament setMatches(List<Match> matches) {
        this.matches = matches;
        return this;
    }

    public Tournament setStatus(String status) {
        this.status = status;
        return this;
    }
}
