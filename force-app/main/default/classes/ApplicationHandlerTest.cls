@isTest
private class ApplicationHandlerTest {
   
    @isTest static void testUpdateAppName() {


        List<Position__c> posList = new List<Position__c>();
        Id hm = [SELECT Id FROM User WHERE FirstName LIKE 'Step%' LIMIT 1].Id;

        for (Integer i = 0; i < 500; i++) {
            Position__c pos = new Position__c();
            pos.Name = 'Test Position ' + i;
            pos.Description__c = 'Test Description';
            pos.Status__c = 'New';
            pos.Hiring_Manager__c = hm;

            posList.add(pos);
        }

        insert posList;

        // // create the data (application record) which will require a Contact record and a Position record
        // Position__c pos = new Position__c();
        // pos.Name = 'Test Position';
        // pos.Description__c = 'Test Description';
        // pos.Status__c = 'New';
        // pos.Hiring_Manager__c = [SELECT Id FROM User WHERE FirstName LIKE 'Step%' LIMIT 1].Id;

        // insert pos;

        List<Contact> cons = new List<Contact>();

        for (Integer i=0; i < 5; i++) {
            Contact c = new Contact();
            c.FirstName = 'First';
            c.LastName = 'Last' + i;
            cons.add(c);
        }

        insert cons;

        // insert cons;
        // Contact c = new Contact();
        // c.FirstName = 'John';
        // c.LastName = 'Galt';

        // insert c;

        List<Contact> consForApps = [SELECT Id FROM Contact];
        List<Application__c> appList = new List<Application__c>();
        Integer myIndex = 0;
        for (Position__c pos : [SELECT Id FROM Position__c]) {
            Application__c app = new Application__c();
            app.Name = 'Test';
            app.Position__c = pos.Id;
            system.debug('Index: ' + myIndex);
            app.Candidate__c = consForApps[myIndex].Id;
            myIndex++;

            if (myIndex >= consForApps.size()) {
                myIndex = 0;
            }

            appList.add(app);
        }

        insert appList;

        // Application__c app = new Application__c();
        // app.Name = 'Test';
        // app.Position__c = pos.Id;
        // app.Candidate__c = c.Id;


        // invoke whatever logic I'm testing
        //insert app;

        // verify my results (optional), but makes for a good test
        for (Application__c app : [SELECT Id, Name, Position__r.Name, Candidate__r.Name FROM Application__c]) {
            String testName = app.Position__r.Name + '-' + app.Candidate__r.Name;
            system.assertEquals(app.Name, testName);
        }
        
        
        // Application__c testApp = [SELECT Id, Name FROM Application__c WHERE Id = :app.Id LIMIT 1];

        // String testName = 'Test Position-John Galt';

        // system.assertEquals(testApp.Name, testName);

        // update app;
    }
}