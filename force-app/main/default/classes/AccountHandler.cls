public with sharing class AccountHandler {
    
    // create a method that will update the opportunity name whenever the account changes
    public static void updateOppName(List<Account> acctList, Map<id, Account> oldAcctmap) {
        
        Set<Id> acctIds = new Set<Id>();

        //iterate over the updated account records (trigger.new) and check to see if name has changed
    
        for (Account acct : acctList) {
    
            //compare new name value against old name value (trigger.oldmap) to see if it changed
            if (acct.Name != oldAcctmap.get(acct.Id).Name) {
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

    //create a method that will create a new opportunity record for any new Account created

    public static void createNewOppFromAccount(List<Account> acctList) {
        List<Opportunity> newOpportunity = new List<Opportunity>();

        for (Account acc : acctList) {

            Opportunity opp = new Opportunity();
            opp.Name = 'New Opportunity';
            opp.StageName = 'Prospecting';
            opp.Type = 'New Customer';
            opp.CloseDate = Date.Today().addMonths(2);

            opp.AccountId = acc.Id;

            newOpportunity.add(opp);

    }
        if (!newOpportunity.isEmpty()) {
            insert newOpportunity;
    }
    }
}