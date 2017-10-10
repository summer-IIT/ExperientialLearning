@isTest
public without sharing class IITEssayTest {
	@isTest
	public static void testEssayTrigger() {
		final Integer NUM_CONTACTS = 5;
		final Integer NUM_APPLICATIONS = 5;
		final Integer NUM_ESSAY_PER_APP = 2;
		
		// Create program objects and insert into database for later use
		List<IIT_Program__c> programList = DataFactoryPrograms.createAndInsertPrograms();
		
		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create essays for each application and insert into database
		List<TargetX_SRMb__Essay__c> essays = DataFactoryEssay.createAndInsertEssaysWithApplicationAndContact(applications, NUM_ESSAY_PER_APP);
		
		// Create attachments for each essay and insert into database
		// Then update and delete attachments and essays from the database
		List<Attachment> attachments = DataFactoryAttachment.createAndInsertAttachmentsWithEssays(essays);
		
		Database.SaveResult[] updateAttachmentsResult = Database.update(attachments, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(updateAttachmentsResult);
		
		Database.DeleteResult[] deleteAttachmentsResult = Database.delete(attachments, false);
		IITDatabaseTestTools.checkSuccessfulDeleteResultList(deleteAttachmentsResult);
		
		Database.SaveResult[] updateEssaysResult = Database.update(essays, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(updateEssaysResult);

		Database.DeleteResult[] deleteEssaysResult = Database.delete(essays, false);
		IITDatabaseTestTools.checkSuccessfulDeleteResultList(deleteEssaysResult);		
	}
	
	@isTest
	public static void testEssayHandler() {
		final Integer NUM_CONTACTS = 5;
		final Integer NUM_APPLICATIONS = 5;
		final Integer NUM_ESSAY_PER_APP = 2;
		
		// Create program objects and insert into database for later use
		List<IIT_Program__c> programList = DataFactoryPrograms.createAndInsertPrograms();
		
		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create essays for each application and insert into database
		List<TargetX_SRMb__Essay__c> essays = DataFactoryEssay.createAndInsertEssaysWithApplicationAndContact(applications, NUM_ESSAY_PER_APP);
		
		Set<Id> essayIDs = new Map<Id, TargetX_SRMb__Essay__c>(essays).keySet();
		
		IITEssayHandler.toggleRequirement(essayIDs, false);
		IITEssayHandler.toggleRequirement(essayIDs, true);
	}
	
	@isTest
	public static void testEssayGlobal() {
		final Integer NUM_CONTACTS = 5;
		final Integer NUM_APPLICATIONS = 5;
		final Integer NUM_ESSAY_PER_APP = 2;
		final String ESSAY_TYPE = 'Academic Training and Research Form';
		final boolean COMPLETED_ESSAY = true;
		
		// Create program objects and insert into database for later use
		List<IIT_Program__c> programList = DataFactoryPrograms.createAndInsertPrograms();
		
		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create essays associated with application and contact and insert into database
		List<TargetX_SRMb__Essay__c> essays = IITEssayTest.setupEssayGlobal(applications, NUM_ESSAY_PER_APP, ESSAY_TYPE);
		
		// Create attachments for each essay and insert into database
		List<Attachment> attachments = DataFactoryAttachment.createAndInsertAttachmentsWithEssays(essays);
		
		// Mark test essays as completed
		for(TargetX_SRMb__Essay__c e : essays) {
			e.TargetX_SRMb__Complete__c = COMPLETED_ESSAY;
		}
		
		// Update database with modified essays
		Database.SaveResult[] saveResults = Database.update(essays, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveResults);
		
		IITEssayGlobal.sendEssayEmail(essays[0].id);
	}
	
	public static List<TargetX_SRMb__Essay__c> setupEssayGlobal(List<TargetX_SRMb__Application__c> applications, Integer numberOfEssaysPerApplication, String essayType) {
		// Create a list of essay objects then change the type to ESSAY_TYPE, then insert them into the database
		List<TargetX_SRMb__Essay__c> totalEssays = new List<TargetX_SRMb__Essay__c>();
		
		for(Integer i = 0; i < numberOfEssaysPerApplication; i++) {
			List<TargetX_SRMb__Essay__c> essays = DataFactoryEssay.createEssaysList(applications.size());
			for(TargetX_SRMb__Essay__c e: essays) {
				e.TargetX_SRMb__Type__c = essayType;
			}
			DataFactoryEssay.addApplicationsListToEssaysList(applications, essays);
			
			totalEssays.addAll(essays);		
		}
		
		Database.SaveResult[] saveEssaysResult = Database.insert(totalEssays, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveEssaysResult);
		
		return totalEssays;
	}
}