public with sharing class ContactController {
    @AuraEnabled
    public static List<Contact> getContactList(Id accountId) {
        return [Select Id, Name, Title, Phone, Email From Contact Where AccountId = :accountId With SECURITY_ENFORCED];
    }
}