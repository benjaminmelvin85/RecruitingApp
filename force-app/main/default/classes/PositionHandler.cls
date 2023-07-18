public class PositionHandler {
    
    //create a method that accepts a list of Position records and if the status is closed 
    //sets related application records to a status of closed as well

    public static void setAppsToClosed(List<Position__c> posList, Map<Id, Position__c> posMap) {

            // need a list to hold applications to be updated
            List<Application__c> appsToUpdate = new List<Application__c>();
            // create a set to hold the position ids for the positions where the status changed from something to clowed

            Set<Id> posIds = new Set<Id>();
            Set<Id> posIds2 = new Set<Id>();
            // iterate over the position records, and add teh IDs to my set for the positions where teh status changed to clsed
            for (Position__c pos : posList) {
                //check the status of the records against the old value of the status
                if (pos.Status__c == 'Closed' && posMap.get(pos.Id).Status__c != 'Closed') {
                    posIds.add(pos.Id);
                } else if (pos.Status__c != 'Closed' && posMap.get(pos.Id).Status__c == 'Closed') {
                    posIds2.add(pos.id);
                }
            }
            for (Application__c app : [Select Id, Status__c from Application__c Where Position__c in :posIds2]) {
                app.Status__c = 'Applied';
                appsToUpdate.add(app);
            }

            //query database to return the related application records for the positions in my set
            for (Application__c app : [Select id, Status__c from Application__c where Position__c in :posIds]) {
                app.Status__c = 'Closed';
                appsToUpdate.add(app);
            }
            //update the status of the application records, and update them in the database
            if(!appsToUpdate.isEmpty()) {
            database.update(appsToUpdate, false);
            }
    }
    public static void newInterviewerRecord(List<Position__c> posList) {

            List<Interviewer__c> newInterviewer = new List<Interviewer__c>();

            for (Position__c pos : posList) {
                interviewer__c intv = new Interviewer__c();
                intv.Name = 'Interviewer 1';
                intv.Interviewer__c = pos.Hiring_Manager__c;
                intv.Position__c = pos.Id;

                newInterviewer.add(intv);

            }

                if(!newInterviewer.isEmpty()) {
                    insert newInterviewer;
                }

    }
    // create a method to stop the deletion of position records
    public static void checkPositionDeletion(List<Position__c> posList) {
        //itereate over the position records, and if the status is not closed, stope the 
        // deletion 

        for (Position__c pos : PosList) {

            if (pos.Status__c != 'Closed') {
                pos.Status__c.addError('Cannot delete a position record that is not closed.');
            }
        }
    }
    // create a method to share Position records with the Hiring Manager

    // create a method to share Position records with the Hiring Manager
    public static void sharePositions(List<Position__c> posList) {

        // create a list to hold my Position__Share entries
        List<Position__Share> posShareList = new List<Position__Share>();

        //get ID for the SVP of customer service role

        Id SVP = [Select Id, DeveloperName from Group Where DeveloperName = 'SVPCustomerServiceSupportA' Limit 1].id;

        // iterate over the Position records and create entries in the Position Share Table
        for (Position__c pos : posList) {
            // if the position doesn't have a hiring manager assigned, skip to the next record (iteration of the loop).
            if (pos.Hiring_Manager__c == NULL) {
                continue;
            }

            // create an instance of the Position__Share object
            Position__Share posShare = new Position__Share();

            // populate the fields for the share entry
            posShare.ParentId           = pos.Id;                   // ID of the record being shared
            posShare.UserOrGroupId      = pos.Hiring_Manager__c;    // ID of person(group) being shared with
            posShare.RowCause           = 'Hiring_Manager__c';         // reason record is being shared

            // check what level of access to give based off of Position status
            if (pos.Status__c == 'New') {
                posShare.AccessLevel    = 'Edit';
            } else {
                posShare.AccessLevel    = 'Read';
            }

            // add the Position Share entry to the list
            posShareList.add(posShare);

            // create an entry for SVP customer service
            posShare = new position__Share(); //reintitializing variable
            posShare.ParentId = pos.id;
            posShare.UserOrGroupId = SVP;
            posShare.RowCause = 'Manual';
            posShare.AccessLevel = 'Edit';
            PosShareList.add(posShare);
        }

        // check for entries in the list, and if there are some, insert them into the database
        if (!posShareList.isEmpty()) {
            insert posShareList;
        }
    }
}