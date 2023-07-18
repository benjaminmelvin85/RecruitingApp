global class UpdateAllOpps implements Schedulable{
    //implement the execute method to schedule a batch apex class to run

    global void execute(SchedulableContext sc) {
        // call executebatch method and pass a new instance of my batch class as an argument

        Id batchInstanceId = Database.executebatch(new UpdateOppBatch());
        system.debug('Batch Id: ' + batchInstanceId);

    }
   
}