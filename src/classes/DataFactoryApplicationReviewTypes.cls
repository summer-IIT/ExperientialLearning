@isTest
public without sharing class DataFactoryApplicationReviewTypes {
	public static TargetX_Reader__Application_Review_Type__c createGraduateTestApplicationReview() {
		// create a single application review with type Graduate Test 
		TargetX_Reader__Application_Review_Type__c review = new TargetX_Reader__Application_Review_Type__c(
			Name = 'Graduate Test Review'
		);
		
		return review;
	}
	
	public static TargetX_Reader__Application_Review_Type__c createGraduateTestFacultyApplicationReview() {
		// create a single application review with type Graduate Faculty Test
		TargetX_Reader__Application_Review_Type__c review = new TargetX_Reader__Application_Review_Type__c(
			Name = 'Graduate Test Faculty Review'
		);
		
		return review;
	}
	
	public static List<TargetX_Reader__Application_Review_Type__c> createApplicationReviewsList() {
		// create a list containing application review types
		List<TargetX_Reader__Application_Review_Type__c> reviews = new List<TargetX_Reader__Application_Review_Type__c>();
		
		reviews.add(DataFactoryApplicationReviewTypes.createGraduateTestApplicationReview());
		reviews.add(DataFactoryApplicationReviewTypes.createGraduateTestFacultyApplicationReview());
		
		return reviews;
	}
}