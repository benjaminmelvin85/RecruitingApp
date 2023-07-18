@istest
public class TestDataFactory {
    
    public static List<Position__c> createPositions(Integer numToCreate) {

        List<Position__c> poslist = new List<Position__c>();

        for (integer i =1; i <=numToCreate; i++) { 
            Position__c pos = new Position__c();
            pos.Name = 'Test ' + i;
            poslist.add(pos);
        }
        return poslist;
    }
}