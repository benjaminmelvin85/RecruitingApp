public with sharing class InterviewerController {

    private Id posId;           // private variable to hold the Position ID from the current page
    private Position__c pos;    // private variable to hold the Position record
    
    // overload the constructor to denote its use as a list controller extension
    public InterviewerController(ApexPages.StandardSetController ssc) { 
        posId = ApexPages.currentPage().getParameters().get('id');
        loadPosition();
    }

    // private method to retrieve the current Postion record
    private void loadPosition() {
        pos = [SELECT Id, Name FROM Position__c WHERE Id = :posId LIMIT 1];
    }

    // create a public property to hold the new Interviewer records
    public List<Interviewer__c> newInt {
        // getter
        get {
            if (newInt == NULL) {
                newInt = new List<Interviewer__c>();        // intialize the property

                // use a for loop to create 5 "empty" interviewers and add them to the property
                for (Integer i = 0; i < 5; i++) {
                    Interviewer__c intr = new Interviewer__c();
                    intr.Position__c = posId;
                    intr.Name        = 'Enter name...';

                    newInt.add(intr);
                }
            }

            return newInt;
        }

        // setter
        set {}
    }

    // override the save function(method) from the Standard Controller to save our new Interviewer records
    public PageReference save() {
        List<Interviewer__c> intvsToCreate = new List<Interviewer__c>();

        // check to see if we have interviewers and insert them into the database
        for (Interviewer__c intv : newInt) {
            if (intv.Interviewer__c != NULL) {
                intvsToCreate.add(intv);
            }
        }

        // check to see if I have any records to insert
        if(!intvsToCreate.isEmpty()) {
            insert intvsToCreate;
        }

        // return a page reference to navigate back to the Position page
        PageReference pr = new PageReference('/' + posId);
        return pr;
    }
}