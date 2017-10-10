@isTest
public without sharing class IITRecommendationTest {
	@isTest
	public static void testRecommendationTrigger() {
		// Create objects and test the trigger(s) operating on the recommendation object
		final Integer NUM_CONTACTS = 5;
		final Integer NUM_APPLICATIONS = 5;
		final Integer NUM_RECOMMENDATIONS_PER_APP = 2;
		
		// Create program objects and insert into database for later use
		List<IIT_Program__c> programList = DataFactoryPrograms.createAndInsertPrograms();
		
		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create recommendations associated with contacts and applications and insert into database
		List<TargetX_SRMb__Recommendation__c> recommendations = DataFactoryRecommendation.createAndInsertRecommendationsWithApplicationAndContact(applications, NUM_RECOMMENDATIONS_PER_APP);
		
		// Create attachments associated with each recommendation and insert into database
		List<Attachment> attachments = IITRecommendationTest.createAndInsertAttachmentsWithRecommendations(recommendations);
		
		// update and delete the attachments, then update and delete the recommendations
		Database.SaveResult[] updateAttachmentsResult = Database.update(attachments, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(updateAttachmentsResult);
		
		Database.DeleteResult[] deleteAttachmentResult = Database.delete(attachments, false);
		IITDatabaseTestTools.checkSuccessfulDeleteResultList(deleteAttachmentResult);
		
		Database.SaveResult[] updateRecommendationsResult = Database.update(recommendations, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(updateRecommendationsResult);

		Database.DeleteResult[] deleteRecommendationsResult = Database.delete(recommendations, false);
		IITDatabaseTestTools.checkSuccessfulDeleteResultList(deleteRecommendationsResult);
	}
	
	@isTest
	public static void testRecommendationHandler() {
		// Create objects and test the trigger(s) operating on the recommendation object
		final Integer NUM_CONTACTS = 5;
		final Integer NUM_APPLICATIONS = 5;
		final Integer NUM_RECOMMENDATIONS_PER_APP = 2;
		
		// Create program objects and insert into database for later use
		List<IIT_Program__c> programList = DataFactoryPrograms.createAndInsertPrograms();
		
		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create recommendations associated with contacts and applications and insert into database
		List<TargetX_SRMb__Recommendation__c> recommendations = DataFactoryRecommendation.createAndInsertRecommendationsWithApplicationAndContact(applications, NUM_RECOMMENDATIONS_PER_APP);
	
		Set<Id> recommendationIds = new Map<Id, TargetX_SRMb__Recommendation__c>(recommendations).keySet();
		IITRecommendationHandler.toggleRequirement(recommendationIds, false);
		IITRecommendationHandler.toggleRequirement(recommendationIds, true);		
	}
	
	public static List<Attachment> createAndInsertAttachmentsWithRecommendations(List<TargetX_SRMb__Recommendation__c> recommendations) {
		// creates a list of attachments for each recommendation and associates the recommendation id with an attachment then inserts them into the database
		List<Attachment> attachments = DataFactoryAttachment.createAttachmentsList(recommendations.size());
		DataFactoryAttachment.addRecommendationListToAttachmentsList(recommendations, attachments);
		
		Database.SaveResult[] saveAttachmentsResult = Database.insert(attachments, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveAttachmentsResult);
		
		return attachments;
	}
}