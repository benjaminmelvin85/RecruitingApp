public with sharing class InterviewerHandler {
    
    public static void nameUpdate(List<Interviewer__c> interviewerList) {
        
        Set<Id> posIds = new Set<Id>();
        Set<Id> intIds = new Set<Id>();

        Map<Id, String> posNames = new Map<Id, String>();
        Map<Id, String> userFNames = new Map<Id, String>();
        Map<Id, String> userLNames = new Map<Id, String>();

        for (Interviewer__c inter : interviewerList) {
            posIds.add(inter.Position__c);
            intIds.add(inter.Interviewer__c);
        }
        for (Position__c pos : [Select Id, Name From Position__c where id in :posIds]) {
            posNames.put(pos.Id, pos.Name);
        }
        for (User con : [Select Id, FirstName, LastName from User where Id in :intIds]) {
            userFNames.put(con.Id, con.FirstName);
            userLNames.put(con.Id, con.LastName);
        }
        for (Interviewer__c inter : interviewerList) {
            inter.Name = posNames.get(inter.Position__c) + '-' + userFNames.get(inter.Interviewer__c) + ' ' +
            userLNames.get(inter.Interviewer__c);
        }
    }
}