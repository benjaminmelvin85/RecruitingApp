public with sharing class CreditCheckContinuation {
    
    @AuraEnabled(Continuation=true cacheable=true)
    public static Object creditCheckApi(String accountId) {
        Account acct = [Select Id, Name, Owner.Name, Owner.Email From Account Where Id = :accountId Limit 1];

        String url = 'https://steve-wasula-splx201-dev-ed.my.salesforce-sites.com/creditcheck'; 
        url += '?name='+ EncodingUtil.urlEncode(acct.Name, 'UTF-8') + '&email=' + acct.Owner.Email + '&requestor=' + EncodingUtil.urlEncode(acct.Owner.Name, 'UTF-8');

        Continuation con = new Continuation(60);

        con.ContinuationMethod= 'processResponse';
        con.state = 'hello';

        HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod('GET');

        con.addHttpRequest(req);

        return con;
    }
    @AuraEnabled(cacheable=true)
    public static Object processResponse(List<String> labels, Object state) {
        HttpResponse response = Continuation.getResponse(labels[0]);
        return response.getBody();
        } 
     
}