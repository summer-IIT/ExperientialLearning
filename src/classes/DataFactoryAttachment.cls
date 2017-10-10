@isTest
public without sharing class DataFactoryAttachment {
	public static Attachment createAttachment() {
		Attachment attachment = new Attachment(
			Name = 'Test Attachment',
			Body = Blob.valueOf('Test Attachment Body'),
			ContentType = 'application/pdf'
		);
		
		return attachment;
	}
	
	public static List<Attachment> createAttachmentsList(Integer numberofAttachments) {
		List<Attachment> attachments = new List<Attachment>();
		
		for(Integer i = 0; i < numberOfAttachments; i++) {
			Attachment attachment = new Attachment(
				Name = 'Test Attachment ' + string.valueof(i),
				Body = Blob.valueOf('Test Attachment Body ' + string.valueOf(i)),
				ContentType = 'application/pdf'
			);
			attachments.add(attachment);
		}
		
		return attachments;
	}
	
	public static void addIdListToAttachmentsList(List<ID> ids, List<Attachment> attachments) {
		// Method that takes a list of IDs and sets the parent IDs for a list of applications to IDs from the list provided
		
		for(id i : ids) {
			system.assert(i != null);
		}
		system.assert(ids.size() == attachments.size());
		
		for(Integer i = 0; i < attachments.size(); i++) {
			attachments[i].ParentID = ids[i];
		}
	}
	
	public static void addContactsListToAttachmentsList(List<Contact> contacts, List<Attachment> attachments) {
		// add contact ids from a list of contacts to a list of attachments
		List<Id> ids = new List<Id>();
		
		for(Contact c : contacts) {
			ids.add(c.id);
		}
		
		DataFactoryAttachment.addIdListToAttachmentsList(ids, attachments);
	}
	
	public static void addEssayToAttachment(TargetX_SRMb__Essay__c essay, Attachment attachment) {
		// add a contact id to an existing attachment object	
		// verify that the contact has an ID
		system.assert(essay.id != null);
		
		attachment.ParentID = essay.id;
	}
	
	public static void addEssayListToAttachmentsList(List<TargetX_SRMb__Essay__c> essays, List<Attachment> attachments) {
		// add essay ids from a list of contacts to a list of existing attachment objects	
		// verify that each contact has an ID and that the lists of objects are the same size
		for(TargetX_SRMb__Essay__c e : essays) {
			system.assert(e.id != null);
		}
		system.assert(essays.size() == attachments.size());
		
		for(Integer i = 0; i < essays.size(); i++) {
			attachments[i].ParentID = essays[i].id;
		}
	}
	
	public static void addRecommendationListToAttachmentsList(List<TargetX_SRMb__Recommendation__c> recommendations, List<Attachment> attachments) {
		// add contact ids from a list of contacts to a list of existing attachment objects
		// verify that each contact has an ID and that the lists of objects are the same size
		for(TargetX_SRMb__Recommendation__c r : recommendations) {
			system.assert(r.id != null);
		}
		system.assert(recommendations.size() == attachments.size());
		
		for(Integer i = 0; i < recommendations.size(); i++) {
			attachments[i].ParentID = recommendations[i].id;
		}
	}
	
	public static void addEnrollmentHistoriesListToAttachmentsList(List<TargetX_SRMb__Enrollment_History__c> histories, List<Attachment> attachments) {
		// add contact ids from a list of enrollment histories to a list of existing attachment objects
		// verify that each contact has an ID and that the lists of objects are the same size
		for(TargetX_SRMb__Enrollment_History__c h : histories) {
			system.assert(h.id != null);
		}
		system.assert(histories.size() == attachments.size());
		
		for(Integer i = 0; i < histories.size(); i++) {
			attachments[i].ParentID = histories[i].id;
		}
	}
		
	public static List<Attachment> createAndInsertAttachmentsWithEssays(List<TargetX_SRMb__Essay__c> essays) {
		// create a number of attachments equal to the number of essays and add an id to each attachment from the essays then insert into the database
		List<Attachment> attachments = DataFactoryAttachment.createAttachmentsList(essays.size());
		DataFactoryAttachment.addEssayListToAttachmentsList(essays, attachments);
		Database.SaveResult[] saveAttachmentsResult = Database.insert(attachments, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveAttachmentsResult);
		
		return attachments;
	}
}