@isTest
public without sharing class DataFactoryApplication {
	public static TargetX_SRMb__Application__c createApplication() {
		// Create a single application 
		Integer contactYear = DataFactoryContactYears.createContactYears()[0];
		String contactTerm = DataFactoryContactTerms.createContactTerms()[0];

		TargetX_SRMb__Application__c application = new TargetX_SRMb__Application__c(
			IIT_Application_Start_Date__c = System.today(), 
			TargetX_SRMb__Start_Term_Year__c = string.valueof(contactYear),
			TargetX_SRMb__Start_Term__c = contactTerm,
			TargetX_SRMb__Stage__c = 'In Progress',
			TargetX_SRMb__Application_Decision__c = 'Admit'
		);

		return application;
	}
	
	public static TargetX_SRMb__Application__c createApplicationWithProgram() {
		// Creates an application object with the degree and major fields populated from a
		// program object
		IIT_Program__c program = DataFactoryPrograms.createBSProgram();
		Integer contactYear = DataFactoryContactYears.createContactYears()[0];
		String contactTerm = DataFactoryContactTerms.createContactTerms()[0];

		TargetX_SRMb__Application__c application = new TargetX_SRMb__Application__c(
			IIT_Application_Start_Date__c = System.today(), 
			TargetX_SRMb__Start_Term_Year__c = string.valueof(contactYear), 
			TargetX_SRMb__Start_Term__c = contactTerm,
			TargetX_SRMb__Degree__c = program.IIT_Degree__c, 
			TargetX_SRMb__Possible_Academic_Major__c = program.IIT_Major__c,
			TargetX_SRMb__Stage__c = 'In Progress',
			TargetX_SRMb__Application_Decision__c = 'Admit'
		);

		return application;
	}
	
	public static List<TargetX_SRMb__Application__c> createApplicationsList(Integer numberOfApplications) {
		// creates a list of application objects
		List<TargetX_SRMb__Application__c> applications = new List<TargetX_SRMb__Application__c>();
		Integer contactYear = DataFactoryContactYears.createContactYears()[0];
		String contactTerm = DataFactoryContactTerms.createContactTerms()[0];
		
		for(Integer i = 0; i < numberOfApplications; i++) {
			TargetX_SRMb__Application__c application = new TargetX_SRMb__Application__c(
				IIT_Application_Start_Date__c = System.today(), 
				TargetX_SRMb__Start_Term_Year__c = string.valueof(contactYear),
				TargetX_SRMb__Start_Term__c = contactTerm,
				TargetX_SRMb__Stage__c = 'In Progress',
				TargetX_SRMb__Application_Decision__c = 'Admit'
			);
			applications.add(application);
		}
		
		return applications;
	}
	
	public static void addContactToApplication(Contact contact, TargetX_SRMb__Application__c application) {
		// add a contact ID to an existing application object
		
		// The contact record must have an ID in order to relate to the Application object
		system.assert(contact.id != null, 'Contact object does not contain an ID field'); 
		
		application.TargetX_SRMb__Contact__c = contact.id;
	}
	
	public static void addContactListToApplicationList(List<Contact> contacts, List<TargetX_SRMb__Application__c> applications) {
		// add contact IDs to an exsiting list of application objects
		
		// The contact records must all have IDs and the size of each list of objects should match
		for(Contact c : contacts) {
			system.assert(c.id != null);
		}
		system.assert(contacts.size() == applications.size());
		
		for(Integer i = 0; i < applications.size(); i++) {
			applications[i].TargetX_SRMb__Contact__c = contacts[i].id;
		}
	}
	
	@isTest
	public static void testInsertApp() {
		// temporary test method to see how some funcitonality works.
		Contact contact = DataFactoryContact.createContact();
		
		TargetX_SRMb__Application__c application = DataFactoryApplication.createApplication();
		
		
		Database.SaveResult sr = Database.insert(contact);
		IITDatabaseTestTools.checkForSuccessfulSaveResult(sr);
		
		DataFactoryApplication.addContactToApplication(contact, application);
		sr = Database.insert(application);
		IITDatabaseTestTools.checkForSuccessfulSaveResult(sr);
		
		DataFactoryContact.addApplicationToContact(application, contact);
		
		system.debug('Contact ID: ' + contact.id + '\nApplication ID: ' + contact.TGTX_Master_Application__c
					+ '\nApplication start date: ' + application.IIT_Application_Start_Date__c);
	}
	
	
	public static List<TargetX_SRMb__Application__c> createAndInsertApplicationsWithContact(List<Contact> contacts, Integer numberOfApplications) {
		// creates applications, associates a contact id with each application, and inserts the applications into the database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createApplicationsList(numberOfApplications);
		DataFactoryApplication.addContactListToApplicationList(contacts, applications);
		Database.SaveResult[] saveApplicationsResult = Database.insert(applications, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveApplicationsResult);
		
		return applications;
	}
	
	public static void linkApplicationsForClone(List<TargetX_SRMb__Application__c> applications) {
		// Iterate through a list of application objects and set parent IDs to point to previous applications in order to test cloning procedures
		TargetX_SRMb__Application__c firstApplication = null,
									 secondApplication = null;
									 
		for(TargetX_SRMb__Application__c a : applications) {
			// check that the application has an ID
			system.assert(a.id != null);
			
			if(firstApplication == null) {
				// If the first application is unset, set it to the current application and move to the next item in the list
				firstApplication = a;
			} else {
				// If the first application has been set, assign the current application to secondApplication, set the parent of secondApplication to 
				// the ID of firstApplication
				secondApplication = a;	
				secondApplication.IIT_Previous_Application__c = firstApplication.id;
				
				// After the parent ID has been assigned, reset firstApplication and secondApplication to null so that the process of setting a parent and child application begins again
				firstApplication = null;
				secondApplication = null;
			}
		}
	}
}