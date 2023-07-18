public with sharing class PositionDisplayReviews_EXT {
    //create a variable to hold the current position record
    public final Position__c pos;

    //override the class constructor to identify it as a visualforce controller extension
    public PositionDisplayReviews_EXT(ApexPages.StandardController stdController) {
        //retrieve the postion record from the pate
        this.pos =(Position__c) stdController.getRecord();

    }
    // create a property to bind to my vf page
    public List<Review__c> reviews {
        // getter method to return the records 
        get {
            if (reviews == NULL) {
                reviews = [Select Cultural_fit__c, Business_Skills__c, Technical_Skills__c, Recommended__c 
            From Review__c Where Application__r.Position__c = :pos.Id ];
            }
            return reviews;
        }
       // set setter method to private -- private makes it read only
        private set;
    }
}