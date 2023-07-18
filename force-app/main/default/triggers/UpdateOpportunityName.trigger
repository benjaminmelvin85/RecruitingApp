trigger UpdateOpportunityName on Opportunity (before insert, before update) {

    Set<Id> acctIds = new Set<Id>();

    Map<Id, String> acctNames = new Map<Id, string>();

    for (Opportunity opp : trigger.new) {
        acctIds.add(opp.AccountId);
    }
    for  (Account acct : [Select Id, Name From Account Where Id IN :acctIds]) {
        acctNames.put(acct.Id, acct.Name);
    }
    for (Opportunity opp : trigger.new) {
        opp.Name = acctNames.get(opp.AccountId) + '-' + opp.Type + '-' + opp.CloseDate.year() + opp.CloseDate.month();
    }
}