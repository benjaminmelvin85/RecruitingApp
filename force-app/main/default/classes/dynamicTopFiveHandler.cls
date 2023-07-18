public with sharing class dynamicTopFiveHandler {
    @AuraEnabled (cacheable=true) public static List<sObject> topFiveQuerier(String objectName, String fieldName) {
        String queryString = 'SELECT id, Name,' + fieldName + ' FROM ' + objectName + ' ORDER BY ' + fieldName + ' desc LIMIT 5';
        system.debug(queryString);
        return Database.query(queryString);
        
    }
}