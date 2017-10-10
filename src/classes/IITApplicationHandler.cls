public without sharing class IITApplicationHandler { //Handles Application manipulation

	private static String applicationQuery; //Query for all writeable fields on an application
	private static Map<id,TargetX_App__Application_Process__c> applicationForms; //Map for all application forms.	@TestVisible
	private static Map<String, IIT_Review_Type_Mapping__c> reviewTypeMappings;
	public static Set<Id> clonedApplicationIds; //applications cloned, necessary because TargetX reupdates things for incomprehensible reasons.
	private static Map<String,Boolean> nonStandardUGApplicationTypeMap; //map of nonstandard undergraduate application types.

//Mapping section
	public static Map<String, IIT_Review_Type_Mapping__c> getReviewTypeMappings() {//generates and returns review type mappings
		if(IITApplicationHandler.reviewTypeMappings != null) {
			return IITApplicationHandler.reviewTypeMappings;
		}

		IITApplicationHandler.reviewTypeMappings = IIT_Review_Type_Mapping__c.getAll(); //Get all reviews defined in custom settings

		//Validate review type mapping
		Map<String,IIT_Review_Type_Mapping__c> keyedReviewTypeMappings = new Map<String,IIT_Review_Type_Mapping__c>();
		Set<String> removeReviewMappings = new Set<String>();//Initialize list of review mappings to remove

		//Loop through setting definitions
		for(IIT_Review_Type_Mapping__c reviewMapping : IITApplicationHandler.reviewTypeMappings.values() ) {
			try {
				Id reviewId = Id.valueOf(reviewMapping.Review_Type_ID__c);//Initialize the id from a string
				if( String.valueOf(reviewId.getSObjectType()) != 'TargetX_Reader__Application_Review_Type__c') {//Check that the id correlates to an application review type
					IITApplicationHandler.disableReviewTypeMapping(reviewMapping, removeReviewMappings);//stage the review type for removal
				}
			} catch(Exception badIdException) { //Any exceptions thrown will indicate a bad review type id
				IITApplicationHandler.disableReviewTypeMapping(reviewMapping, removeReviewMappings);//stage the review type for removal
			}
		}
		
		reviewTypeMappings.keySet().removeAll(removeReviewMappings); //Remove all invalid review mappings
		//TODO: update the disabled review types to indicate an issue
		return IITApplicationHandler.reviewTypeMappings;
	}

	private static void disableReviewTypeMapping(IIT_Review_Type_Mapping__c reviewTypeMapping, Set<String> removeReviewMappings) {//disable a review type mapping and stage it for list removal
		reviewTypeMapping.Disable__c = true; //Mark the review type as disabled
		removeReviewMappings.add(reviewTypeMapping.Name);//add the review type mapping to the list set for removal
	}

//Process Logic Section
	private static Map<String,Boolean> getNonStandardUGApplicationTypes() {
		if(IITApplicationHandler.nonStandardUGApplicationTypeMap == null) {//initialize the map if it is not present.
			IITApplicationHandler.nonStandardUGApplicationTypeMap = new map<String,Boolean>();
			IITApplicationHandler.nonStandardUGApplicationTypeMap.put('Undergraduate Brazilian Scientific Mobility Program',true);
			IITApplicationHandler.nonStandardUGApplicationTypeMap.put('Undergraduate Summer Research Opportunity',true);
		}

		return IITApplicationHandler.nonStandardUGApplicationTypeMap;
	}

	public static boolean isStandardUGApp(TargetX_SRMb__Application__c applicationToCheck) {
		return (applicationToCheck.TargetX_SRMb__Level__c == 'Undergraduate'
		&&	(String.isBlank(applicationToCheck.TargetX_SRMb__Application_Type__c)
			|| IITApplicationHandler.getNonStandardUGApplicationTypes().get(applicationToCheck.TargetX_SRMb__Application_Type__c) == null
			)
		);
	}

//Processing section
	public static void processApplicationList(List<TargetX_SRMb__Application__c> applicationsToProcess, Map<id, TargetX_SRMb__Application__c> oldApplicationsMap, IITTriggerContext triggerContext) { //Processes a list of contacts
		try {
			if(triggerContext == IITTriggerContext.BEFORE_INSERT) {
				//Suboptimized List processing here

				//Setup bulkified processing
				
				//Bulkified processing
				for(TargetX_SRMb__Application__c applicationToProcess : applicationsToProcess) {//Iterate through applications here for IIT managed code to prevent multiple for loops
					IITApplicationHandler.sanitizeCountry(applicationToProcess, null); //sanitize country
					IITApplicationHandler.sanitizeDecision(applicationToProcess); //sanitize admit decisions.
					IITApplicationHandler.sanitizeApplicationDates(applicationToProcess, null); //Stage application dates for this application
					IITApplicationHandler.populateApplicationType(applicationToProcess); //populate the application type
					IITApplicationHandler.populateReviewType(applicationToProcess, null); //populate the application review type.
				}

				//Finalize bulkified processing
			} else if(triggerContext == IITTriggerContext.BEFORE_UPDATE) {
				//Suboptimized List processing here

				//Setup bulkified processing
				
				//Bulkified processing
				for(TargetX_SRMb__Application__c applicationToProcess : applicationsToProcess) {//Iterate through applications here for IIT managed code to prevent multiple for loops
					IITApplicationHandler.sanitizeCountry(applicationToProcess, oldApplicationsMap.get(applicationToProcess.Id)); //sanitize country
					IITApplicationHandler.sanitizeDecision(applicationToProcess); //sanitize admit decisions.
					IITApplicationHandler.sanitizeApplicationDates(applicationToProcess, oldApplicationsMap.get(applicationToProcess.Id)); //Stage application dates for this application
					IITApplicationHandler.populateApplicationType(applicationToProcess); //populate the application type
					IITApplicationHandler.populateEnrollmentLimit(applicationToProcess, oldApplicationsMap.get(applicationToProcess.Id)); //Populates Enrollment Limit for the application
					IITApplicationHandler.populateReviewType(applicationToProcess, null); //populate the application review type.
				}

				//Finalize bulkified processing
			} else if(triggerContext == IITTriggerContext.AFTER_INSERT) {
				//Suboptimized List processing here

				//Setup bulkified processing
				Map<id,TargetX_SRMb__Application__c> applicationstoContacts = new Map<Id,TargetX_SRMb__Application__c>();//map of applications to roll up to contacts
				
				//Bulkified processing
				for(TargetX_SRMb__Application__c applicationToProcess : applicationsToProcess) {//Iterate through applications here for IIT managed code to prevent multiple for loops
					IITRecruitmentPathHandler.stageRecruitmentPathForNewApplication(applicationToProcess); //Stage recruitment path for this application
					IITApplicationHandler.rollUpToContact(applicationToProcess, null, applicationstoContacts); //populate contact application rollups.
				}

				//Finalize bulkified processing
				IITTriggerHandler.bypass('IITContactTriggerHandler');//turn off contact triggers
				IITRecruitmentPathHandler.processStagedRecruitmentPaths(); //process all recruitment paths stages per application.
				IITContactHandler.rollupApplicationData(applicationstoContacts);//assess contact rollup
				IITTriggerHandler.clearBypass('IITContactTriggerHandler');//turn on contact triggers
			} else if(triggerContext == IITTriggerContext.AFTER_UPDATE) {
				//Suboptimized List processing here

				//Setup bulkified processing
				Map<id,TargetX_SRMb__Application__c> applicationstoContacts = new Map<Id,TargetX_SRMb__Application__c>();//map of applications to roll up to contacts
				Map<Id,TargetX_SRMb__Application__c> applicationsToClone = new Map<Id,TargetX_SRMb__Application__c>();
				
				//Bulkified processing
				for(TargetX_SRMb__Application__c applicationToProcess : applicationsToProcess) {//Iterate through applications here for IIT managed code to prevent multiple for loops
					IITRecruitmentPathHandler.stageRecruitmentPathForApplication(applicationToProcess, oldApplicationsMap.get(applicationToProcess.Id)); //Stage recruitment path for this application, checking against old application
					IITApplicationHandler.processDenyRecommend(applicationToProcess,oldApplicationsMap.get(applicationToProcess.Id),applicationsToClone);
					IITApplicationHandler.rollUpToContact(applicationToProcess, null, applicationstoContacts); //populate contact application rollups.
				}

				//Finalize bulkified processing
				IITTriggerHandler.bypass('IITContactTriggerHandler');//turn off contact triggers
				IITRecruitmentPathHandler.processStagedRecruitmentPaths(); //process all recruitment paths stages per application.
				IITContactHandler.rollupApplicationData(applicationstoContacts);//assess contact rollup
				IITTriggerHandler.clearBypass('IITContactTriggerHandler');//turn on contact triggers

				if(applicationsToClone.size() > 0) {//Check that we have applications to clone
					IITApplicationHandler.cloneApplication(new List<Id>(applicationsToClone.keySet())); //Clone all applicable applications.
				}
			}
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}
//Sanitization section
	public static void sanitizeCountry(TargetX_SRMb__Application__c applicationToSanitize, TargetX_SRMb__Application__c oldApplication) {//sanitizes an application's country
		//TODO: Once we have all old apps sanitized, add check for country change
		applicationToSanitize.Citizenship_Country__c = IITAddressHandler.sanitizeCountry(applicationToSanitize.Citizenship_Country__c); //call address handler country sanitization		
	}//end method

	//Application Type Population
	public static void populateApplicationType(TargetX_SRMb__Application__c applicationToPopulate) {//Populates the application type from the application's associated application form
		if(applicationToPopulate == null
		|| applicationToPopulate.TargetX_App__Application_Process__c == null
		|| applicationToPopulate.TargetX_SRMb__Application_Type__c != null
		) { //Check that the application is null or the application is not graduate or the application process isn't populated, or that the application type is populated
			return; //do nothing
		}

		applicationToPopulate.TargetX_SRMb__Application_Type__c = IITApplicationHandler.getApplicationForms().get(applicationToPopulate.TargetX_App__Application_Process__c).TargetX_App__Application_Type__c; //Set the application type from the map of processes
		IITApplicationHandler.processApplicationType(applicationToPopulate);
	}

	private static void processApplicationType(TargetX_SRMb__Application__c applicationToPopulate) {
		if(applicationToPopulate.TargetX_SRMb__Application_Type__c == null) {//check that the application type is null
			return; //do nothing
		} else if(applicationToPopulate.TargetX_SRMb__Application_Type__c.startsWith('Intensive English Program')) {//check for IEP
			applicationToPopulate.TargetX_SRMb__Degree__c = 'IEP Certificate'; //populate degree
			applicationToPopulate.TargetX_SRMb__Possible_Academic_Major__c = 'Intensive English'; //populate major
			IITProgramHandler.determineProgramForApplication(applicationToPopulate);
		} else if(applicationToPopulate.TargetX_SRMb__Application_Type__c == 'Undergraduate Summer Research Opportunity') {//Process Undergraduate Summer Research Opportunity
			applicationToPopulate.TargetX_SRMb__Student_Type__c = 'Visiting';
			applicationToPopulate.Special_Program__c = 'Summer Research';
		}
	}

	private static Map<id,TargetX_App__Application_Process__c> getApplicationForms() {//populates all application forms mapped by Id
		if(IITApplicationHandler.applicationForms != null) { //Check that we haven't already initialized the form list
			return IITApplicationHandler.applicationForms;
		}

		IITApplicationHandler.applicationForms = new Map<id,TargetX_App__Application_Process__c>([SELECT Id
			, TargetX_App__Application_Type__c
			FROM TargetX_App__Application_Process__c
			]);//populate static application process list

		return IITApplicationHandler.applicationForms;
	}

	//Review Type Population
	public static void populateReviewType(TargetX_SRMb__Application__c applicationToPopulate, TargetX_SRMb__Application__c oldApplication) {
		for(IIT_Review_Type_Mapping__c reviewMapping : IITApplicationHandler.getReviewTypeMappings().values()) { //Iterate through each review mapping
			if(reviewMapping.Level__c == applicationToPopulate.TargetX_SRMb__Level__c
			&& reviewMapping.Processing_Status__c != applicationToPopulate.IIT_Application_Processing_Status__c
			&& (reviewMapping.Application_Type__c == null
				|| reviewMapping.Application_Type__c == applicationToPopulate.TargetX_SRMb__Application_Type__c
				)
			&& (reviewMapping.Department__c == null
				|| reviewMapping.Department__c == applicationToPopulate.Department__c
				)
			&& (reviewMapping.Sent_To_Faculty_For_Review__c == 0
				||	(reviewMapping.Sent_To_Faculty_For_Review__c == 1
					&& applicationToPopulate.IIT_Sent_For_Faculty_Decision__c == null
					)
				||	(reviewMapping.Sent_To_Faculty_For_Review__c == 2
					&& applicationToPopulate.IIT_Sent_For_Faculty_Decision__c != null
					)
				)
			&& (reviewMapping.Status__c == null
				|| reviewMapping.Status__c == applicationToPopulate.TargetX_SRMb__Status__c
				)
			) {
				applicationToPopulate.IIT_Review_Type__c = Id.valueOf(reviewMapping.Review_Type_ID__c);
				return;
			}
		}
	}

	//Date Sanitization
	public static void sanitizeApplicationDates(TargetX_SRMb__Application__c applicationToSanitize, TargetX_SRMb__Application__c oldApplication) {
		if (applicationToSanitize.TargetX_SRMb__Stage__c == 'Submitted') {//Check that the application is submitted
			IITApplicationHandler.sanitizeApplicationDate(applicationToSanitize,'TargetX_SRMb__Application_Submit_Date__c'); //sanitize submit date

			//Check for decision
			if(applicationToSanitize.TargetX_SRMb__Application_Decision__c != null) {//Check that a decision has been made to save cycles
				IITApplicationHandler.sanitizeApplicationDate(applicationToSanitize,'IIT_Application_Decision_Date__c'); //sanitize decision date

				if(oldApplication != null
				&& applicationToSanitize.TargetX_SRMb__Application_Decision__c != oldApplication.TargetX_SRMb__Application_Decision__c
				&& oldApplication.IIT_Application_Decision_Date__c != null
				&& oldApplication.IIT_Application_Decision_Date__c < system.today()
				) {//Check for a decision change and override the date with today
					applicationToSanitize.IIT_Application_Decision_Date__c = system.today();
				}

				if(applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'Admit No Financial Support'
				|| applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'Admit to Alternate No Financial Support'
				) {
					IITApplicationHandler.sanitizeApplicationDateSpecified(applicationToSanitize,'IIT_Admit_No_Financial_Support_Date__c', applicationToSanitize.IIT_Application_Decision_Date__c);
				}

				if(applicationToSanitize.IIT_Application_Processing_Status__c == 'Decision Approved'
				&&	(applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'Admit'
					|| applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'Admit Conditional'
					|| applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'Admit to Alternate'
					)
				) {
					IITApplicationHandler.sanitizeApplicationDateSpecified(applicationToSanitize,'IIT_Admit_Date__c', system.today());
				}

				if(applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'JC Deny'
				|| applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'Deny'
				|| applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'English Deny'
				|| applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'Denied to Applied'
				) {
					IITApplicationHandler.sanitizeApplicationDateSpecified(applicationToSanitize,'IIT_Deny_Date__c', applicationToSanitize.IIT_Application_Decision_Date__c);
				}
			}

			//check for intent to enroll
			if(String.isBlank(applicationToSanitize.TargetX_SRMb__Deposit_Intent_to_Enroll__c) == false) {
				IITApplicationHandler.sanitizeApplicationDate(applicationToSanitize,'IIT_Deposit_Intent_to_Enroll_Date__c'); //sanitize intent to enroll date
			}

			//check for deposit
			if(applicationToSanitize.TargetX_SRMb__Accept_Enrollment_Deposit__c == TRUE) {
				IITApplicationHandler.sanitizeApplicationDate(applicationToSanitize,'IIT_Accept_Enrollment_Deposit_Date__c'); //sanitize deposit date
			}

			//check for Complete
			if(applicationToSanitize.TargetX_SRMb__Status__c == 'Complete') {//check for complete
				IITApplicationHandler.sanitizeApplicationDate(applicationToSanitize,'IIT_Application_Complete_Date__c'); //sanitize withdrawn date
			}
			else if(applicationToSanitize.TargetX_SRMb__Status__c == 'Deferred') {//check for deferred
				IITApplicationHandler.sanitizeApplicationDate(applicationToSanitize,'IIT_Deferred_Date__c'); //sanitize withdrawn date
			}
			else if(applicationToSanitize.TargetX_SRMb__Status__c == 'Withdrawn') {//Check for withdrawn
				IITApplicationHandler.sanitizeApplicationDate(applicationToSanitize,'IIT_Withdrawn_Date__c'); //sanitize withdrawn date
			}


		} else {//assume in progress if not submitted
			IITApplicationHandler.sanitizeApplicationDate(applicationToSanitize,'IIT_Application_Start_Date__c'); //sanitize stage date

			//check for Withdrawn
			if(applicationToSanitize.TargetX_SRMb__Status__c == 'Withdrawn') {//Check for withdrawn
				IITApplicationHandler.sanitizeApplicationDate(applicationToSanitize,'IIT_Withdrawn_Date__c'); //sanitize withdrawn date
			}
		}
	}

	private static void sanitizeApplicationDate(TargetX_SRMb__Application__c applicationToSanitize, String dateField) {//checks if a date field is null and populates it with today's date
		sanitizeApplicationDateSpecified(applicationToSanitize,dateField,system.today());
	}

	private static void sanitizeApplicationDateSpecified(TargetX_SRMb__Application__c applicationToSanitize, String dateField, Date dateToPopulate) {//checks if a date field is null and populates it with today's date
		if(applicationToSanitize.get(dateField) == null) { //Check that the date field is null
			applicationToSanitize.put(dateField, dateToPopulate ); //populate the date field with today
		}
	}

	public static void sanitizeDecision(TargetX_SRMb__Application__c applicationToSanitize) {//changes an application to admit AL if appropriate.
		if(IITApplicationHandler.isStandardUGApp(applicationToSanitize) == false
		&& applicationToSanitize.IIT_Application_Processing_Status__c == 'Decision Approved'
		) {
			if(applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'Deny') {//Decision is deny
				if(applicationToSanitize.TargetX_SRMb__Degree__c == 'Master'
				&& applicationToSanitize.TargetX_SRMb__Possible_Academic_Major__c == 'Mathematical Finance'
				) {//Master of Mathematical finance deny always becomes denied to applied to Master of Science in Finance
					applicationToSanitize.TargetX_SRMb__Application_Decision__c = 'Denied to Applied';
					applicationToSanitize.IIT_New_Program__c = 'a1Sj000000107CmEAI';//MS-FIN-1 id
				} else if (applicationToSanitize.TargetX_SRMb__Degree__c == 'Master of Science'
				&& applicationToSanitize.TargetX_SRMb__Possible_Academic_Major__c == 'Finance'
				) {//Master of Science in Finance always becomes denied to applied to MBA
					applicationToSanitize.TargetX_SRMb__Application_Decision__c = 'Denied to Applied';
					applicationToSanitize.IIT_New_Program__c = 'a1Sj000000107C3EAI';//MBA id
				}//end if
			} else if(applicationToSanitize.IIT_Is_International__c == true
			&& applicationToSanitize.TargetX_SRMb__Student_Type__c != 'Online'
			&& applicationToSanitize.TargetX_SRMb__Student_Type__c != 'India Online'
			&& applicationToSanitize.TargetX_SRMb__College__c != 'Institute of Design'
			) {//if decision approved graduate international applications
				if(applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'Admit'
				&& applicationToSanitize.IIT_Complete_Financial_Support_Docs__c == 0
				) {//if decision is admit and number of completed financial support docs is 0
					applicationToSanitize.TargetX_SRMb__Application_Decision__c = 'Admit No Financial Support'; //set the decision to admit no financial support
				} else if(applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'Admit To Alternate'
				&& applicationToSanitize.IIT_Complete_Financial_Support_Docs__c == 0
				) {//if decision is admit to alternate and number of completed financial support docs is 0
					applicationToSanitize.TargetX_SRMb__Application_Decision__c = 'Admit to Alternate No Financial Support'; //Set the decision to admit to alternate no financial support
				} else if(applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'Admit No Financial Support'
				&& applicationToSanitize.IIT_Complete_Financial_Support_Docs__c > 0
				) { //if the decision is admit no financial support and the number of completed financial support docs is greater than 0
					applicationToSanitize.TargetX_SRMb__Application_Decision__c = 'Admit'; //Set the decision to admit.
				} else if(applicationToSanitize.TargetX_SRMb__Application_Decision__c == 'Admit To Alternate No Financial Support'
				&& applicationToSanitize.IIT_Complete_Financial_Support_Docs__c > 0
				) { //if the decision is admit to alternate no financial support and the number of completed financial support docs is greater than 0
					applicationToSanitize.TargetX_SRMb__Application_Decision__c = 'Admit to Alternate'; //Set the decision to admit to alternate
				}
			}//end if
		}//end if
	}//end method
//Enrollment Limit section
	public static void populateEnrollmentLimit(TargetX_SRMb__Application__c applicationToProcess, TargetX_SRMb__Application__c oldApplication) {
		//TODO: Bulkify the heck out of this
		if(applicationToProcess.TargetX_SRMb__Application_Type__c != 'Undergraduate Summer Research Opportunity'
		|| applicationToProcess.IIT_Enrollment_Limit__c != null
		|| applicationToProcess.TargetX_App__Deadline__c == null
		) {//check that we have the criteria to assign an enrollment limit
			return;
		}//end if

		TargetX_Base__Period_Deadline__c deadline = [SELECT Id
		, Name
		FROM TargetX_Base__Period_Deadline__c
		WHERE id = :applicationToProcess.TargetX_App__Deadline__c
		LIMIT 1]; //get the deadline

		if(deadline == null) {//check that the deadline is not null
			return;
		}//end if

		Date startDate;

		if(deadline.Name == 'Summer 2016 Research 5/22/2016') {
			startDate = Date.newInstance(2016,5,22);
		} else if(deadline.Name == 'Summer 2016 Research 6/5/2016') {
			startDate = Date.newInstance(2016,6,5);
		}//end deadline name if

		if(startDate == null) {//check that the start date is null
			return;
		}//end if

		IIT_Enrollment_Limit__c enrollmentLimit = [SELECT Id
		, IIT_Reviewer__c
		FROM IIT_Enrollment_Limit__c
		WHERE IIT_Title__c = :applicationToProcess.IIT_BSMP_Research_Title__c
		AND IIT_Start_Date__c = :startDate
		AND RecordType.Name = 'BSMP Summer Research'
		LIMIT 1];

		if(enrollmentLimit == null) {//check that the enrollment limit is null
			return;
		}//end if

		applicationToProcess.IIT_Enrollment_Limit__c = enrollmentLimit.id;
		applicationToProcess.IIT_Application_Owner__c = enrollmentLimit.IIT_Reviewer__c;
	}//end function
//Contact rollup section
	public static void rollUpToContact(TargetX_SRMb__Application__c applicationToRollup, TargetX_SRMb__Application__c oldApplication, Map<id,TargetX_SRMb__Application__c> applicationstoContacts) {//determines contact rollup data
		if(oldApplication != null
		&& applicationToRollup.IIT_Application_Priority__c == oldApplication.IIT_Application_Priority__c
		&& applicationToRollup.Citizenship_Status__c == oldApplication.Citizenship_Status__c
		&& applicationToRollup.Citizenship_Country__c == oldApplication.Citizenship_Country__c
		&& applicationToRollup.IIT_Application_Start_Date__c == oldapplication.IIT_Application_Start_Date__c
		&& applicationToRollup.TargetX_SRMb__Application_Submit_Date__c == oldapplication.TargetX_SRMb__Application_Submit_Date__c
		&& applicationToRollup.IIT_Application_Complete_Date__c == oldapplication.IIT_Application_Complete_Date__c
		&& applicationToRollup.IIT_Admit_No_Financial_Support_Date__c == oldapplication.IIT_Admit_No_Financial_Support_Date__c
		&& applicationToRollup.IIT_Admit_Date__c == oldapplication.IIT_Admit_Date__c
		&& applicationToRollup.IIT_Deny_Date__c == oldapplication.IIT_Deny_Date__c
		&& applicationToRollup.IIT_Deposit_Intent_to_Enroll_Date__c == oldapplication.IIT_Deposit_Intent_to_Enroll_Date__c
		&& applicationToRollup.IIT_Accept_Enrollment_Deposit_Date__c == oldapplication.IIT_Accept_Enrollment_Deposit_Date__c
		&& applicationToRollup.IIT_Deferred_Date__c == oldapplication.IIT_Deferred_Date__c
		&& applicationToRollup.IIT_Withdrawn_Date__c == oldapplication.IIT_Withdrawn_Date__c
		) {//Check that the application is graduate and, if an old application exists, that the application's relevant data has changed.
			return; //Do nothing
		}//end if

		TargetX_SRMb__Application__c stagedApplication = applicationstoContacts.get(applicationToRollup.TargetX_SRMb__Contact__c); //get any applications mapped to the contact from the current map

		if(stagedApplication != null
		&& stagedApplication.IIT_Application_Priority__c >= applicationToRollup.IIT_Application_Priority__c
		) {//check that the staged application exists and its priority is greater than or equal to the current application being checked
			return; //Do nothing
		}//end if

		applicationstoContacts.put(applicationToRollup.TargetX_SRMb__Contact__c, applicationToRollup); //add the application to the list to roll up
	}//end method

//App cloning section
	public static Set<id> getClonedApplicationIds() {//Initialized cloned applications if it is null and returns it.
		if(IITApplicationHandler.clonedApplicationIds == null) {
			IITApplicationHandler.clonedApplicationIds = new Set<Id>();
		}
		
		return IITApplicationHandler.clonedApplicationIds;
	}

	public static void processDenyRecommend(TargetX_SRMb__Application__c applicationToClone,  TargetX_SRMb__Application__c oldApplication, Map<Id,TargetX_SRMb__Application__c> applicationsToClone) {
		if(oldApplication != null
		&& applicationToClone.TargetX_SRMb__Stage__c == 'Submitted'
		&& applicationToClone.TargetX_SRMb__Status__c == 'Decision Made'
		&& applicationToClone.IIT_Application_Processing_Status__c == 'Decision Approved'
		&& applicationToClone.TargetX_SRMb__Application_Decision__c == 'Denied to Applied'
		&& (String.isBlank(oldApplication.TargetX_SRMb__Application_Decision__c)
			|| oldApplication.TargetX_SRMb__Application_Decision__c != 'Denied to Applied'
			)
		) {//Application is in a position for a complete decision and application was not Denied to Applied
			if(IITApplicationHandler.getClonedApplicationIds().contains(applicationToClone.id) == false) {//Check that we haven't already cloned this application
				applicationsToClone.put(applicationToClone.id,applicationToClone);//add the application to the list of those that need to be cloned
				IITApplicationHandler.getClonedApplicationIds().add(applicationToClone.id); //Add the application id to the exclusion list.
			}//end if
		}//end if
	}//end if

	@InvocableMethod
	public static void cloneApplication(List<Id> applicationIds) {//Invocable from Process Builder, clones a list of applications and applies program info to them
		try {
			Map<id,TargetX_SRMb__Application__c> currentApplications = new Map<id,TargetX_SRMb__Application__c>( (List<TargetX_SRMb__Application__c>)Database.Query(IITApplicationHandler.getApplicationQuery() + 'Id IN :applicationIds FOR UPDATE')); //dynamically pull the applications with all writeable fields
			Set<Id> programIds = new Set<Id>(); //Id set to store programs for SOQL query

			for(TargetX_SRMb__Application__c currentApplication : currentApplications.values() ) {
				if(currentApplication.IIT_New_Program__c != null) {//Check that the new program is not null.
					programIds.add( Id.valueOf(currentApplication.IIT_New_Program__c) ); //get the program id and add it to the set.
				}
			}

			Map<id,IIT_Program__c> relevantPrograms = new Map<id,IIT_Program__c>([SELECT Id
			, IIT_Level__c
			, IIT_Degree__c
			, IIT_Major__c
			FROM IIT_Program__c
			WHERE Id IN :programIds]); //Get the programs in memory
			Map<id,TargetX_SRMb__Application__c> clonedApplications = new Map<id,TargetX_SRMb__Application__c>(); //Cloned application map

			for(Integer i = 0; i < applicationIds.size(); i++) { //iterate through each application
				if(currentApplications.get(applicationIds[i]).IIT_New_Program__c != null) {//Check that the new program is not null
					clonedApplications.put(applicationIds[i],
						IITApplicationHandler.cloneApplication(
							currentApplications.get(applicationIds[i])
							, relevantPrograms.get(
								Id.valueOf(currentApplications.get(applicationIds[i]).IIT_New_Program__c)
							)
						)
					); //clone the application and apply program information to it
				} else { //no valid conditions met. Throw an error! Do a barrel roll!
					throw new IITGenericException('Invalid clone operation attempted on application :' + String.valueOf(applicationIds[i]) + '. No semesters or programs specified.');
				}
			}

			IITTriggerHandler.bypass('IITContactTriggerHandler');//turn off contact triggers
			IITApplicationHandler.performInsert(clonedApplications.values());//Safely insert applications
			IITTriggerHandler.clearBypass('IITContactTriggerHandler');//turn on contact triggers

			Map<Id,Id> attachmentIdMap = new Map<Id,Id>();//Initialize Id map for attacments
			IITEssayHandler.copyEssaysForApplication(clonedApplications.values(),attachmentIdMap);//Clone essays
			IITRecommendationHandler.copyRecommendationsForApplication(clonedApplications.values(),attachmentIdMap);//Clone essays
			IITEnrollmentHistoryHandler.reparentEnrollmentHistoryApplication(clonedApplications.values());//Clone enrollment histories
			IITFinancialAidHandler.copyFinancialAidForApplication(clonedApplications.values(),attachmentIdMap);//clone financial aid
			IITAttachmentHandler.cloneAttachments(attachmentIdMap);//Clone attachments
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}

	private static TargetX_SRMb__Application__c cloneApplication(TargetX_SRMb__Application__c applicationToClone, IIT_Program__c programToApply) {
		TargetX_SRMb__Application__c applicationToReturn = applicationToClone.clone(false,true,false,false);
		
		// Set the last data input source to null in order to feed an application to banner via Axiom
		applicationToReturn.TargetX_SRMb__Last_Data_Input_Source__c = null;

		//Map application overrides
		applicationToReturn.IIT_Spawned_Application__c = true;
		applicationToReturn.IIT_Previous_Application__c = applicationToClone.Id;
		
		//Clear Unique Key Values
		applicationToReturn.IIT_Banner_Application_Number__c = null;
		applicationToReturn.IIT_Banner_PIDM_Application_Number_Key__c = null;
		applicationToReturn.TargetX_SRMb__Application_Key__c = null;
		applicationToReturn.IIT_New_Program__c = null;		
		applicationToReturn.IIT_Common_App_ID__c = null;

		//Set dates
		applicationToReturn.IIT_Application_Start_Date__c = system.today();
		applicationToReturn.TargetX_SRMb__Application_Submit_Date__c = null;
		applicationToReturn.IIT_Application_Complete_Date__c = null;
		applicationToReturn.IIT_Application_Decision_Date__c = null;
		applicationToReturn.IIT_Admit_No_Financial_Support_Date__c = null;
		applicationToReturn.IIT_Admit_Date__c = null;
		applicationToReturn.IIT_Deny_Date__c = null;
		applicationToReturn.IIT_Deposit_Intent_to_Enroll_Date__c = null;
		applicationToReturn.IIT_Accept_Enrollment_Deposit_Date__c = null;
		applicationToReturn.IIT_Enrollment_Deposit_Waived_Dat__c = null;
		applicationToReturn.IIT_Deferred_Date__c = null;
		applicationToReturn.IIT_Withdrawn_Date__c = null;
		applicationToReturn.TargetX_SRMb__Deposit_Paid_Date__c = null;
		applicationToReturn.IIT_Deposit_Extension_Date__c = null;

		//Clear I-20 and letter information
		applicationToReturn.IIT_I_20_Created_By__c = null;
		applicationToReturn.IIT_I_20_Created_Date__c = null;
		applicationToReturn.IIT_I_20_Sent_Date__c = null;
		applicationToReturn.IIT_Physical_Decision_Letter_Created_Dt__c = null;
		applicationToReturn.IIT_Physical_Decision_Letter_Sent_Date__c = null;
		applicationToReturn.IIT_Tracking_Number__c = null;
		applicationToReturn.IIT_Batch_Shipped__c = FALSE;
		applicationToReturn.IIT_India_or_China_Local_Tracking_Number__c = null;
		applicationToReturn.IIT_I_20_in_Progress_Notes__c = null;
		applicationToReturn.IIT_Grad_Funding_Letter_Sent__c = null;

		//Set Deposit and Intent to Enroll Information
		applicationToReturn.TargetX_SRMb__Accept_Enrollment_Deposit__c = FALSE;
		applicationToReturn.TargetX_SRMb__Deposit_Amount__c = null;
		applicationToReturn.TargetX_SRMb__Deposit_Authorization_Number__c = null;
		applicationToReturn.TargetX_SRMb__Deposit_Intent_to_Enroll__c = null;
		applicationToReturn.TargetX_SRMb__Deposit_Signature__c = null;
		applicationToReturn.IIT_Deferred_Deposit_Confirmation__c = null;
		applicationToReturn.IIT_Deposit_Extension_Approved__c = FALSE;
		applicationToReturn.IIT_Enrollment_Deposit_Waived__c = FALSE;

		//Set Fee Information
		applicationToReturn.TargetX_SRMb__Application_Fee_Amount__c = null;
		applicationToReturn.TargetX_SRMb__Application_Fee_Payment_Received__c = FALSE;
		applicationToReturn.TargetX_SRMb__Application_Fee_Payment_Type__c = null;
		applicationToReturn.TargetX_SRMb__Application_Fee_Received_Date__c = null;
		applicationToReturn.TargetX_SRMb__CC_Approval_Number__c = null;
		applicationToReturn.TargetX_SRMb__CC_Transaction_Approval__c = FALSE;
		
		//Set Fee Waiver Information
		applicationToReturn.IIT_Fee_Waiver_Code__c = 'Generated Application';
		applicationToReturn.TargetX_SRMb__Fee_Waiver_Request__c = TRUE;
		applicationToReturn.TargetX_SRMb__Fee_Waiver_Decision__c = 'Approved';
		applicationToReturn.TargetX_SRMb__Fee_Waiver_Description__c = 'Fee waiver granted to apply to deny or to deferred applications.';
		applicationToReturn.TargetX_SRMb__Fee_Decision_By__c = UserInfo.getUserId();
		applicationToReturn.TargetX_SRMb__Fee_Waiver_Decision_Date__c = system.today();
		applicationToReturn.TargetX_SRMb__Fee_Waiver_Decision_Reason__c	= 'All applications generated as a defer or as a deny to applied have their application fee waived.';

		//Map old application data
		applicationToReturn.IIT_Previous_Program__c = applicationToReturn.TargetX_SRMb__Program__c;
		applicationToReturn.IIT_Previous_Term__c = applicationToReturn.TargetX_SRMb__Start_Term__c;
		applicationToReturn.IIT_Previous_Year__c = Integer.valueOf(applicationToReturn.TargetX_SRMb__Start_Term_Year__c);

		if(applicationToReturn.IIT_Original_Application__c == null) {
			applicationToReturn.IIT_Original_Application__c = applicationToReturn.IIT_Previous_Application__c;
		}

	    if( String.isBlank(applicationToReturn.IIT_Original_Program__c) ) {
	    	applicationToReturn.IIT_Original_Program__c = applicationToReturn.IIT_Previous_Program__c;
	    }

	    if( String.isBlank(applicationToReturn.IIT_Original_Term__c) ) {
	    	applicationToReturn.IIT_Original_Term__c = applicationToReturn.IIT_Previous_Term__c;
	    }

	    if( applicationToReturn.IIT_Original_Year__c == null ) {
	    	applicationToReturn.IIT_Original_Year__c = applicationToReturn.IIT_Previous_Year__c;
	    }

	    //Handle defers
	    if(applicationToReturn.IIT_New_Start_Year__c != null
	    && String.isBlank(applicationToReturn.IIT_New_Start_Term__c) == false
	    ) {
	    	applicationToReturn.TargetX_SRMb__Start_Term_Year__c = String.valueOf(applicationToReturn.IIT_New_Start_Year__c);
	    	applicationToReturn.TargetX_SRMb__Start_Term__c = applicationToReturn.IIT_New_Start_Term__c;
	    	applicationToReturn.IIT_New_Start_Term__c = null;
	    	applicationToReturn.IIT_New_Start_Year__c = null;

	    	if( String.isBlank(applicationToReturn.TargetX_SRMb__Application_Decision__c) == false
	    	&& applicationToReturn.TargetX_SRMb__Application_Decision__c != 'Pending'
	    	&&	(applicationToReturn.IIT_Application_Processing_Status__c == 'Pending Final Review'
	    		|| applicationToReturn.IIT_Application_Processing_Status__c == 'Decision Approved'
	    		)
	    	) {//Application is able to be deferred
				applicationToReturn.IIT_Clone_Type__c = 'Defer';
				applicationToReturn.IIT_Application_Decision_Date__c = system.today();

				if(applicationToReturn.TargetX_SRMb__Level__c == 'Undergraduate'
				&& (
					applicationToClone.IIT_Enrollment_Deposit_Waived__c
					|| applicationToClone.TargetX_SRMb__Accept_Enrollment_Deposit__c
					)
				) {//Level is undergraduate and a deposit was waived or paid
					applicationToReturn.IIT_Enrollment_Deposit_Waived__c = true;
					applicationToReturn.IIT_Enrollment_Deposit_Waived_Dat__c = System.today();
				}

			} else {
				applicationToReturn.IIT_Clone_Type__c = 'Change of Term';
			}
	    }
	    else if(programToApply != null) {//Else, handle this as admit to alternate.
	    	applicationToReturn.TargetX_SRMb__Stage__c = 'Submitted';
			applicationToReturn.TargetX_SRMb__Status__c = 'Complete';
			applicationToReturn.IIT_Clone_Type__c = 'Admit to Alternate';

			if(programToApply.IIT_Level__c == 'Graduate') {
				if(
					(applicationToClone.TargetX_SRMb__Degree__c == 'Master'
					&& applicationToClone.TargetX_SRMb__Possible_Academic_Major__c == 'Mathematical Finance'
					&& programToApply.IIT_Degree__c == 'Master of Science'
					&& programToApply.IIT_Major__c == 'Finance'
					)
				||	(applicationToClone.TargetX_SRMb__Degree__c == 'Master of Science'
					&& applicationToClone.TargetX_SRMb__Possible_Academic_Major__c == 'Finance'
					&& programToApply.IIT_Degree__c == 'Master'
					&& programToApply.IIT_Major__c == 'Business Administration'
					)
				) {
					applicationToReturn.IIT_Application_Processing_Status__c = 'Pending Initial Review';
					applicationToReturn.TargetX_SRMb__Application_Decision__c = null;
					applicationToReturn.IIT_Application_Decision_Date__c = null;
				} else {
					applicationToReturn.IIT_Application_Processing_Status__c = 'Pending Decision';
					applicationToReturn.TargetX_SRMb__Application_Decision__c = 'Admit to Alternate';
					applicationToReturn.IIT_Application_Decision_Date__c = system.today();

					if(programToApply.IIT_Degree__c == 'Non-Degree Graduate'
					&& programToApply.IIT_Major__c == 'Information Technology and Management'
					&& applicationToReturn.Citizenship_Country__c == 'India'
					) {//Admit to Alternate for India NDG-ITM should default to India Online
						applicationToReturn.TargetX_SRMb__Student_Type__c = 'India Online';
					}
				}
			}
		}

		//Map new program data
		if(programToApply != null) {
			applicationToReturn.TargetX_SRMb__Level__c = programToApply.IIT_Level__c;
			applicationToReturn.TargetX_SRMb__Degree__c = programToApply.IIT_Degree__c;
			applicationToReturn.TargetX_SRMb__Possible_Academic_Major__c = programToApply.IIT_Major__c;
		}//end if

		return applicationToReturn;
	}

	public static String getApplicationQuery() {//Initializes the application field map and query for all fields
		if(IITApplicationHandler.applicationQuery != null) {//check for cached query
			return IITApplicationHandler.applicationQuery;//return cached query if it exists
		}

		String tempQuery = 'SELECT'; //Initialize query with select statement

		Map<String, Schema.SObjectField> applicationFields = Schema.getGlobalDescribe().get('TargetX_SRMb__Application__c').getDescribe().fields.getMap(); //get every field for application
		for (Schema.SObjectField applicationField : applicationFields.values() ) { //Iterate through all field tokens
			Schema.DescribeFieldResult applicationFieldDescription = applicationField.getDescribe(); // Describe each field
			tempQuery += ' ' + applicationFieldDescription.getName() + ','; //Add the field to the SOQL query
		}

		tempQuery = tempQuery.subString(0,tempQuery.Length() - 1); //Trim off that last comma
		tempQuery += ' FROM TargetX_SRMb__Application__c WHERE '; //add on the from and where statements
		IITApplicationHandler.applicationQuery = tempQuery;
		return tempQuery; //return the query minus the variable in memory to check
	}
//Application action section
	public static void forceFlows(TargetX_SRMb__Application__c applicationToForce) {//Forces the application flows on a single application, or throws a big fat error
		if(applicationToForce.IIT_Dont_Run_Processes__c == FALSE) {//Check that we started at false
			List<TargetX_SRMb__Application__c> applicationsToProcess = new List<TargetX_SRMb__Application__c>{applicationToForce};//Initialize the list for updating
			applicationToForce.IIT_Dont_Run_Processes__C = TRUE; //Toggle on to force should run processes to change
			Database.Update(applicationsToProcess, false);
			applicationToForce.IIT_Dont_Run_Processes__C = FALSE; //Toggle off to force should run processes to change back and run flows
			Database.Update(applicationsToProcess, false);
		}
	}

	public static void deferApplications(List<id> applicationIds) {//Defers or change of terms an application
		Map<id,TargetX_SRMb__Application__c> currentApplications = new Map<id,TargetX_SRMb__Application__c>( (List<TargetX_SRMb__Application__c>)Database.Query(IITApplicationHandler.getApplicationQuery() + 'Id IN :applicationIds FOR UPDATE')); //dynamically pull the applications with all writeable fields
		Map<id,TargetX_SRMb__Application__c> clonedApplications = new Map<id,TargetX_SRMb__Application__c>(); //Cloned application map

		for(Integer i = 0; i < applicationIds.size(); i++) { //iterate through each application
			if( String.isBlank(currentApplications.get(applicationIds[i]).IIT_New_Start_Term__c) ) {//Make certain new term is popuated
				throw new IITGenericException('Unpopulated New Start Term. Cannot Defer.');
			} else if(currentApplications.get(applicationIds[i]).IIT_New_Start_Year__c == null) {//make certain new year is populated
				throw new IITGenericException('Unpopulated New Start Year. Cannot Defer.');
			} else if(currentApplications.get(applicationIds[i]).IIT_New_Start_Year__c < 2016) {//Make certain start year is valid. //TODO Parameterize this in a custom setting
				throw new IITGenericException('New Start Year before 2016. Cannot Defer.');
			} else if(
				String.valueOf(currentApplications.get(applicationIds[i]).IIT_New_Start_Year__c) == currentApplications.get(applicationIds[i]).TargetX_SRMb__Start_Term_Year__c
				&& currentApplications.get(applicationIds[i]).IIT_New_Start_Term__c == currentApplications.get(applicationIds[i]).TargetX_SRMb__Start_Term__c
			) {//Make certain that the defer is not to the same term.
				throw new IITGenericException('Attempted to defer to the same term and year. Cannot Defer.');
			} else if(currentApplications.get(applicationIds[i]).TargetX_SRMb__Stage__c != 'Submitted') {//Make certain the application is submitted
				throw new IITGenericException('Application not submitted. Cannot Defer.');
			} else if(
				String.isBlank(currentApplications.get(applicationIds[i]).TargetX_SRMb__Application_Decision__c) == false
				&& (
					currentApplications.get(applicationIds[i]).TargetX_SRMb__Application_Decision__c.indexOf('Deny') != -1
					|| currentApplications.get(applicationIds[i]).TargetX_SRMb__Application_Decision__c.indexOf('Denied') != -1
				)
			) {//Make certain the application is not denied
				throw new IITGenericException('Decision is denied. Cannot Defer.');
			} else if(//Make certain the application is not already deferred or withdrawn
				currentApplications.get(applicationIds[i]).TargetX_SRMb__Status__c == 'Deferred'
				|| currentApplications.get(applicationIds[i]).TargetX_SRMb__Status__c == 'Withdrawn'
				) {
				throw new IITGenericException('Status is ' + currentApplications.get(applicationIds[i]).TargetX_SRMb__Status__c + '. Cannot Defer.');
			} else {
				clonedApplications.put(applicationIds[i],
					IITApplicationHandler.cloneApplication(
						currentApplications.get(applicationIds[i])
						, null
					)
				); //clone the application
			}

			if(currentApplications.get(applicationIds[i]).TargetX_SRMb__Application_Decision__c == 'Admit'
			|| currentApplications.get(applicationIds[i]).TargetX_SRMb__Application_Decision__c == 'Admit to Alternate'
			|| currentApplications.get(applicationIds[i]).TargetX_SRMb__Application_Decision__c == 'Admit Conditional'
			) {//Handle defer status if the application was admitted
				currentApplications.get(applicationIds[i]).TargetX_SRMb__Status__c = 'Deferred';
				currentApplications.get(applicationIds[i]).IIT_Application_Processing_Status__c = 'Decision Approved';

				if(IITApplicationHandler.isStandardUGApp(currentApplications.get(applicationIds[i])) == false) {//perform semester adjustment for non UG apps. Consider making this its own function.
					Integer oldBannerTerm = Integer.valueOf(currentApplications.get(applicationIds[i]).IIT_Banner_Term__c);
					Integer	termDifferenceCalculation = Integer.valueOf(currentApplications.get(applicationIds[i]).TargetX_SRMb__Start_Term_Year__c) * 100;

					if(currentApplications.get(applicationIds[i]).TargetX_SRMb__Start_Term__c == 'Spring') {//handle spring banner term conversion
						termDifferenceCalculation += 20;
					} else if(currentApplications.get(applicationIds[i]).TargetX_SRMb__Start_Term__c == 'Summer') {//handle summer banner term conversion
						termDifferenceCalculation += 30;
					} else if(currentApplications.get(applicationIds[i]).TargetX_SRMb__Start_Term__c == 'Fall') {//handle fall banner term conversion
						termDifferenceCalculation += 110;
					}

					termDifferenceCalculation -= oldBannerTerm;

					if(termDifferenceCalculation > 20) {
						currentApplications.get(applicationIds[i]).IIT_Number_of_Semesters_Deferred__c += 2;
					} else if(termDifferenceCalculation > 10) {
						currentApplications.get(applicationIds[i]).IIT_Number_of_Semesters_Deferred__c += 1;
					}

					if(currentApplications.get(applicationIds[i]).IIT_Number_of_Semesters_Deferred__c > 2) {
						currentApplications.get(applicationIds[i]).IIT_Number_of_Semesters_Deferred__c = 2;
					}
				}

			} else {//Handle admit status if the application was deferred.
				currentApplications.get(applicationIds[i]).TargetX_SRMb__Status__c = 'Withdrawn';
				currentApplications.get(applicationIds[i]).IIT_Application_Processing_Status__c = 'Decision Approved';
			}
		}

		IITTriggerHandler.bypass('IITContactTriggerHandler');//turn off contact triggers
		IITApplicationHandler.performInsert(clonedApplications.values());//Safely insert applications

		Map<Id,Id> attachmentIdMap = new Map<Id,Id>();//Initialize Id map for attacments

		for(Id applicationId :clonedApplications.keySet()) {//Iterate through each application id and add it to the map for cloning.
			attachmentIdMap.put(applicationId,clonedApplications.get(applicationId).Id); //Add the application to the id map so its attachments are cloned.
		}

		IITApplicationReviewHandler.reparentIncompleteReviews(clonedApplications.values());
		IITEssayHandler.copyEssaysForApplication(clonedApplications.values(),attachmentIdMap);//Clone essays
		IITRecommendationHandler.copyRecommendationsForApplication(clonedApplications.values(),attachmentIdMap);//Clone essays
		IITEnrollmentHistoryHandler.reparentEnrollmentHistoryApplication(clonedApplications.values());//Clone enrollment histories
		IITFinancialAidHandler.copyFinancialAidForApplication(clonedApplications.values(),attachmentIdMap);//clone financial aid

		try {
			IITAttachmentHandler.cloneAttachments(attachmentIdMap);//Clone attachments

			IITApplicationHandler.performUpdate(currentApplications.values());//Safely update the current applications
			IITTriggerHandler.clearBypass('IITContactTriggerHandler');//turn on contact triggers
		} catch(IITNonFatalException nonFatalException) {
			IITApplicationHandler.performUpdate(currentApplications.values());//Safely update the current applications
			IITTriggerHandler.clearBypass('IITContactTriggerHandler');//turn on contact triggers
			throw nonFatalException;
		}
	}
//Update and Insert
	public static void performInsert(List<TargetX_SRMb__Application__c> applicationsToInsert) {//safely inserts applications
		try {
			insert applicationsToInsert;
		} catch(DmlException dmlExceptionCaught) {
			IITExceptionHandler.sendDMLExceptionEmail(dmlExceptionCaught);
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}

	public static void performUpdate(List<TargetX_SRMb__Application__c> applicationsToUpdate) {//safely inserts applications
		try {
			update applicationsToUpdate;
		} catch(DmlException dmlExceptionCaught) {
			IITExceptionHandler.sendDMLExceptionEmail(dmlExceptionCaught);
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}
}