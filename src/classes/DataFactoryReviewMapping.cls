@isTest
public without sharing class DataFactoryReviewMapping {
	public static IIT_Review_Type_Mapping__c createReviewMapping() {
		// create a single review type mapping object
		IIT_Review_Type_Mapping__c reviewMapping = new IIT_Review_Type_Mapping__c(
			Name = 'Test Review',
			Department__c = 'Computer Science',
			Level__c = 'Graduate',
			Processing_Status__c = 'Pending Initial Review',
			Review_Type_ID__c = 'badId'
		);
		
		return reviewMapping;
	}
}