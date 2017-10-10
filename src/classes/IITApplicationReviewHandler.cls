public without sharing class IITApplicationReviewHandler { //Handles Application Review manipulation

	public static Map<Id,Targetx_Reader__Application_Review_Type__c> reviewTypeMap;

//Processing section
	public static void processApplicationReviewList(List<TargetX_Reader__Application_Review__c> applicationReviewsToProcess, Map<id, TargetX_Reader__Application_Review__c> oldApplicationReviewsMap, IITTriggerContext triggerContext) { //Processes a list of contacts
		try {
			if(triggerContext == IITTriggerContext.BEFORE_INSERT) {
				//Suboptimized List processing here

				//Setup bulkified processing
				
				//Bulkified processing
				for(TargetX_Reader__Application_Review__c applicationReviewToProcess : applicationReviewsToProcess) {//Iterate through applications here for IIT managed code to prevent multiple for loops
				}

				//Finalize bulkified processing
			} else if(triggerContext == IITTriggerContext.BEFORE_UPDATE) {
				//Suboptimized List processing here

				//Setup bulkified processing
				
				//Bulkified processing
				for(TargetX_Reader__Application_Review__c applicationReviewToProcess : applicationReviewsToProcess) {//Iterate through applications here for IIT managed code to prevent multiple for loops
					IITApplicationReviewHandler.populateDecisionMaker(applicationReviewToProcess,oldApplicationReviewsMap.get(applicationReviewToProcess.Id));//Populate the decision maker field if applicable
				}

				//Finalize bulkified processing
			} else if(triggerContext == IITTriggerContext.AFTER_INSERT) {
				//Suboptimized List processing here

				//Setup bulkified processing
				
				//Bulkified processing
				for(TargetX_Reader__Application_Review__c applicationReviewToProcess : applicationReviewsToProcess) {//Iterate through applications here for IIT managed code to prevent multiple for loops
				}

				//Finalize bulkified processing
			} else if(triggerContext == IITTriggerContext.AFTER_UPDATE) {
				//Suboptimized List processing here
				Map<Id,TargetX_Reader__Application_Review__c> reviewApplicationCloneMap = new Map<Id,TargetX_Reader__Application_Review__c>();

				//Setup bulkified processing
				
				//Bulkified processing
				for(TargetX_Reader__Application_Review__c applicationReviewToProcess : applicationReviewsToProcess) {//Iterate through applications here for IIT managed code to prevent multiple for loops
				}

				//Finalize bulkified processing
			}//end if
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}//end catch
	}//end function
	
	public static void reparentIncompleteReviews(List<TargetX_SRMb__Application__c> applicationsToRepopulate) {//Repopulates incomplete reviews to cloned application from old application
		Map<Id,Id> applicationIdCrosswalk = new Map<Id,Id>();

		for(TargetX_SRMb__Application__c applicationToMigrate : applicationsToRepopulate) {//Iterate through each application
			if(applicationToMigrate.IIT_Clone_Type__c == 'Defer'
			|| applicationToMigrate.IIT_Clone_Type__c == 'Change of Term'
			) {//Check that the change was a defer
				applicationIdCrosswalk.put(applicationToMigrate.IIT_Previous_Application__c,applicationToMigrate.id);
			}
		}
		
		if(applicationIdCrosswalk.size() == 0) {//Stop if there is nothing to be done.
			return;
		}
		
		Set<Id> applicationIdsToReparent = applicationIdCrosswalk.keySet();
		
		Map<Id,TargetX_Reader__Application_Review__c> appReviewsToReparent = new Map<Id,TargetX_Reader__Application_Review__c>([SELECT Id
		, TargetX_Reader__Application__c
		FROM TargetX_Reader__Application_Review__c
		WHERE TargetX_Reader__Completed__c = false
		AND TargetX_Reader__Application__c IN : applicationIdsToReparent
		]); //get the reviews to reparent.
		
		for(TargetX_Reader__Application_Review__c reviewToReparent : appReviewsToReparent.values()) {
			reviewToReparent.TargetX_Reader__Application__c = applicationIdCrosswalk.get(reviewToReparent.TargetX_Reader__Application__c);
		}
		
		update appReviewsToReparent.values();
	}

	public static void populateDecisionMaker(TargetX_Reader__Application_Review__c applicationReviewToProcess, TargetX_Reader__Application_Review__c oldApplicationReview) {//populates the decision maker if the application review is graduate and if the application 
		if(oldApplicationReview != null
		&& applicationReviewToProcess.TargetX_Reader__Completed__c == true
		&& String.isBlank(applicationReviewToProcess.IIT_Decision_Maker__c)
		&&	(applicationReviewToProcess.TargetX_Reader__Date_Completed__c == null
			|| Date.valueOf(applicationReviewToProcess.TargetX_Reader__Date_Completed__c).daysBetween(System.today()) <= 1
			)
		) {//Check that the old app review is not null, that the new app review is complete and is a graduate review, and that decision maker is not populated and we are within a day of the decision.
			applicationReviewToProcess.IIT_Decision_Maker__c = UserInfo.getUserId(); //Set the application review's decision maker to the last user to modify the application review
		}//end if
	}//end function
}