public with sharing class ApplicationHandler {
    
    public static void nameUpdate(List<Application__c> appList) {
        
        Set<Id> posIds = new Set<Id>();
        Set<Id> canIds = new Set<Id>();

        Map<Id, String> posNames = new Map<Id, String>();
        Map<Id, String> canFNames = new Map<Id, String>();
        Map<Id, String> canLNames = new Map<Id, String>();

        for (Application__c app : appList) {
            posIds.add(app.Position__c);
            canIds.add(app.Candidate__c);
        }
        for (Position__c pos : [Select Id, Name From Position__c where id in :posIds]) {
            posNames.put(pos.Id, pos.Name);
        }
        for (Contact con : [Select Id, FirstName, LastName from Contact where Id in :canIds]) {
            canFNames.put(con.Id, con.FirstName);
            canLNames.put(con.Id, con.LastName);
        }
        for (Application__c app : appList) {
            app.Name = posNames.get(app.Position__c) + '-' + canFNames.get(app.Candidate__c) + ' ' +
            canLNames.get(app.Candidate__c);
        }
    }
}