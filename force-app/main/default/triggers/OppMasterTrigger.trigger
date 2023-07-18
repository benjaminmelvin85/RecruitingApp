trigger OppMasterTrigger on Opportunity (
    before insert, after insert, 
    before update, after update,
    before delete, after delete, after undelete
) {
    if (trigger.isBefore) {
        if (trigger.isInsert) {
            OppHandler.updateOppName(trigger.new);

        }
        if (trigger.isUpdate) {
            OppHandler.updateOppName(trigger.new);

        }
        if (trigger.isDelete) {

        }

    }
    if(trigger.isAfter) {
        if (trigger.isInsert) {

        }
        if (trigger.isUpdate) {

        }
        if (trigger.isDelete) {
            
        }
        if (trigger.isUndelete) {

        }

    }

}