@isTest
public without sharing class IITFinancialAidTest {
	@isTest
	public static void testFinancialAidHandler() {
		// Create objects and test the handler operating on the financial aid object
		final Integer NUM_CONTACTS = 5;
		final Integer NUM_APPLICATIONS = 5;
		final Integer NUM_FINANCIAL_AID_PER_APP = 5;
		
		// Create program objects and insert into database for later use
		List<IIT_Program__c> programList = DataFactoryPrograms.createAndInsertPrograms();
		
		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create financial aid objects associated with applicatoins and insert into database
		List<TargetX_SRMb__Financial_Aid__c> financialAids = DataFactoryFinancialAid.createAndInsertFinancialAidWithApplications(applications, NUM_FINANCIAL_AID_PER_APP);
		
		// Link application objects by parent ID and then test the copy methods used in cloning operations
		DataFactoryApplication.linkApplicationsForClone(applications);
		IITFinancialAidHandler.copyFinancialAidForApplication(applications, new Map<Id, Id>());
	}
}