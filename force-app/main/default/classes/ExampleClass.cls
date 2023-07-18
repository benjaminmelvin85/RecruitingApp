public with sharing class ExampleClass {

    //create an instance variable

    public String myInstVar;

    //create a static variable

    public static string myStaticVar;
    // create a static method

    public static String myStaticMethod(String str1) {
        myStaticVar = str1;
        return myStaticVar;
    }

    // create an instance method
    public String myInstanceMethod() {
            myInstVar = myStaticVar;
        return myInstVar;
    }
    //overide our instance method
    public String myInstanceMethod(String str2) {
        myInstVar = str2;
    return myInstVar;
 }
 public String myInstanceValue() {
    return myInstVar;
 }

 public String myStaticValue() {
    return myStaticVar;

 }
 
}