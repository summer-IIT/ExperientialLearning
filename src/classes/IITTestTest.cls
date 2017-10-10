@isTest
public without sharing class IITTestTest {
	@isTest
	public static void testTestHandler() {
		// Create objects and test the trigger(s) operating on the test object
		final Integer NUM_ACCOUNTS = 5;
		final Integer NUM_CONTACTS = 5;
		final Integer NUM_APPLICATIONS = 5;
		final Integer NUM_TEST_PER_CONTACT = 5;
		
		// Create program objects and insert into database for later use
		List<IIT_Program__c> programList = DataFactoryPrograms.createAndInsertPrograms();
		
		// Create account objects and insert into database for later use
		List<Account> accounts = DataFactoryAccount.createAndInsertAccounts(NUM_ACCOUNTS);
		
		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create test objects and insert into the database
		List<TargetX_SRMb__Test__c> tests = DataFactoryTest.createAndInsertTestsWithContacts(contacts, NUM_TEST_PER_CONTACT);
	}
}