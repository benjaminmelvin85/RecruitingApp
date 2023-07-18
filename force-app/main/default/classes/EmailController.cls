public with sharing class EmailController {
    // override the constructor
    public Application__c application= new Application__c();
    public EmailController(ApexPages.StandardController sc) {
        application = (Application__c)sc.getRecord();
        loadApp();
    }
    private void loadApp() {
        application = [select id, Candidate__C, Position__r.Description__c, Position__r.Name From Application__c where Id = :application.id limit 1];
    }
    //method to create an email record and insert it into the database
    //this will kick off the our workflow email alert and redirect back to the original page
    public Pagereference emailApplication() {
        email__c e = new Email__c();
        e.Application__c = application.id;
        e.Contact__c = application.Candidate__c;
        e.Description__c = application.Position__r.Description__c;
        e.Position_Name__c = application.Position__r.Name;
        system.debug(e);
        insert e;
        Pagereference pr = new Pagereference('/' + application.id);
        return pr;
    }
}