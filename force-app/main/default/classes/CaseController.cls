public with sharing class CaseController {
    
    @AuraEnabled(cacheable=true)
    public static List<Case> getCases (String accountId) {
        List<Case> cases = new List<Case>();

        cases = [SELECT Id, CaseNumber, Subject, Status, Priority FROM Case WHERE AccountId = :accountId WITH SECURITY_ENFORCED];

        return cases;
    }

    @AuraEnabled(cacheable=true)
    public static List<Case> getAllCases() {
        return [SELECT Id, CaseNumber, Subject, Status, Priority FROM Case WITH SECURITY_ENFORCED];
    }
}