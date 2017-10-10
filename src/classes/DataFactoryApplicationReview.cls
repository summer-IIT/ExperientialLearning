@isTest
public without sharing class DataFactoryApplicationReview {
	public static TargetX_Reader__Application_Review__c createApplicationReview() {
		// create a single application review object
		TargetX_Reader__Application_Review__c review = new TargetX_Reader__Application_Review__c(
			TargetX_Reader__Completed__c = false
		);
		
		return review;
	}
	
	public static List<TargetX_Reader__Application_Review__c> createApplicationReviewsList(Integer numberOfReviews) {
		// create a list of application review objects
		List<TargetX_Reader__Application_Review__c> reviews = new List<TargetX_Reader__Application_Review__c>();
		
		for(Integer i = 0; i < numberOfReviews; i++) {
			TargetX_Reader__Application_Review__c review = new TargetX_Reader__Application_Review__c(
				TargetX_Reader__Completed__c = false
			);
			reviews.add(review);
		}
		
		return reviews;
	}
	
	public static void addReviewTypeToApplicationReview(TargetX_Reader__Application_Review_Type__c reviewType, TargetX_Reader__Application_Review__c review) {
		// add a review type to an existing application review
		
		// check that the review type has an id
		system.assert(reviewType.id != null);
		
		review.TargetX_Reader__Application_Review_Type__c = reviewType.id;		
	}
	
	public static void addReviewTypeToApplicationReviewsList(TargetX_Reader__Application_Review_Type__c reviewType, List<TargetX_Reader__Application_Review__c> reviews) {
		// add a review type to each item in a list of reviews
		
		// check that the review type has an id
		system.assert(reviewType.id != null);
	
		for(TargetX_Reader__Application_Review__c ar : reviews) {
			ar.TargetX_Reader__Application_Review_Type__c = reviewType.id;
		}
	}
	
	public static void addReviewTypesListToApplicationReviewsList(List<TargetX_Reader__Application_Review_Type__c> reviewTypes, List<TargetX_Reader__Application_Review__c> reviews) {
		// add a review type from a list of review types to each item in a list of reviews
		
		// check that each review type has an id
		for(TargetX_Reader__Application_Review_Type__c rt : reviewTypes) {
			system.assert(rt.id != null);
		}
		
		for(Integer i = 0; i < reviews.size(); i++){
			reviews[i].TargetX_Reader__Application_Review_Type__c = reviewTypes[math.mod(i, reviewTypes.size())].id;
		}
	}
	
	public static void addApplicationToApplicationReview(TargetX_SRMb__Application__c application, TargetX_Reader__Application_Review__c review) {
		// add an application id to an existing application review object
		
		// check that the application has an ID
		system.assert(application.id != null);
		
		review.TargetX_Reader__Application__c = application.id;
	}
	
	public static void addApplicationListToApplicationReviewsList(List<TargetX_SRMb__Application__c> applications, List<TargetX_Reader__Application_Review__c> reviews) {
		// add application ids from a list of applications to a list of application review objects
		
		// check that each application has an ID and that the lists are the same size
		for(TargetX_SRMb__Application__c a : applications) {
			system.assert(a.id != null); 
		}
		system.assert(applications.size() == reviews.size());
		
		for(Integer i = 0; i < applications.size(); i++) {
			reviews[i].TargetX_Reader__Application__c = applications[i].id;
		}
	}
	
	public static List<TargetX_Reader__Application_Review__c> createAndInsertApplicationReviewsWithApplicationsAndType(List<TargetX_SRMb__Application__c> applications, List<TargetX_Reader__Application_Review_Type__c> reviewTypes) {
		// Convenience method that wraps various test methods in order to create a list of application reviews, associate them with applications and review types, then insert them into the database for testing
		
		List<TargetX_Reader__Application_Review__c> applicationReviews = DataFactoryApplicationReview.createApplicationReviewsList(applications.size());
		DataFactoryApplicationReview.addReviewTypesListToapplicationReviewsList(reviewTypes, applicationReviews);
		DataFactoryApplicationReview.addApplicationListToApplicationReviewsList(applications, applicationReviews);
		
		Database.SaveResult[] results = Database.insert(applicationReviews, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(results);
		
		return applicationReviews;
	}
}