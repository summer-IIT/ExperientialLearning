public without sharing class IITRecommendationHandler { //Handles Recommendation manipulation
	private static String recommendationQuery; //Query for all writeable fields on a recommendation

	public static void toggleRequirement(Set<Id> recommendationIdsToProcess, boolean requirementToForce) {//Toggles TargetX_SRMb__IsRequired__c to requirementToForce for Recommendations with ids in recommendationIdsToProcess
		try {
			Map<Id,TargetX_SRMb__Recommendation__c> recommendationsToToggle = new Map<Id,TargetX_SRMb__Recommendation__c>([SELECT Id
			, TargetX_SRMb__IsRequired__c
			, TargetX_SRMb__Complete__c
			, IIT_Insufficiency_ID_Desc__c
			FROM TargetX_SRMb__Recommendation__c
			WHERE Id in :recommendationIdsToProcess
			AND TargetX_SRMb__IsRequired__c != :requirementToForce
			AND IIT_Application_Level__c = 'Graduate'
			FOR UPDATE
			]); //Pull recommendation objects with id and TargetX_SRMb__IsRequired__c where id in recommendationIdsToProcess and TargetX_SRMb__IsRequired__c != requirementToForce

			if(recommendationsToToggle.keySet().size() < 1) {//Check that we don't have any records that match
				return; //Do nothing
			}

			for(TargetX_SRMb__Recommendation__c recommendationToToggle : recommendationsToToggle.values()) {//Iterate through each recommendation to toggle
				recommendationToToggle.TargetX_SRMb__IsRequired__c = requirementToForce; //Set IsRequired to the desired value
				
				if(requirementToForce) {//If setting the requirement, clear the insufficiency as it no longer applies
					recommendationToToggle.IIT_Insufficiency_ID_Desc__c = null;
				} else {//Remove completion if removing applies to Requirements
					recommendationToToggle.TargetX_SRMb__Complete__c = false;
				}
			}

			try	{
				Update recommendationsToToggle.values(); //Perform database update on the desired records.
				IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
			} catch(Exception exceptionCaught) {//Catch any errors
				IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
			}
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}

//Copy Recommendation Section
	public static void copyRecommendationsForApplication(List<TargetX_SRMb__Application__c> applicationsToCloneTo, Map<Id,Id> attachmentIdMap) {//Copies all recommendations attached to applicationToCloneTo's previous application onto applicationToCloneTo
		Map<Id,Id> applicationIdMap = new Map<Id,Id>();

		for(TargetX_SRMb__Application__c applicationToCloneTo : applicationsToCloneTo) {//iterate through each application
			applicationIdMap.put(applicationToCloneTo.IIT_Previous_Application__c,applicationToCloneTo.Id);//put the translation id into the map.
		}

		Set<Id> applicationIds = applicationIdMap.keySet();//Create a keyset to copy

		Map<Id,TargetX_SRMb__Recommendation__c> recommendationsToClone = new Map<id,TargetX_SRMb__Recommendation__c>( (List<TargetX_SRMb__Recommendation__c>)Database.Query(IITRecommendationHandler.getRecommendationApplicationQuery() + 'TargetX_SRMb__Application__c in :applicationIds FOR UPDATE' )); //dynamically pull the applications with all writeable fields
		Map<id,TargetX_SRMb__Recommendation__c> recommendationsToInsert = new Map<Id,TargetX_SRMb__Recommendation__c>(); //Initialize recommendations to insert

		for(TargetX_SRMb__Recommendation__c recommendationToClone : recommendationsToClone.values() ) {//Iterate through each 
			TargetX_SRMb__Recommendation__c newRecommendation = recommendationToClone.clone(false,true,false,false); //Clone Recommendation

			//Clear unique values
			newRecommendation.TargetX_SRMb__Recommendation_Key__c = null;
			newRecommendation.TargetX_SRMb__SRM_ETL_ID__c = null;
			
			// Clear the requirement ID field (Which should cause managed TargetX code to rematch the recommendation to the correct checklist item on the new application)
			newRecommendation.TargetX_SRMb__RequirementID__c = null;

			newRecommendation.TargetX_SRMb__Application__c = applicationIdMap.get(newRecommendation.TargetX_SRMb__Application__c); //Set recommendation's application
			recommendationsToInsert.put(recommendationToClone.Id,newRecommendation);
		}

		IITRecommendationHandler.performInsert(recommendationsToInsert.values());//Insert the recommendations

		for(Id oldRecommendationId : recommendationsToInsert.keySet()) {//Iterate through each inserted recommendation
			attachmentIdMap.put(oldRecommendationId,recommendationsToInsert.get(oldRecommendationId).Id); //Add the id to the attachment Id Map
		}
	}

	private static String getRecommendationApplicationQuery() {//Initializes the application field map and query for all fields
		if(IITRecommendationHandler.recommendationQuery != null) {//check for cached query
			return IITRecommendationHandler.recommendationQuery;//return cached query if it exists
		}

		String tempQuery = 'SELECT'; //Initialize query with select statement

		Map<String, Schema.SObjectField> recommendationFields = Schema.getGlobalDescribe().get('TargetX_SRMb__Recommendation__c').getDescribe().fields.getMap(); //get every field for application
		for (Schema.SObjectField recommendationField : recommendationFields.values() ) { //Iterate through all field tokens
			Schema.DescribeFieldResult recommendationFieldDescription = recommendationField.getDescribe(); // Describe each field
			tempQuery += ' ' + recommendationFieldDescription.getName() + ','; //Add the field to the SOQL query
		}

		tempQuery = tempQuery.subString(0,tempQuery.Length() - 1); //Trim off that last comma
		tempQuery += ' FROM TargetX_SRMb__Recommendation__c WHERE '; //add on the from and where statements
		IITRecommendationHandler.recommendationQuery = tempQuery;
		return tempQuery; //return the query minus the variable in memory to check
	}

//Update and Insert
		public static void performInsert(List<TargetX_SRMb__Recommendation__c> recommendationsToInsert) {
			try {
				Insert recommendationsToInsert; //Perform database update on the desired records.
				IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
			} catch(Exception exceptionCaught) {//Catch any errors
				IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
			}
		}

		public static void performUpdate(List<TargetX_SRMb__Recommendation__c> recommendationsToUpdate) {
			try {
				Update recommendationsToUpdate; //Perform database update on the desired records.
				IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
			} catch(Exception exceptionCaught) {//Catch any errors
				IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
			}
		}
}