public class UpdateOppBatch implements Database.Batchable<sObject> {

    // implement the start method to collect our records
    public Database.QueryLocator Start (Database.BatchableContext bc) {
        // collect the records to process

        return Database.getQueryLocator('SELECT Id, Name, Type, Account.Name, CloseDate FROM Opportunity');
    }


    // implemenet execute method to process the records collected by the start
        public void execute (Database.BatchableContext bc, List<Opportunity> opps) {
            List<Opportunity> oppsForUpdate = new List<Opportunity>();

            for (Opportunity o : opps) {
                o.Name = o.Account.Name +'-' + o.Type + '-' + o.CloseDate.year() + '/' + o.CloseDate.month();
                oppsForUpdate.add(o);
            }
            update oppsForUpdate;

        }

    //implement the finish method for post-processing lobic if any exists
    public void Finish (Database.BatchableContext bc) {
        system.debug('Finish method');
        system.debug('Id: ' + bc.getJobId());
        //retrieve the job info

        AsyncApexJob  job = [Select Id, Status, CreatedBy.Email From AsyncApexJob Where Id = :bc.getJobId() Limit 1];
        //create email message

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

        // populate the to address(es), subject, body of the email

        message.toaddresses = new String[] {job.Createdby.Email};
        message.subject = 'Async Job Info for: ' + job.Id;
        message.plaintextbody = 'Job Status: ' + job.Status;

        //create a list of singleEmailMessage to add our Message to and pass to sendEmail

        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();

        messages.add(message);

        // Send the email

        List<Messaging.SendEmailResult> results = Messaging.sendEmail(messages);

        //iterate over the results and check for success
        if (results[0].success) {
            system.debug('Email was sent successfully.');

        } else {
            system.debug('email failed: ' + results[0].errors[0].message);
        }
    }
    
}