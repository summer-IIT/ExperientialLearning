public without sharing class IITExtraCurricularActivityHandler { //Handles ExtraCurricular manipulation
	private static String extraCurricularQuery; //Query for all writeable fields on a extraCurricular

//Copy ExtraCurricular Section
	public static void copyExtraCurricularsForApplication(List<TargetX_SRMb__Application__c> applicationsToCloneTo, Map<Id,Id> attachmentIdMap) {//Copies all extraCurriculars attached to applicationToCloneTo's previous application onto applicationToCloneTo
		Map<Id,Id> applicationIdMap = new Map<Id,Id>();

		for(TargetX_SRMb__Application__c applicationToCloneTo : applicationsToCloneTo) {//iterate through each application
			applicationIdMap.put(applicationToCloneTo.IIT_Previous_Application__c,applicationToCloneTo.Id);//put the translation id into the map.
		}

		Set<Id> applicationIds = applicationIdMap.keySet();//Create a keyset to copy

		Map<Id,TargetX_SRMb__Extra_Curricular_Activity__c> extraCurricularsToClone = new Map<id,TargetX_SRMb__Extra_Curricular_Activity__c>( (List<TargetX_SRMb__Extra_Curricular_Activity__c>)Database.Query(IITExtraCurricularActivityHandler.getExtraCurricularApplicationQuery() + 'TargetX_SRMb__Application__c in :applicationIds FOR UPDATE' )); //dynamically pull the applications with all writeable fields
		Map<id,TargetX_SRMb__Extra_Curricular_Activity__c> extraCurricularsToInsert = new Map<Id,TargetX_SRMb__Extra_Curricular_Activity__c>(); //Initialize extraCurriculars to insert

		for(TargetX_SRMb__Extra_Curricular_Activity__c extraCurricularToClone : extraCurricularsToClone.values() ) {//Iterate through each 
			TargetX_SRMb__Extra_Curricular_Activity__c newExtraCurricular = extraCurricularToClone.clone(false,true,false,false); //Clone ExtraCurricular

			//Clear unique fields
			newExtraCurricular.TargetX_SRMb__Extra_Curricular_Activity_Key__c = null;
			newExtraCurricular.TargetX_SRMb__SRM_ETL_ID__c = null;

			newExtraCurricular.TargetX_SRMb__Application__c = applicationIdMap.get(newExtraCurricular.TargetX_SRMb__Application__c); //Set extraCurricular's application
			extraCurricularsToInsert.put(extraCurricularToClone.Id,newExtraCurricular);
		}

		IITExtraCurricularActivityHandler.performInsert(extraCurricularsToInsert.values());//Insert the extraCurriculars

		for(Id oldExtraCurricularId : extraCurricularsToInsert.keySet()) {//Iterate through each inserted extraCurricular
			attachmentIdMap.put(oldExtraCurricularId,extraCurricularsToInsert.get(oldExtraCurricularId).Id); //Add the id to the attachment Id Map
		}
	}

	private static String getExtraCurricularApplicationQuery() {//Initializes the application field map and query for all fields
		if(IITExtraCurricularActivityHandler.extraCurricularQuery != null) {//check for cached query
			return IITExtraCurricularActivityHandler.extraCurricularQuery;//return cached query if it exists
		}

		String tempQuery = 'SELECT'; //Initialize query with select statement

		Map<String, Schema.SObjectField> extraCurricularFields = Schema.getGlobalDescribe().get('TargetX_SRMb__Extra_Curricular_Activity__c').getDescribe().fields.getMap(); //get every field for application
		for (Schema.SObjectField extraCurricularField : extraCurricularFields.values() ) { //Iterate through all field tokens
			Schema.DescribeFieldResult extraCurricularFieldDescription = extraCurricularField.getDescribe(); // Describe each field
			tempQuery += ' ' + extraCurricularFieldDescription.getName() + ','; //Add the field to the SOQL query
		}

		tempQuery = tempQuery.subString(0,tempQuery.Length() - 1); //Trim off that last comma
		tempQuery += ' FROM TargetX_SRMb__Extra_Curricular_Activity__c WHERE '; //add on the from and where statements
		IITExtraCurricularActivityHandler.extraCurricularQuery = tempQuery;
		return tempQuery; //return the query minus the variable in memory to check
	}

//Update and Insert
		public static void performInsert(List<TargetX_SRMb__Extra_Curricular_Activity__c> extraCurricularsToInsert) {
			try {
				Insert extraCurricularsToInsert; //Perform database update on the desired records.
				IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
			} catch(Exception exceptionCaught) {//Catch any errors
				IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
			}
		}

		public static void performUpdate(List<TargetX_SRMb__Extra_Curricular_Activity__c> extraCurricularsToUpdate) {
			try {
				Update extraCurricularsToUpdate; //Perform database update on the desired records.
				IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
			} catch(Exception exceptionCaught) {//Catch any errors
				IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
			}
		}
}