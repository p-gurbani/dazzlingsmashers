public without sharing class TeamBuilder {

    public static List<List<Id>> groupPlayersInTeam(Set<Id> playerIds, Integer countPerTeam) {
        if(playerIds == null || countPerTeam == null || playerIds.isEmpty()) {
            return new List<List<Id>>();
        }
        // Convert the Set to a list
        List<Id> lstPlayerIds = new List<Id>(playerIds); 
        Set<Id> playerIdsAdded = new Set<Id>();

        List<List<Id>> result = new List<List<Id>>();

        Integer arrayLength = lstPlayerIds.size(); 
        Integer lstIndex = 0;

        CollectionUtil.randomizeList(lstPlayerIds);

        for(Id playerId : lstPlayerIds) {
            if(result.size() < lstIndex + 1) {
                result.add(new List<Id>());
            }
            if(result[lstIndex].size() >= countPerTeam) {
                lstIndex++;
                result.add(new List<Id>());
            }
            result[lstIndex].add(playerId);
        }

        return result;
        
    }

    public static List<Team> buildOrRetrieveTeams(List<List<Id>> groupedContactIds) {
        List<Id> allContactIds = (List<Id>)CollectionUtil.unfoldListOfListsOfId(groupedContactIds);
        List<Team__c> teams = retrieveTeams(allContactIds);
        Map<List<Id>, Team__c> existingTeamsMap = getExistingTeamsMap(groupedContactIds, teams);
        List<List<Id>> teamsToCreate = new List<List<Id>>();
        for(List<Id> grp : groupedContactIds) {
            if(!existingTeamsMap.containsKey(grp)) {
                teamsToCreate.add(grp);
            }
        }
        List<Team> allTeams = Team.wrap(existingTeamsMap.values());
        allTeams.addAll(buildNewTeams(teamsToCreate));
        return allTeams;
    }

    public static List<Team> buildNewTeams(List<List<Id>> groupedContactIds) {
        Integer groupCount = groupedContactIds.size();
        List<Team__c> teamsToCreate = new List<Team__c>();

        for(Integer i = 0; i < groupCount; i++) {
            teamsToCreate.add(new Team__c());
        }

        INSERT teamsToCreate;

        List<Player_In_Team__c> playersInTeamsToCreate = new List<Player_In_Team__c>();
        for(Integer i = 0; i < groupCount; i++) {
            Team__c tm = teamsToCreate[i];
            List<Id> grp = groupedContactIds[i];
            for(Id contactId : grp) {
                playersInTeamsToCreate.add(new Player_In_Team__c(
                    Team__c = tm.Id,
                    Person__c = contactId
                ));
            }
        }

        INSERT playersInTeamsToCreate;
        return Team.wrap(retrieveTeams((List<Id>)CollectionUtil.unfoldListOfListsOfId(groupedContactIds)));
    }

    private static Map<List<Id>, Team__c> getExistingTeamsMap(List<List<Id>> groupedContactIds, List<Team__c> teams) {
        Map<List<Id>, Team__c> existingTeamsMap = new Map<List<Id>, Team__c>();
        for(Team__c t : teams) {
            List<Id> playerContactIds = getPlayerContactIds(t.Players_In_Team__r);
            for(List<Id> grp : groupedContactIds) {
                Boolean isTeamMatched = true;
                if(grp.size() == playerContactIds.size() && !playerContactIds.isEmpty()) {
                    for(Id contactId : grp) {
                        if(!playerContactIds.contains(contactId)) {
                            isTeamMatched = false;
                        }
                    }
                } else {
                    isTeamMatched = false;
                }
                if(isTeamMatched) {
                    existingTeamsMap.put(grp, t);
                } 
            }
        }
        return existingTeamsMap;
    }

    private static List<Id> getPlayerContactIds(List<Player_In_Team__c> playersInTeams) {
        List<Id> playerContactIds = new List<Id>();
        for(Player_In_Team__c pit : playersInTeams) {
            playerContactIds.add(pit.Person__c);
        }
        return playerContactIds;
    }

    public static List<Team__c> retrieveTeams(List<Id> contactIds) {
        return [
            SELECT Id, Name, Team_Name__c,
            (SELECT Id, Name, Team__c, Person__c FROM Players_In_Team__r)
            FROM Team__c
            WHERE Id IN (SELECT Team__c FROM Player_In_Team__c WHERE Person__c IN :contactIds AND Team__c != null)
        ];
    }
    
}
