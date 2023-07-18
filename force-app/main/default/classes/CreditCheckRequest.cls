Global class CreditCheckRequest {

    // create a method that makes an asynchornus to the credit check api
    @future(callout = true)
    public static void callCreditCheckApi(String accountId) {
        //parameters: account name, email of the requestor, and the name of the requestor
        //query database to retrieve the information about the account for these parameters
        Account a = [Select Id, Name, Owner.Name, Owner.Email From Account Where Id = :accountId Limit 1];
        //create string variable to hold the url and parameters for the endpoint
        String url = 'https://steve-wasula-splx201-dev-ed.my.salesforce-sites.com/creditcheck';
        //append the paramaters for the callout
        url += '?name=' +EncodingUtil.urlEncode(a.Name, 'UTF-8')
        + '&email=' + a.Owner.Email 
        + '&requestor=' + EncodingUtil.urlEncode(a.Owner.Name, 'UTF-8');

        //encode the url for the endpoint
        
        system.debug('URL: ' + url);

        //create an instance of the HTTP class for sending our request
        Http h = new Http();
        //create and instance of the HttpRequest class to send as the request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        //create a new HttpResponse to hold the response that is returned from the request
        HttpResponse response = h.send(req);
        system.debug(response);
        system.debug(response.getStatusCode());
        system.debug(response.getStatus());
        system.debug(response.getBody());

        if (response.getStatusCode() == 200) {
            system.debug('Callout returned successfully');
        } else {
            system.debug('Error occured with callout');
        }
    }

    
   
}