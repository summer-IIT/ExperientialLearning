@isTest
public without sharing class DataFactoryContact {
    public static Contact createContact() {
        // Create a single contact with basic data
        Contact contact = DataFactoryContact.createContactsList(1)[0];

        return contact;
    }

    public static List<Contact> createContactsList(Integer numberOfContacts) { 
    // generates contacts for use in testing
    // Contact Section
        List<Contact> contacts = new List<Contact>(); //List of contacts for insert
        
        for(Integer i = 0; i < numberOfContacts; i++) {//Iterate through number of contacts to generate
            Contact contactToGenerate = new Contact(LastName = 'IITTest' + string.valueof(i)
            , Email = 'IITTest' + String.valueof(i) + '@iit.fake'
            , Phone = '5555551' + (i >= 100 ? String.valueof(i) : (i >= 10 ? '0' + String.valueof(i) : '00' + string.valueof(i) ) )
            , OtherPhone = '5555552'  + (i >= 100 ? string.valueof(i) : (i >= 10 ? '0' + String.valueof(i) : '00' + string.valueof(i) ) )
            , MailingStreet = 'Test' + String.valueof(i)
            , MailingCity = 'Timbuktu' + String.valueof(i)
            , MailingState = 'Invalid' + String.valueof(i)
            , MailingPostalCode = '605' + String.valueof(i)
            , MailingCountry = 'India' + String.valueof(i)
            , TargetX_SRMb__MailingCounty__c = 'County'  + String.valueof(i)
            , TargetX_SRMb__Student_Type__c = 'First Year'
            );
            
            contacts.add(contactToGenerate);
        }
        
        return contacts;
    }

    public static List<Contact> createContactsWithProgramStageYearTermList(Integer numberOfContacts) {
        // Create a list of contacts that include program data

        // Populate a list of contacts with basic data
        List<Contact> contacts = DataFactoryContact.createContactsList(numberOfContacts);

        // Create program, stage, year, and term objects
        // For Stage, Year, and Term only the first index is used
        IIT_Program__c program = DataFactoryPrograms.createBSProgram();
        String contactStage = DataFactoryContactStages.createContactStages()[0];
        Integer contactYear = DataFactoryContactYears.createContactYears()[0];
        String contactTerm = DataFactoryContactTerms.createContactTerms()[0];

        for(Contact contact : contacts) {
            contact.TargetX_SRMb__Degree__c = program.IIT_Degree__c;
            contact.TargetX_SRMb__Anticipated_Major__c = program.IIT_Major__c;
            contact.TargetX_SRMb__Stage_Date__c = system.today();
            contact.TargetX_SRMb__Status__c = contactStage;
            contact.TargetX_SRMb__Anticipated_Start_Year__c = contactYear;
            contact.TargetX_SRMb__Anticipated_Start_Term__c = contactTerm;
        }

        return contacts;

    }
    
    public static List<Contact> createContactsWithProgramAndRecruiterID(Integer numberOfContacts) {
        // Create a list of contacts that include programs as well as recruiter and merged recruiter IDs

        List<Contact> contacts = DataFactoryContact.createContactsWithProgramStageYearTermList(numberOfContacts);

        for(Contact contact : contacts) {
            // use any integer for Recruiter ID and Merged IDs
            contact.IIT_Recruiter_Contact_ID__c = String.valueof(numberOfContacts + 1);
            contact.IIT_Merged_Recruiter_IDs__c = String.valueof(numberOfContacts * numberOfContacts);
        }

        return contacts;
    }
    
	public static List<Contact> createContactsWithAttachments(Integer numberOfContacts) {
        // Generates contacts with attachments for use in testing
        
    	List<Contact> contacts = DataFactoryContact.createContactsList(numberOfContacts);
        List<Attachment> attachments = DataFactoryAttachment.createAttachmentsList(numberOfContacts);
        List<Id> contactsIds = new List<Id>(new Map<Id, Contact>(contacts).keySet());
        
        for(Integer i = 0; i < numberOfContacts; i++) {
        	attachments[i].ParentId = contactsIds[i];
        }

        return contacts;
    }
    
    public static void addApplicationToContact(TargetX_SRMb__Application__c application, Contact contact) {
		// add a application ID to an existing contact object
		
		// The contact record must have an ID in order to relate to the Application object
		system.assert(application.id != null, 'Application object does not contain an ID field'); 
		
		contact.TGTX_Master_Application__c = application.id;
	}
	
	public static void addApplicationListToContactList(List<TargetX_SRMb__Application__c> applications, List<Contact> contacts) {
		// add application IDs to an exsiting list of contact objects
		
		// The contact records must all have IDs and the size of each list of objects should match
		for(TargetX_SRMb__Application__c a : applications) {
			system.assert(a.id != null);
		}
		system.assert(contacts.size() == applications.size());
		
		for(Integer i = 0; i < contacts.size(); i++) {
			contacts[i].TGTX_Master_Application__c = applications[i].id;
		}
	}
		
	public static List<Contact> createAndInsertContacts(Integer numberOfContacts) {
		// Convenience method that wraps various test methods
		// creates a list of contact objects and inserts the objects into the database 
		List<Contact> contacts = DataFactoryContact.createContactsWithProgramAndRecruiterID(numberOfContacts);
		Database.SaveResult[] saveContactsResult = Database.insert(contacts, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveContactsResult);
		
		return contacts;
	}
}