public with sharing class QueueableClass implements Queueable {

    //implemenet the execute method from the queueable interface

    public void execute(QueueableContext con) {

        List<Account> acctsForUpdate = new List<Account>();

        for (Account a : [Select id, type from account where type = 'Customer - Direct']) {
            a.Type = 'Customer - Channel';
            acctsForUpdate.add(a);
        }
        update acctsForUpdate;
    }
    
}