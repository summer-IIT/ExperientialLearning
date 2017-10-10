@isTest
public without sharing class IITAttachmentTest {
	@isTest
	public static void testAttachmentTrigger() {
		// test originally from IITTestHandler with small modifications 
		final integer NUM_CONTACTS = 20;
		final integer NUM_ATTACHMENTS = 20;
		
		List<Contact> contacts = DataFactoryContact.createContactsList(NUM_CONTACTS);
		Database.SaveResult[] saveContactResults = Database.insert(contacts, false);
		
		// verify that the contacts were inserted into system correctly and that the desired number of contacts were created 
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveContactResults);
		System.assert(NUM_CONTACTS == saveContactResults.size());
		
		// Create a list of attachments and associate their parent ID fields with the contact IDs we inserted into system
		List<Attachment> attachments = DataFactoryAttachment.createAttachmentsList(NUM_ATTACHMENTS);
		DataFactoryAttachment.addContactsListToAttachmentsList(contacts, attachments);
		
		// Test various database operations on the attachments list we created
		Database.SaveResult[] saveAttachmentResults = Database.insert(attachments, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveAttachmentResults);
		
		Database.DeleteResult[] deleteAttachmentResults = Database.delete(attachments, false);
		IITDatabaseTestTools.checkSuccessfulDeleteResultList(deleteAttachmentResults);
	}

	@isTest
	public static void testCloneAttachments() {
		// tests the CloneAttachments method
		Contact parent = new Contact(LastName = 'TestName');
		Database.SaveResult result = Database.insert(parent);
		IITDatabaseTestTools.checkForSuccessfulSaveResult(result);
		
		Attachment[] attachments = new List<Attachment>();
		attachments.add(new Attachment(name = 'Test Attachment1', ParentId = parent.id, Body = Blob.valueOf('Test Body')));
		
		IITAttachmentHandler.performInsert(attachments);
		
		Map<Id, Id> cloneMap = new Map<Id, Id>();
		cloneMap.put(parent.id, parent.id);
		
		// Clone the attachment
		IITAttachmentHandler.cloneAttachments(cloneMap);
		
		// Test that empty maps return without any clone
		cloneMap.clear();
		IITAttachmentHandler.cloneAttachments(cloneMap);
	}
	
	@isTest
	public static void testOversizedAttachmentErrorMessaging() {
		// tests that an error message containing details about attachments is created
		final Integer NUM_CONTACTS = 1;
		final Integer NUM_APPLICATIONS = 1;
		final Integer NUM_ESSAY_PER_APP = 2;

		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create essays for each application and insert into database
		List<TargetX_SRMb__Essay__c> essays = DataFactoryEssay.createAndInsertEssaysWithApplicationAndContact(applications, NUM_ESSAY_PER_APP);
		
		// Create attachments for each essay and insert into database
		// Then update and delete attachments and essays from the database
		List<Attachment> attachments = DataFactoryAttachment.createAndInsertAttachmentsWithEssays(essays);
		
		String errorMessage = IITAttachmentHandler.oversizedAttachmentErrorMessaging(attachments);
		system.debug(errorMessage);
	}
		
	@isTest
	public static void testSendOversizeAttachmentEmail() {
		// tests the emails that are sent when oversized attachments are encountered
		final Integer NUM_CONTACTS = 1;
		final Integer NUM_APPLICATIONS = 1;
		final Integer NUM_ESSAY_PER_APP = 2;

		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create essays for each application and insert into database
		List<TargetX_SRMb__Essay__c> essays = DataFactoryEssay.createAndInsertEssaysWithApplicationAndContact(applications, NUM_ESSAY_PER_APP);
		
		// Create attachments for each essay and insert into database
		// Then update and delete attachments and essays from the database
		List<Attachment> attachments = DataFactoryAttachment.createAndInsertAttachmentsWithEssays(essays);
				
		// Test that the test should use an email invocation only when called with the optional 'send email in test' parameter as true
		System.assertEquals(0, Limits.getEmailInvocations(), 'No emails are sent prior to calling the function');
		
		IITAttachmentHandler.sendOversizeAttachmentEmail(attachments);
		System.assertEquals(0, Limits.getEmailInvocations(), 'No emails are sent if the function is called in a test context without the send email in test parameter as true');
		
		IITAttachmentHandler.sendOversizeAttachmentEmail(attachments, true);
		System.assertEquals(1, Limits.getEmailInvocations(), 'After the function is called an email should be sent (an email invocation indicates this)');
	}
	
	@isTest
	public static void testGetApplicationFromAttachment() {
		// tests that the getApplicationFromAttachment method correctly returns the application 
		// based on the parent ID of an attachment object
		final Integer NUM_CONTACTS = 1;
		final Integer NUM_APPLICATIONS = 1;
		final Integer NUM_ESSAY_PER_APP = 1;

		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create essays for each application and insert into database
		List<TargetX_SRMb__Essay__c> essays = DataFactoryEssay.createAndInsertEssaysWithApplicationAndContact(applications, NUM_ESSAY_PER_APP);
		
		// Create attachments for each essay and insert into database
		// Then update and delete attachments and essays from the database
		List<Attachment> attachments = DataFactoryAttachment.createAndInsertAttachmentsWithEssays(essays);
		
		TargetX_SRMb__Application__c returnedApp = IITAttachmentHandler.getApplicationFromAttachment(attachments[0]);
		System.assertEquals(returnedApp.id, applications[0].id, 'The application ID returned by the function should match the application created and associated with the attachment');
		
	}
		
	@isTest
	public static void testPerformInsert() {
		// tests the performInsert method
		Contact parent = new Contact(LastName = 'TestName');
		Database.SaveResult result = Database.insert(parent);
		IITDatabaseTestTools.checkForSuccessfulSaveResult(result);
		
		Attachment[] attachments = new List<Attachment>();
		attachments.add(new Attachment(name = 'Test Attachment1', ParentId = parent.id, Body = Blob.valueOf('Test Body')));
		attachments.add(new Attachment(name = 'Test Attachment2', ParentId = parent.id, Body = Blob.valueOf('Test Body')));
		
		integer count = Database.countQuery('SELECT count() FROM Attachment');
		System.assertEquals(0, count, 'Record counts do not match before insert');
		
		IITAttachmentHandler.performInsert(attachments);
		
		count = Database.countQuery('SELECT count() FROM Attachment');
		System.assertEquals(2, count, 'Record counts do not match after insert');
	}
}