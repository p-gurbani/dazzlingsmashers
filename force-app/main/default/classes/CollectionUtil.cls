public inherited sharing class CollectionUtil {
    public static List<Id> unfoldListOfListsOfId(List<List<Id>> listOfLists) {
        List<Id> lst = new List<Id>();
        for(List<Id> grpLst : listOfLists) {
            lst.addAll(grpLst);
        }
        return lst;
    }

    public static List<Object> randomizeList(List<Object> lst) {
        Integer currentIndex = lst.size();
        Object temporaryValue;
        Integer randomIndex;
        // While there remain elements to shuffle...
        while (0 != currentIndex) {
        // Pick a remaining element...
            randomIndex = Integer.valueOf(Math.floor(Math.random() * currentIndex));
            currentIndex -= 1;
            // And swap it with the current element.
            temporaryValue = lst[currentIndex];
            lst[currentIndex] = lst[randomIndex];
            lst[randomIndex] = temporaryValue;
        }
        return lst;
    }
}
