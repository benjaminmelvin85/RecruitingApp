trigger PositionMasterTrigger on Position__c (
    before insert, after insert, 
    before update, after update,
    before delete, after delete, after undelete) {

        if (Trigger.isBefore) {
            if (Trigger.isInsert) {

            } 
            if (Trigger.isUpdate) {

            } 
            if (Trigger.isDelete) {
                PositionHandler.checkPositionDeletion(trigger.old);
            } 
        } 
        if (Trigger.isAfter) {
            if (Trigger.isInsert) {
                PositionHandler.newInterviewerRecord(trigger.new);
                PositionHandler.sharePositions(trigger.new);
            } 
            if (Trigger.isUpdate) {
                PositionHandler.setAppsToClosed(trigger.new, trigger.oldMap);
                PositionHandler.sharePositions(trigger.new);
            } 
            if (Trigger.isDelete) {

            } 
            if (Trigger.isUndelete) {

            }
        }  
}