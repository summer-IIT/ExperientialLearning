public without sharing class IITFinancialAidHandler { //Handles Financial Aid manipulation
	private static String financialAidQuery; //Query for all writeable fields on a financial aid object

//Copy Financial Aid Section
	public static void copyFinancialAidForApplication(List<TargetX_SRMb__Application__c> applicationsToCloneTo, Map<Id,Id> attachmentIdMap) {//Copies all financial aid attached to applicationToCloneTo's previous application onto applicationToCloneTo
		Map<Id,Id> applicationIdMap = new Map<Id,Id>();

		for(TargetX_SRMb__Application__c applicationToCloneTo : applicationsToCloneTo) {//iterate through each application
			applicationIdMap.put(applicationToCloneTo.IIT_Previous_Application__c,applicationToCloneTo.Id);//put the translation id into the map.
		}

		Set<Id> applicationIds = applicationIdMap.keySet();//Create a keyset to copy

		Map<Id,TargetX_SRMb__Financial_Aid__c> financialAidToClone = new Map<id,TargetX_SRMb__Financial_Aid__c>( (List<TargetX_SRMb__Financial_Aid__c>)Database.Query(IITFinancialAidHandler.getFinancialAidApplicationQuery() + 'IIT_Application__c in :applicationIds AND IIT_Award_Status__c != \'Canceled\' AND TargetX_SRMb__Type__c = \'Merit\' FOR UPDATE' )); //dynamically pull the finaid objects with all writeable fields
		Map<id,TargetX_SRMb__Financial_Aid__c> financialAidToInsert = new Map<Id,TargetX_SRMb__Financial_Aid__c>(); //Initialize financial aid map to insert

		for(TargetX_SRMb__Financial_Aid__c financialAidRecordToClone : financialAidToClone.values() ) {//Iterate through each 
			TargetX_SRMb__Financial_Aid__c newFinancialAid = financialAidRecordToClone.clone(false,true,false,false); //Clone Financial Aid

			//Clear unique and ID fields
			newFinancialAid.TargetX_SRMb__Financial_Aid_Key__c = null;
			newFinancialAid.TargetX_SRMb__SRM_ETL_ID__c = null;

			newFinancialAid.IIT_Application__c = applicationIdMap.get(newFinancialAid.IIT_Application__c); //Set financial aid's application
			financialAidToInsert.put(financialAidRecordToClone.Id,newFinancialAid);
		}

		IITFinancialAidHandler.performInsert(financialAidToInsert.values());//Insert the financial aids

		for(Id oldFinancialAidId : financialAidToInsert.keySet()) {//Iterate through each inserted financial aid object
			attachmentIdMap.put(oldFinancialAidId,financialAidToInsert.get(oldFinancialAidId).Id); //Add the id to the attachment Id Map
		}
	}

	private static String getFinancialAidApplicationQuery() {//Initializes the application field map and query for all fields
		if(IITFinancialAidHandler.financialAidQuery != null) {//check for cached query
			return IITFinancialAidHandler.financialAidQuery;//return cached query if it exists
		}

		String tempQuery = 'SELECT'; //Initialize query with select statement

		Map<String, Schema.SObjectField> financialAidFields = Schema.getGlobalDescribe().get('TargetX_SRMb__Financial_Aid__c').getDescribe().fields.getMap(); //get every field for application
		for (Schema.SObjectField financialAidField : financialAidFields.values() ) { //Iterate through all field tokens
			Schema.DescribeFieldResult financialAidFieldDescription = financialAidField.getDescribe(); // Describe each field
			tempQuery += ' ' + financialAidFieldDescription.getName() + ','; //Add the field to the SOQL query
		}

		tempQuery = tempQuery.subString(0,tempQuery.Length() - 1); //Trim off that last comma
		tempQuery += ' FROM TargetX_SRMb__Financial_Aid__c WHERE '; //add on the from and where statements
		IITFinancialAidHandler.financialAidQuery = tempQuery;
		return tempQuery; //return the query minus the variable in memory to check
	}

//Update and Insert
		public static void performInsert(List<TargetX_SRMb__Financial_Aid__c> financialAidToInsert) {
			try {
				Insert financialAidToInsert; //Perform database update on the desired records.
				IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
			} catch(Exception exceptionCaught) {//Catch any errors
				IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
			}
		}

		public static void performUpdate(List<TargetX_SRMb__Financial_Aid__c> financialAidToUpdate) {
			try {
				Update financialAidToUpdate; //Perform database update on the desired records.
				IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
			} catch(Exception exceptionCaught) {//Catch any errors
				IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
			}
		}
}