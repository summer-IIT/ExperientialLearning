public without sharing class IITEnrollmentHistoryHandler { //Handles EnrollmentHistory manipulation
	private static String enrollmentHistoryQuery; //Query for all writeable fields on a enrollmentHistory

	public static void toggleRequirement(Set<Id> enrollmentHistoryIdsToProcess, boolean requirementToForce) {//Toggles TargetX_SRMb__IsRequired__c to requirementToForce for Enrollment Histories with ids in enrollmentHistory
		try {
			Map<Id, TargetX_SRMb__Enrollment_History__c> enrollmentHistoriesToToggle = new Map<Id, TargetX_SRMb__Enrollment_History__c>([SELECT Id
			, TargetX_SRMb__IsRequired__c
			, TargetX_SRMb__Complete__c
			, IIT_Insufficiency_ID_Desc__c
			FROM TargetX_SRMb__Enrollment_History__c
			WHERE Id in :enrollmentHistoryIdsToProcess
			AND TargetX_SRMb__IsRequired__c != :requirementToForce
			AND IIT_Application_Level__c = 'Graduate'
			FOR UPDATE
			]); //Pull enrollmentHistory objects with id and TargetX_SRMb__IsRequired__c where id in enrollmentHistoryIdsToProcess and TargetX_SRMb__IsRequired__c != requirementToForce

			if(enrollmentHistoriesToToggle.keySet().size() < 1) {//Check that we don't have any records that match
				return; //Do nothing
			}

			for(TargetX_SRMb__Enrollment_History__c enrollmentHistoryToToggle : enrollmentHistoriesToToggle.values()) {//Iterate through each enrollmentHistory to toggle
				enrollmentHistoryToToggle.TargetX_SRMb__IsRequired__c = requirementToForce; //Set IsRequired to the desired value
				
				if(requirementToForce) {//If setting the requirement, clear the insufficiency as it no longer applies
					enrollmentHistoryToToggle.IIT_Insufficiency_ID_Desc__c = null;
				} else if(enrollmentHistoryToToggle.TargetX_SRMb__Complete__c) {//Remove completion if removing applies to requirements
					enrollmentHistoryToToggle.TargetX_SRMb__Complete__c = false;
				}
			}

			IITEnrollmentHistoryHandler.performUpdate( enrollmentHistoriesToToggle.values() ); //Update the enrollment histories
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}

//Copy EnrollmentHistory Section
	public static void copyEnrollmentHistoriesForApplication(List<TargetX_SRMb__Application__c> applicationsToCloneTo, Map<Id,Id> attachmentIdMap) {//Copies all enrollmentHistories attached to applicationToCloneTo's previous application onto applicationToCloneTo
		Map<Id,Id> applicationIdMap = new Map<Id,Id>();

		for(TargetX_SRMb__Application__c applicationToCloneTo : applicationsToCloneTo) {//iterate through each application
			applicationIdMap.put(applicationToCloneTo.IIT_Previous_Application__c,applicationToCloneTo.Id);//put the translation id into the map.
		}

		Set<Id> applicationIds = applicationIdMap.keySet();//Create a keyset to copy

		Map<Id,TargetX_SRMb__Enrollment_History__c> enrollmentHistoriesToClone = new Map<id,TargetX_SRMb__Enrollment_History__c>( (List<TargetX_SRMb__Enrollment_History__c>)Database.Query(IITEnrollmentHistoryHandler.getEnrollmentHistoryApplicationQuery() + 'TargetX_SRMb__Application__c in :applicationIds FOR UPDATE' )); //dynamically pull the applications with all writeable fields
		Map<id,TargetX_SRMb__Enrollment_History__c> enrollmentHistoriesToInsert = new Map<Id,TargetX_SRMb__Enrollment_History__c>(); //Initialize enrollmentHistories to insert

		for(TargetX_SRMb__Enrollment_History__c enrollmentHistoryToClone : enrollmentHistoriesToClone.values() ) {//Iterate through each 
			TargetX_SRMb__Enrollment_History__c newEnrollmentHistory = enrollmentHistoryToClone.clone(false,true,false,false); //Clone EnrollmentHistory

			//clear unique fields
			newEnrollmentHistory.TargetX_SRMb__Enrollment_History_Key__c = null;
			newEnrollmentHistory.TargetX_SRMb__SRM_ETL_ID__c = null;
			
			newEnrollmentHistory.TargetX_SRMb__Application__c = applicationIdMap.get(newEnrollmentHistory.TargetX_SRMb__Application__c); //Set enrollmentHistory's application
			enrollmentHistoriesToInsert.put(enrollmentHistoryToClone.Id,newEnrollmentHistory);
		}

		IITEnrollmentHistoryHandler.performInsert(enrollmentHistoriesToInsert.values());//Insert the enrollmentHistories

		for(Id oldEnrollmentHistoryId : enrollmentHistoriesToInsert.keySet()) {//Iterate through each inserted enrollmentHistory
			attachmentIdMap.put(oldEnrollmentHistoryId,enrollmentHistoriesToInsert.get(oldEnrollmentHistoryId).Id); //Add the id to the attachment Id Map
		}
	}
	
	public static void reparentEnrollmentHistoryApplication(List<TargetX_SRMb__Application__c> childApplications) {
		// Given a list of applications with previous application IDs, change enrollment history applications from a matched previous application 
		// ID to the corresponding (new) application ID.  Additionally, set the RequirementID field to null.
		
		// Create a map where previous application ids as key values map to the child / new application id
		// then populate the map by looping through the child applications
		Map<Id, Id> oldApplicationsToNewApplications = new Map<Id, Id>();
		
		for(TargetX_SRMb__Application__c childApp : childApplications) {
			oldApplicationsToNewApplications.put(childApp.IIT_Previous_Application__c, childApp.id);
		}
		
		// Select all of the enrollment history objects associated with the old application IDs
		List<TargetX_SRMb__Enrollment_History__c> histories = new List<TargetX_SRMb__Enrollment_History__c>([SELECT Id, TargetX_SRMb__Application__c, TargetX_SRMb__RequirementID__c 
																											 FROM TargetX_SRMb__Enrollment_History__c 
																											 WHERE TargetX_SRMb__Application__c IN :oldApplicationsToNewApplications.keySet()
																											 FOR UPDATE]);
		
		// for each enrollment history, change the application it is associated with from the old parent application id
		// to the corresponding new child application id in the map.  Then null the requirement ID field.																							 
		for(TargetX_SRMb__Enrollment_History__c hist : histories) {
			Id appId = hist.TargetX_SRMb__Application__c;
			hist.TargetX_SRMb__Application__c = oldApplicationsToNewApplications.get(appId);
			hist.TargetX_SRMb__RequirementID__c = null;
		}
		
		// Update the database with the newly reparented enrollment histories
		IITEnrollmentHistoryHandler.performUpdate(histories);
	}

	private static String getEnrollmentHistoryApplicationQuery() {//Initializes the application field map and query for all fields
		if(IITEnrollmentHistoryHandler.enrollmentHistoryQuery != null) {//check for cached query
			return IITEnrollmentHistoryHandler.enrollmentHistoryQuery;//return cached query if it exists
		}

		String tempQuery = 'SELECT'; //Initialize query with select statement

		Map<String, Schema.SObjectField> enrollmentHistoryFields = Schema.getGlobalDescribe().get('TargetX_SRMb__Enrollment_History__c').getDescribe().fields.getMap(); //get every field for application
		for (Schema.SObjectField enrollmentHistoryField : enrollmentHistoryFields.values() ) { //Iterate through all field tokens
			Schema.DescribeFieldResult enrollmentHistoryFieldDescription = enrollmentHistoryField.getDescribe(); // Describe each field
			tempQuery += ' ' + enrollmentHistoryFieldDescription.getName() + ','; //Add the field to the SOQL query
		}

		tempQuery = tempQuery.subString(0,tempQuery.Length() - 1); //Trim off that last comma
		tempQuery += ' FROM TargetX_SRMb__Enrollment_History__c WHERE '; //add on the from and where statements
		IITEnrollmentHistoryHandler.enrollmentHistoryQuery = tempQuery;
		return tempQuery; //return the query minus the variable in memory to check
	}

//Update and Insert
	public static void performInsert(List<TargetX_SRMb__Enrollment_History__c> enrollmentHistoriesToInsert) {
		try {
			Insert enrollmentHistoriesToInsert; //Perform database update on the desired records.
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}

	public static void performUpdate(List<TargetX_SRMb__Enrollment_History__c> enrollmentHistoriesToUpdate) {
		try {
			Update enrollmentHistoriesToUpdate; //Perform database update on the desired records.
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(DMLException dmlExceptionCaught) {//Catch dml errors
			IITExceptionHandler.sendDMLExceptionEmail(dmlExceptionCaught); //Send dml specific exception email
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}
}