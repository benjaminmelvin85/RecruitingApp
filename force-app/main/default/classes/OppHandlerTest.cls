@isTest
private class OppHandlerTest {

    @isTest static void testUpdateOppname() {
    Account acc = new Account();
    acc.Name = 'Test Account';
    insert acc;  

    Opportunity opp = new Opportunity();
    opp.AccountId = acc.Id;
    opp.Name = 'Test Opp';
    opp.Type = 'Test';
    opp.CloseDate = Date.today().addDays(7);
    opp.StageName = 'Prospecting';
    insert opp;
        
    List<Opportunity> oppList = new List<Opportunity>();
        oppList.add(opp);
    OppHandler.updateOppName(oppList);
    

    system.assertEquals('Test Account-Test-' + Date.today().addDays(7).year() + Date.today().addDays(7).month(), oppList[0].Name);

    }
}