trigger ApplicationMasterTrigger on Application__c (
    before insert, after insert, 
    before update, after update,
    before delete, after delete, after undelete) {


        
        if (Trigger.isBefore) {
            if (Trigger.isInsert) {
                ApplicationHandler.nameUpdate(trigger.new);

            } 
            if (Trigger.isUpdate) {
                ApplicationHandler.nameUpdate(trigger.new);

            } 
            if (Trigger.isDelete) {

            } 
        } 
        if (Trigger.isAfter) {
            if (Trigger.isInsert) {
              
            } 
            if (Trigger.isUpdate) {
               
            } 
            if (Trigger.isDelete) {

            } 
            if (Trigger.isUndelete) {

            }
        }  
}

