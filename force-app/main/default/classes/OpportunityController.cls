public with sharing class OpportunityController {
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(String accountId) {
        
        Return [Select Id, Name, StageName, CloseDate, Amount, AccountId, IsWon, IsClosed From Opportunity Where Accountid = :accountId With SECURITY_ENFORCED];

    }
}