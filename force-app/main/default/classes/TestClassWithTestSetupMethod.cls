@isTest
private class TestClassWithTestSetupMethod {
    
    @TestSetup
    private static void createTestData(){
        Position__c pos = new Position__c();
        pos.Name = 'Test Name';
        insert pos;         // inserting into the "test database"
        system.debug('Test Setup executed...');
    }

    @isTest private static void testMethod1() {
        system.debug('testMethod1 begins...');
        system.debug([SELECT Id FROM Position__c].size());

        Position__c pos = new Position__c();
        pos.Name = 'Test Name 2';
        insert pos;
        system.debug('Another record inserted...');
        system.debug([SELECT Id FROM Position__c].size());
    }

    @isTest private static void testMethod2() {
        system.debug('testMethod 2 begins...');
        system.debug([SELECT Id FROM Position__c].size());

        Position__c pos = [SELECT Id, Name FROM Position__c LIMIT 1];
        pos.Name = 'Testy McTesterson';
        update pos;

        Position__c posAgain = [SELECT Id, Name FROM Position__c WHERE Id = :pos.Id LIMIT 1];
        system.debug(posAgain.Name);
    }

    @isTest private static void testMethod3() {
        system.debug('testMethod3 begins...');
        Position__c pos = [SELECT Id, Name FROM Position__c LIMIT 1];
        system.debug(pos.Name);
    }
}