public without sharing class IITTestScoreHandler { //Handles Application manipulation

	public static Id toeflRecordType;

static {
	toeflRecordType = Schema.SObjectType.TargetX_SRMb__Test__c.getRecordTypeInfosByName().get('TOEFL').getRecordTypeId(); //Get the record type ID for toefl
}

//Processing section
	public static void processTestList(List<TargetX_SRMb__Test__c> testsToProcess, Map<id, TargetX_SRMb__Test__c> oldTestMap, IITTriggerContext triggerContext) { //Processes a list of contacts
		try {
			if(triggerContext == IITTriggerContext.AFTER_INSERT) {
				//Suboptimized List processing here

				//Setup bulkified processing
				Map<id,String> contactProficiencyMap = new Map<id,String>(); //Initialize map of attempted proficiency pushes to contact.
				
				//Bulkified processing
				for(TargetX_SRMb__Test__c testToProcess : testsToProcess) {//Iterate through applications here for IIT managed code to prevent multiple for loops
					IITTestScoreHandler.processProficiency(testToProcess,contactProficiencyMap);
				}

				//Finalize bulkified processing
				IITContactHandler.assignEnglishProficiency(contactProficiencyMap);
			} else if(triggerContext == IITTriggerContext.AFTER_UPDATE) {
				//Suboptimized List processing here

				//Setup bulkified processing
				Map<id,String> contactProficiencyMap = new Map<id,String>(); //Initialize map of attempted proficiency pushes to contact.
				
				//Bulkified processing
				for(TargetX_SRMb__Test__c testToProcess : testsToProcess) {//Iterate through applications here for IIT managed code to prevent multiple for loops
					IITTestScoreHandler.processProficiency(testToProcess,contactProficiencyMap);
				}

				//Finalize bulkified processing
				IITTriggerHandler.bypass('IITContactTriggerHandler');//turn off contact triggers
				IITContactHandler.assignEnglishProficiency(contactProficiencyMap);//assess contact proficiencies
				IITTriggerHandler.clearBypass('IITContactTriggerHandler');//turn on contact triggers
			}
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}

//English proficiency section
	public static void processProficiency(TargetX_SRMb__Test__c testToAssess, Map<id,String> contactProficiencyMap) {//Assigns a proficiency update to contacts based on test scores
		if(testToAssess.recordTypeID == toeflRecordType
		&& testToAssess.TargetX_SRMb__Score_Validated__c
		) {//check that the record is a toefl and a valid testscore
			String proficiency = IITTestScoreHandler.compareProficiency(testToAssess.IIT_TOEFL_Proficiency__c, contactProficiencyMap.get(testToAssess.TargetX_SRMb__Contact__c)); //determine the winning proficiency

			if(String.isBlank(proficiency) == false) {//check that the proficiency is not false
				contactProficiencyMap.put(testToAssess.TargetX_SRMb__Contact__c, proficiency); //put the proficiency into the contact map
			}
		}//end if
	}//end method

	public static String compareProficiency(String firstProficiency, String secondProficiency) {//determines the proficiency between two values
		if(String.isBlank(firstProficiency)) {//check that first proficiency is blank or null
			return secondProficiency;
		}//end if

		if(String.isBlank(secondProficiency)) {//check that second proficiency is blank
			return firstProficiency;
		}//end if

		if(firstProficiency == 'Waived'
		|| secondProficiency == 'Waived'
		) {
			return 'Waived';
		}// end if

		if(firstProficiency == 'Proficient'
		|| secondProficiency == 'Proficient'
		) {
			return 'Proficient';
		}// end if

		if(firstProficiency == 'Needs Assessment'
		|| secondProficiency == 'Needs Assessment'
		) {
			return 'Needs Assessment';
		}//end if

		if(firstProficiency == 'Not Proficient'
		|| secondProficiency == 'Not Proficient'
		) {
			return 'Not Proficient';
		}//end if

		return null;

	}//end method
}