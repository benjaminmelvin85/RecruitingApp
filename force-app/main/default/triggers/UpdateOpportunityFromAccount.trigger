trigger UpdateOpportunityFromAccount on Account (after update) {

    //create a set to hold account ids where the name field has changed

    Set<Id> acctIds = new Set<Id>();

    //iterate over the updated account records (trigger.new) and check to see if name has changed

    for (Account acct : trigger.new) {

        //compare new name value against old name value (trigger.oldmap) to see if it changed
        if (acct.Name != trigger.oldMap.get(acct.Id).Name) {
        acctIds.add(acct.Id);
        }
    }
        //if my set of ids has any values, retrieve the related opportunity for those accounts and update them
        if (!acctIds.isEmpty()) {
            List<Opportunity> oppToUpdate = new List<Opportunity>();

            for (Opportunity opp : [Select Id From Opportunity Where AccountId in :acctIds]) {
                oppToUpdate.add(opp);
            }
            update oppToUpdate;
        }

}