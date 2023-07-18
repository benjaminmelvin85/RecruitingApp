public class ContactsListWithController {
    //variable to hold the sort order
    private String sortOrder = 'LastName';
    //method to return list of contacts
    public List<Contact> getContacts() {
        List<Contact> results = Database.query('select Id, FirstName, LastName, Title, Email ' +
        'From Contact ' +
        'Order By ' + sortOrder + ' ASC ' + 'Limit 10');
        return results;
    }
// method to set the sort order to last name
    public void sortByLastName() {
        this.sortOrder = 'LastName';
    }
    // method to set the sort order to firstname
    public void sortByFirstName() {
        this.sortOrder = 'FirstName';
    }
}