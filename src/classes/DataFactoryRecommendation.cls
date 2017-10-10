@isTest
public without sharing class DataFactoryRecommendation {
	public static TargetX_SRMb__Recommendation__c createRecommendation() {
		// create a single recommendation
		TargetX_SRMb__Recommendation__c recommendation = new TargetX_SRMb__Recommendation__c(
			Name = 'Test Recommendation',
			TargetX_SRMb__IsRequired__c = true
		);
		
		return recommendation;
	}
	
	public static List<TargetX_SRMb__Recommendation__c> createRecommendationsList(Integer numberOfRecommendations) {
		// create a list containing numberOfRecommendations number of recommendations
		List<TargetX_SRMb__Recommendation__c> recommendations = new List<TargetX_SRMb__Recommendation__c>();
		
		for(Integer i = 0; i < numberOfRecommendations; i++) {
			TargetX_SRMb__Recommendation__c recommendation = new TargetX_SRMb__Recommendation__c(
				Name = 'Test Recommendation ' + String.valueof(i),
				TargetX_SRMb__IsRequired__c = (Math.mod(i, 2) == 0)
			);
			
			recommendations.add(recommendation);
		}
		
		return recommendations;
	}
	
	public static void addApplicationToRecommendation(TargetX_SRMb__Application__c application, TargetX_SRMb__Recommendation__c recommendation) {
		// add an application and contact data to a recommendation object
		
		// check that the application has an id and contact id
		System.assert(application.id != null && application.TargetX_SRMb__Contact__c != null);
		
		recommendation.TargetX_SRMb__Application__c = application.id;
		recommendation.TargetX_SRMb__Contact__c = application.TargetX_SRMb__Contact__c;
	}
	
	public static void addApplicationsListToRecommendationsList(List<TargetX_SRMb__Application__c> applications, List<TargetX_SRMb__Recommendation__c> recommendations) {
		// add an application and contact data to each recommendation in a list
		
		// check that the applications contain ids and contact ids and that each list of objects is the same size
		for(TargetX_SRMb__Application__c a : applications) {
			System.assert(a.id != null && a.TargetX_SRMb__Contact__c != null);
		}
		System.assert(applications.size() == recommendations.size());
		
		for(Integer i = 0; i < applications.size(); i++) {
			recommendations[i].TargetX_SRMb__Application__c = applications[i].id;
			recommendations[i].TargetX_SRMb__Contact__c = applications[i].TargetX_SRMb__Contact__c;
		}
	}
	
	public static List<TargetX_SRMb__Recommendation__c> createAndInsertRecommendationsWithApplicationAndContact(List<TargetX_SRMb__Application__c> applications, Integer numberOfRecommendationsPerApp) {
		// creates a list of recommendation objects and associates an application and contact with each
		List<TargetX_SRMb__Recommendation__c> totalRecommendations = new List<TargetX_SRMb__Recommendation__c>();

		for(Integer i = 0; i < numberOfRecommendationsPerApp; i++) {
			List<TargetX_SRMb__Recommendation__c> recommendations = DataFactoryRecommendation.createRecommendationsList(applications.size());
			DataFactoryRecommendation.addApplicationsListToRecommendationsList(applications, recommendations);
			
			totalRecommendations.addAll(recommendations);
		}
		
		Database.SaveResult[] saveResult = Database.insert(totalRecommendations);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveResult);
		
		return totalRecommendations;
	}
}