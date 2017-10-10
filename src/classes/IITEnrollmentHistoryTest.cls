@isTest
public without sharing class IITEnrollmentHistoryTest {
	@isTest
	public static void testEnrollmentHistoryTriggers() {
		// Create objects and test the trigger(s) operating on the enrollment history object
		final Integer NUM_ACCOUNTS = 5;
		final Integer NUM_CONTACTS = 5;
		final Integer NUM_APPLICATIONS = 5;
		final Integer NUM_HISTORY_PER_APP = 2;
		
		// Create program objects and insert into database for later use
		List<IIT_Program__c> programList = DataFactoryPrograms.createAndInsertPrograms();
		
		// Create account objects and insert into database for later use
		List<Account> accounts = DataFactoryAccount.createAndInsertAccounts(NUM_ACCOUNTS);
		
		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create enrollment history objects and insert into the database
		List<TargetX_SRMb__Enrollment_History__c> enrollmentHistories = DataFactoryEnrollmentHistory.createAndInsertEnrollmentHistoriesWithAppAndAcc(applications, accounts, NUM_HISTORY_PER_APP);
		
		// Create attachment objects for each enrollment history and insert into the database
		List<Attachment> attachments = IITEnrollmentHistoryTest.createAndInsertAttachmentsWithEnrollmentHistories(enrollmentHistories);
		
		// update and delete the attachments from the database
		Database.SaveResult[] updateAttachmentsResult = Database.update(attachments, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(updateAttachmentsResult);
		
		Database.DeleteResult[] deleteAttachmentResult = Database.delete(attachments, false);
		IITDatabaseTestTools.checkSuccessfulDeleteResultList(deleteAttachmentResult);
		
		// update and delete the enrollment histories from the database
		Database.SaveResult[] updateHistoriesResult = Database.update(enrollmentHistories, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(updateHistoriesResult);

		Database.DeleteResult[] deleteHistoriesResult = Database.delete(enrollmentHistories, false);
		IITDatabaseTestTools.checkSuccessfulDeleteResultList(deleteHistoriesResult);
	}
	
	@isTest
	public static void testEnrollmentHistoryHandler() {
		// create objects and test the enrollment history handler
		final Integer NUM_ACCOUNTS = 5;
		final Integer NUM_CONTACTS = 5;
		final Integer NUM_APPLICATIONS = 5;
		final Integer NUM_HISTORY_PER_APP = 2;
		
		// Create program objects and insert into database for later use
		List<IIT_Program__c> programList = DataFactoryPrograms.createAndInsertPrograms();
		
		// Create account objects and insert into database for later use
		List<Account> accounts = DataFactoryAccount.createAndInsertAccounts(NUM_ACCOUNTS);
		
		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create enrollment history objects and insert into the database
		List<TargetX_SRMb__Enrollment_History__c> enrollmentHistories = DataFactoryEnrollmentHistory.createAndInsertEnrollmentHistoriesWithAppAndAcc(applications, accounts, NUM_HISTORY_PER_APP);
		
		Set<Id> historyIds = new Map<ID, TargetX_SRMb__Enrollment_History__c>(enrollmentHistories).keySet();
		IITEnrollmentHistoryHandler.toggleRequirement(historyIds,false);
		IITEnrollmentHistoryHandler.toggleRequirement(historyIds,true);
	}
	
	@isTest
	public static void testReparentEnrollmentHistoryApplication() {
		// tests that the reparent function changes the application from a parent to the child application
		final Integer NUM_ACCOUNTS = 1;
		final Integer NUM_CONTACTS = 1;
		final Integer NUM_APPLICATIONS = 1;
		final Integer NUM_HISTORY_PER_APP = 2;
		
		List<Account> accounts = DataFactoryAccount.createAndInsertAccounts(NUM_ACCOUNTS);
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create 2 applications, a parent and child, and insert into database
		List<TargetX_SRMb__Application__c> parentApplication = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		List<TargetX_SRMb__Application__c> childApplication = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create enrollment history objects and insert into the database
		List<TargetX_SRMb__Enrollment_History__c> enrollmentHistories = DataFactoryEnrollmentHistory.createAndInsertEnrollmentHistoriesWithAppAndAcc(parentApplication, accounts, NUM_HISTORY_PER_APP);
		
		// Create attachment objects for each enrollment history and insert into the database
		List<Attachment> attachments = IITEnrollmentHistoryTest.createAndInsertAttachmentsWithEnrollmentHistories(enrollmentHistories);
		
		// Set the child application previous application field to the parent application and update the database
		childApplication[0].IIT_Previous_Application__c = parentApplication[0].id;
		Database.SaveResult[] updateResult = Database.update(childApplication);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(updateResult);

		// Reparent each enrollment history from the parent to child application, checking that before the function is called each history relates to the parent
		// and that afterwards each is related to the child
		for(TargetX_SRMb__Enrollment_History__c h : [SELECT TargetX_SRMb__Application__c FROM TargetX_SRMb__Enrollment_History__c WHERE TargetX_SRMb__Application__c = :parentApplication[0].id]) {
			System.assertEquals(parentApplication[0].id, h.TargetX_SRMb__Application__c);
		}
		System.assertEquals(NUM_HISTORY_PER_APP, Database.countQuery('SELECT count() FROM TargetX_SRMb__Enrollment_History__c'));
		
		IITEnrollmentHistoryHandler.reparentEnrollmentHistoryApplication(childApplication);
		
		for(TargetX_SRMb__Enrollment_History__c h : [SELECT TargetX_SRMb__Application__c FROM TargetX_SRMb__Enrollment_History__c WHERE TargetX_SRMb__Application__c = :childApplication[0].id]) {
			System.assertEquals(childApplication[0].id, h.TargetX_SRMb__Application__c);
		}
		System.assertEquals(NUM_HISTORY_PER_APP, Database.countQuery('SELECT count() FROM TargetX_SRMb__Enrollment_History__c'));
	}
	
	public static List<Attachment> createAndInsertAttachmentsWithEnrollmentHistories(List<TargetX_SRMb__Enrollment_History__c> histories) {
		// creates a list of attachments for each history and associates the history id with an attachment then inserts them into the database
		List<Attachment> attachments = DataFactoryAttachment.createAttachmentsList(histories.size());
		DataFactoryAttachment.addEnrollmentHistoriesListToAttachmentsList(histories, attachments);
		
		Database.SaveResult[] saveAttachmentsResult = Database.insert(attachments, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveAttachmentsResult);
		
		return attachments;
	}
	
}