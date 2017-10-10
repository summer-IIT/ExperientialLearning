@isTest
public without sharing class DataFactoryContactStages {
    public static List<String> createContactStages() { 
        // Creates a list of contact stages for use 
        List<String> contactStages = new List<String>();
        contactStages.add('Suspect');
        contactStages.add('Inquiry');
        contactStages.add('Registrant');
        contactStages.add('Applicant');
        contactStages.add('Application Submitter');
        contactStages.add('Admit');
        contactStages.add('Intent to Enroll');
        contactStages.add('Deposited');
        contactStages.add('Withdrawn');
        contactStages.add('Enrolled');
        return contactStages;
    }
}