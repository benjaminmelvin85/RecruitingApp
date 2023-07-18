public with sharing class OppHandler {
    

    public static void updateOppName(List<Opportunity> oppList) {
        Set<Id> acctIds = new Set<Id>();

        Map<Id, String> acctNames = new Map<Id, string>();

        for (Opportunity opp : oppList) {
            acctIds.add(opp.AccountId);
        }
        for  (Account acct : [Select Id, Name From Account Where Id IN :acctIds]) {
            acctNames.put(acct.Id, acct.Name);
        }
        for (Opportunity opp : oppList) {
            opp.Name = acctNames.get(opp.AccountId) + '-' + opp.Type + '-' + opp.CloseDate.year() + opp.CloseDate.month();
        }
    }
}