public without sharing class AccountController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getTopAccounts() {
        return [Select Id, BillingStreet, BillingCity, BillingPostalCode, BillingState, Name, Phone, Website, AnnualRevenue From Account Where AnnualRevenue != null With SECURITY_ENFORCED ORDER BY AnnualRevenue DESC Limit 5];
    }
    
       
}