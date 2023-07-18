@isTest
private class testRunas {
   @istest private static void testInterviewerInsertion() {

    User u = [Select id from User where FirstName like 'Be%' limit 1];
    Position__c pos = new Position__c();
    pos.Name = 'Test Position';
    pos.Hiring_Manager__c = u.id;
    pos.Status__c = 'New';
    
    User joe = [select id from user where FirstName like 'Joe%' limit 1];

    test.startTest();
    system.runAs(Joe) {
        insert pos;
    }


    test.stopTest();
    List<Interviewer__c> intList = [select id from interviewer__c];
    system.assert(intList.size() ==1);

   }
}