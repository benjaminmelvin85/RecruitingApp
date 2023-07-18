trigger CreateOpportunityFromAccount on Account (after insert) {

    List<Opportunity> newOpportunity = new List<Opportunity>();

    for (Account acc : trigger.new) {

        Opportunity opp = new Opportunity();
        opp.Name = 'New Opportunity';
        opp.StageName = 'Prospecting';
        opp.Type = 'New Customer';
        opp.CloseDate = Date.Today().addMonths(2);

        opp.AccountId = acc.Id;

        newOpportunity.add(opp);

    }
    if (!newOpportunity.isEmpty()) {
        insert newOpportunity;
    }


}