@isTest
private class PositionHandlerTest {
    // create test method to test the insertion of an interviewer record for hiring manager
    
    @isTest static void testInterviewerFromHiringManager() {
        // create a position and insert it into the database
        Position__c pos = new Position__c();
        pos.Name = 'Test Position';
        pos.Status__c = 'New';
        pos.Hiring_Manager__c = [Select id from User where firstname like 'be%' limit 1].id;
        insert pos; // this is not actually commited to database

        Contact c = new Contact();
        c.FirstName = 'bob';
        c.LastName ='jones';
        insert c;
        Application__c app = new Application__c();
        app.Name = 'teset app';
       
        app.Position__c = pos.id;
        app.candidate__c = c.id;
        insert app;
        Interviewer__c intv = [select id, name from interviewer__c where Position__c = :pos.id limit 1];
        Assert.isNotNull(intv.Name);
        pos.Status__c = 'Closed';
update pos;
pos.Status__c = 'Open';
pos.description__c = 'tests';
update pos;

    }
    @isTest static void tesetPositionDeletion() {
        Position__c pos = new Position__c();
        pos.Name = 'Teset position';
        pos.description__c = 'a job';
        pos.Status__c = 'New';
        insert pos;
        pos.Status__c = 'Closed';
        update pos;
        delete pos;
    }
}