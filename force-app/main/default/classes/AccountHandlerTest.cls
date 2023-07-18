@isTest
private class AccountHandlerTest {
   
    @isTest static void testUpdateOppname() {

        //step 1 create my data to test
        Account a = new Account();
        a.Name = 'Test Account';
        insert a;

        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opp';
        opp.StageName = 'Prospecting';
        opp.type = 'New Customer';
        opp.CloseDate = Date.today().addMonths(2);
        opp.AccountId = a.Id;
        insert opp;

        //update my accournts name
        a.Name = 'New Test Account Name';
        update a;
        String updatedName = 'New Test Account Name-New Customer-' + Date.today().addMonths(2).year() + Date.today().addMonths(2).month();
        // make sure opportunity name updated
        Opportunity updatedOpp = [Select Name From Opportunity Where Id = :opp.id];
        System.assertEquals(updatedName, updatedOpp.Name);


    }
    // 2nd method to tests

    @isTest static void testCreatenewOprrFromAccount() {

        //create my test dat
        Account a = new Account();
        a.Name = '2nd Test';
        insert a;
        List<Account> accList = new List<Account>();
        accList.add(a);
        //call my method then verify the opp was created
        AccountHandler.createNewOppFromAccount(accList);

        Opportunity newOpp = [Select Name, StageName, Type, CloseDate, Accountid From Opportunity Where AccountId = :a.Id limit 1];
        List<Opportunity> relatedOpp = [Select Id, name from Opportunity Where accountId = :a.id];
        String accName = '2nd Test-New Customer-20238';
        system.assertEquals(accName, newOpp.Name);
        system.assertNotEquals(0, relatedOpp.size());

    }
    
    
}