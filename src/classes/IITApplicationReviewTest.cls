@isTest
public without sharing class IITApplicationReviewTest {
	@isTest
	public static void testApplicationReviewTrigger() {
		// Test trigger(s) operating on the Application Review object
		final Integer NUM_ACCOUNTS = 3;
		final Integer NUM_CONTACTS = 3;
		final Integer NUM_APPLICATIONS = 3;
		boolean denyToApplied;
		
		// Create program objects and insert into database for later use
		List<IIT_Program__c> programList = DataFactoryPrograms.createAndInsertPrograms();
		
		// Create account objects and insert into database for later use
		List<Account> accounts = DataFactoryAccount.createAndInsertAccounts(NUM_ACCOUNTS);
		
		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create Application Review Type Objects and insert into the database
		List<TargetX_Reader__Application_Review_Type__c> applicationReviewTypes = DataFactoryApplicationReviewTypes.createApplicationReviewsList();
		Database.SaveResult[] results = Database.insert(applicationReviewTypes, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(results);
		
		// Create Application Review objects and insert into the database for testing
		List<TargetX_Reader__Application_Review__c> applicationReviews = DataFactoryApplicationReview.createAndInsertApplicationReviewsWithApplicationsAndType(applications, applicationReviewTypes);
		
		Map<id,TargetX_Reader__Application_Review_Type__c> reviewTypeMap = new Map<id,TargetX_Reader__Application_Review_Type__c>(applicationReviewTypes);
		
		
		for(TargetX_Reader__Application_Review__c ar : applicationReviews) {
			// This is taken directly from an older test method
			// It checks if the review type is not a Faculty Review (in a rather odd way) and then sets the level and decision on 
			// the current application.  It also switches the flag boolean to true and never resets it
			// Finally it marks all reviews as completed.
			if((reviewTypeMap.get(ar.TargetX_Reader__Application_Review_Type__c).Name.indexOf('Faculty Review')) != -1
			&& denyToApplied == false
			) {
				denyToApplied = true;
				ar.IIT_Level__c = 'Graduate';
				ar.IIT_Decision__c = 'Deny to Applied';
			}
			ar.TargetX_Reader__Completed__c = true;
		}
		
		Database.SaveResult[] updateResults = Database.update(applicationReviews, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(updateResults);
	}
}