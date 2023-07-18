public with sharing class FutureClass {
   
    @future
    public static void futureAccountMethod(List<Id> ids) {
        List<Account> acctsForUpdate = new List<Account>();

        for (Account a : [Select Id, Name, Type From Account Where Id in :ids]) {
            a.Type = 'Customer - Direct';
            acctsForUpdate.add(a);
        }
        update acctsForUpdate;

    }
    
}