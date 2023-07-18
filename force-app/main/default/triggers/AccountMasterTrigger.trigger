trigger AccountMasterTrigger on Account (
    before insert, after insert, 
    before update, after update,
    before delete, after delete, after undelete) {


        
        if (Trigger.isBefore) {
            if (Trigger.isInsert) {

            } 
            if (Trigger.isUpdate) {

            } 
            if (Trigger.isDelete) {

            } 
        } 
        if (Trigger.isAfter) {
            if (Trigger.isInsert) {
                AccountHandler.createNewOppFromAccount(trigger.new);
            } 
            if (Trigger.isUpdate) {
                AccountHandler.updateOppName(trigger.new, trigger.oldMap);
            } 
            if (Trigger.isDelete) {

            } 
            if (Trigger.isUndelete) {

            }
        }  
}