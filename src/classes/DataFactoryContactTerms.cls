@isTest
public without sharing class DataFactoryContactTerms {
    public static List<String> createContactTerms() { 
    // Creates a list of contact terms for use in generator
        List<String> contactTerms = new List<String>();
        contactTerms.add('Spring');
        contactTerms.add('Summer');
        contactTerms.add('Fall');
        return contactTerms;
    }
}