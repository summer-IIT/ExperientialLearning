public without sharing class IITRecruitmentPathHandler { //Handles IIT Recruitment Path custom object manipulation
//Static Properties
	private static Map<String,IIT_Recruitment_Path__c> recruitmentPathsToInsert; //Recruitment paths to insert
	private static Map<id,IIT_Recruitment_Path__c> recruitmentPathsToUpdate; //Recruitment paths to update
	private static Map<String,IIT_Recruitment_Path__c> stagedRecruitmentPaths; //Recruitment path to special key map
	private static Set<Id> stagedContactIds; //Contact Ids to pull down recruitment paths from database
	private static Map<String,String> statusDateMap; //Map of status and dates
	private static Decimal defaultYear; //default year value if not specified
	private static String defaultTerm; //default term value if not specified
	private static String defaultStage; //default stage value if not specified
	private static Date defaultStageDate; //default stage date if not specified

static {//Static constructor.
	//TODO: make these check custom settings
	recruitmentPathsToInsert = new Map<String,IIT_Recruitment_Path__c>();
	recruitmentPathsToUpdate = new Map<id,IIT_Recruitment_Path__c>();
	stagedRecruitmentPaths = new Map<String,IIT_Recruitment_Path__c>();
	stagedContactIds = new Set<Id>();
	defaultYear = 2016;
	defaultTerm = 'Fall';
	defaultStage = 'Inquiry';
	defaultStageDate = system.today();
	IITRecruitmentPathHandler.initializeStatusDateMap();
}

//Initialization section
	private static void initializeStatusDateMap() {//Initializes the status date map that crosswalks status to their date fields
		//TODO: Push these into custom settings
		statusDateMap = new Map<String,String>();
		statusDateMap.put('Suspect','IIT_Suspect_Date__c');
		statusDateMap.put('Inquiry','IIT_Inquiry_Date__c');
		statusDateMap.put('Registrant','IIT_Registrant_Date__c');
		statusDateMap.put('Applicant','IIT_Applicant_Date__c');
		statusDateMap.put('Application Submitter','IIT_Application_Submitter_Date__c');
		statusDateMap.put('Admit','IIT_Admit_Date__c');
		statusDateMap.put('Intent to Enroll','IIT_Intent_to_Enroll_Date__c');
		statusDateMap.put('Deposited','IIT_Deposited_Date__c');
		statusDateMap.put('Deny','IIT_Deny_Date__c');
		statusDateMap.put('Deferred','IIT_Deferred_Date__c');
		statusDateMap.put('Withdrawn','IIT_Withdrawn_Date__c');
		statusDateMap.put('Enrolled','IIT_Enrolled_Date__c');
	}


//Contact section
//Contact preprocessing
	public static void sanitizeContactRecruitmentData(Contact contact) { //Sanitizes all the recruitment data on a contact record.
		//validate the term
		if( String.isBlank(contact.TargetX_SRMb__Anticipated_Start_Term__c) ) {//Check that the term is null or empty
			contact.TargetX_SRMb__Anticipated_Start_Term__c = IITRecruitmentPathHandler.defaultTerm; //Default the term to fall if not populated
		}
		
		//validate the year
		if(contact.TargetX_SRMb__Anticipated_Start_Year__c == null
		|| contact.TargetX_SRMb__Anticipated_Start_Year__c == 0
		) { //Check that the year is null or 0
			contact.TargetX_SRMb__Anticipated_Start_Year__c = IITRecruitmentPathHandler.defaultYear; //Default the year to 2016
		}
		
		//Validate the level
		if(String.isBlank(contact.TargetX_SRMb__Degree__c) == false) { //Check that the degree is not blank
			if(contact.TargetX_SRMb__Level__c != 'Undergraduate'
			&&	(contact.TargetX_SRMb__Degree__c.contains('Undergraduate')
				|| contact.TargetX_SRMb__Degree__c.contains('Bachelor')
				)
			) {//Check that the degree contains Undergraduate or Bachelor and that the level is not Undergraduate
				contact.TargetX_SRMb__Level__c = 'Undergraduate'; //Set level to Undergraduate				
			} else if(contact.TargetX_SRMb__Level__c != 'Graduate'
			&&	(contact.TargetX_SRMb__Degree__c.startsWith('Master')
				|| contact.TargetX_SRMb__Degree__c == 'Certificate'
				|| contact.TargetX_SRMb__Degree__c == 'Doctor of Philosophy'
				|| contact.TargetX_SRMb__Degree__c == 'Non Degree Graduate'
				)
			){//Check that the degree starts with Master, or equals Certificate, Doctor of Philosophy, or Non Degree Graduate and that the level is not Graduate
				contact.TargetX_SRMb__Level__c = 'Graduate'; //Set level to Graduate
			}
		}
		
		if(String.isBlank(contact.TargetX_SRMb__Status__c)) {//Check that the stage is null or empty
			contact.TargetX_SRMb__Status__c = IITRecruitmentPathHandler.defaultStage; //Default the stage to Inquiry
		}

		if(contact.TargetX_SRMb__Stage_Date__c == null) {//Check that the stage date is null
			contact.TargetX_SRMb__Stage_Date__c = IITRecruitmentPathHandler.defaultStageDate; //set stage date to today if stage date is null
		}
	}
//Contact postprocessing
	public static void stageRecruitmentPathForNewContact(Contact contactToProcess) {//Stage recruitment path for processing for a new contact
		IITRecruitmentPathHandler.stageRecruitmentPath(IITRecruitmentPathHandler.generateRecruitmentPathFromContact(contactToProcess)); //Generate a new recruitment path
	}

	public static void stageRecruitmentPathForContact(Contact contactToProcess, Contact oldContact) {//stage recruitment path for processing for an old contact
		IITRecruitmentPathHandler.stageRecruitmentPath(IITRecruitmentPathHandler.generateRecruitmentPathFromContacts(contactToProcess, oldContact)); //Generate a new recruitment path if recruitment path related data has changed and add it to the map for processing
	}

	public static IIT_Recruitment_Path__c generateRecruitmentPathFromContacts(Contact contactToProcess, Contact oldContact) {//Generate a new recruitment path if the recruitment path related data has changed
		if(oldContact == null
		|| (contactToProcess.TargetX_SRMb__Level__c != oldContact.TargetX_SRMb__Level__c
			|| contactToProcess.TargetX_SRMb__Student_Type__c != oldContact.TargetX_SRMb__Student_Type__c
			|| contactToProcess.TargetX_SRMb__Degree__c != oldContact.TargetX_SRMb__Degree__c
			|| contactToProcess.TargetX_SRMb__Anticipated_Major__c != oldContact.TargetX_SRMb__Anticipated_Major__c
			|| contactToProcess.TargetX_SRMb__Anticipated_Start_Term__c != oldContact.TargetX_SRMb__Anticipated_Start_Term__c
			|| contactToProcess.TargetX_SRMb__Anticipated_Start_Year__c != oldContact.TargetX_SRMb__Anticipated_Start_Year__c
			|| contactToProcess.TargetX_SRMb__Status__c != oldContact.TargetX_SRMb__Status__c
			|| contactToProcess.TargetX_SRMb__Stage_Date__c != oldContact.TargetX_SRMb__Stage_Date__c
			)
		) {//Check for an empty old contact or changes to recruitment path data on the old contact
			return IITRecruitmentPathHandler.generateRecruitmentPathFromContact(contactToProcess);
		}

		return null;
	}

	public static IIT_Recruitment_Path__c generateRecruitmentPathFromContact(Contact contactToProcess) {//Generate a new recruitment path from the contact data
		if(Contact.Id == null) {//Check that the contact id exists
			return null; //Do nothing if the contact id doesn't exist. We don't have anything to tie a recruitment path to. This should not happen if called properly.
		}

		IIT_Recruitment_Path__c recruitmentPathToGenerate = new IIT_Recruitment_Path__c(IIT_Contact__c = contactToProcess.Id
			, IIT_Level__c = contactToProcess.TargetX_SRMb__Level__c
			, IIT_Student_Type__c = contactToProcess.TargetX_SRMb__Student_Type__c
			, IIT_Degree__c = contactToProcess.TargetX_SRMb__Degree__c
			, IIT_Major__c = contactToProcess.TargetX_SRMb__Anticipated_Major__c
			, IIT_Term__c = (String.isBlank(contactToProcess.TargetX_SRMb__Anticipated_Start_Term__c) ? IITRecruitmentPathHandler.defaultTerm : contactToProcess.TargetX_SRMb__Anticipated_Start_Term__c) /*default the term if it is not set*/
			, IIT_Year__c = (contactToProcess.TargetX_SRMb__Anticipated_Start_Year__c == null ? IITRecruitmentPathHandler.defaultYear : contactToProcess.TargetX_SRMb__Anticipated_Start_Year__c) /* default the year if it is not set */
			); //Map over recruitment path data from the application

		//Handle dates using dynamic apex
		recruitmentPathToGenerate.put(/*assign the field using dynamic apex*/
			IITRecruitmentPathHandler.statusDateMap.get(/*get the field from the map*/
				(String.isBlank(contactToProcess.TargetX_SRMb__Status__c) ? IITRecruitmentPathHandler.defaultStage : contactToProcess.TargetX_SRMb__Status__c) /*sanitize the status and pull the field name from the stage date map*/
			)
			, (contactToProcess.TargetX_SRMb__Stage_Date__c == null ? IITRecruitmentPathHandler.defaultStageDate : contactToProcess.TargetX_SRMb__Stage_Date__c) /*sanitize the date to add*/
		);

		IITRecruitmentPathHandler.sanitizeRecruitmentPath(recruitmentPathToGenerate);//Sanitize the recruitment path
		return recruitmentPathToGenerate;
	}

//Application section
	public static void stageRecruitmentPathForNewApplication(TargetX_SRMb__Application__c applicationToProcess) {//Stage recruitment path for processing for a new application
		IITRecruitmentPathHandler.stageRecruitmentPath(IITRecruitmentPathHandler.generateRecruitmentPathFromApplication(applicationToProcess)); //Generate a new recruitment path if the application is new or if recruitment path related data has changed
	}

	public static void stageRecruitmentPathForApplication(TargetX_SRMb__Application__c applicationToProcess, TargetX_SRMb__Application__c oldApplication) {//stage recruitment path for processing for an old application
		if(String.isBlank(applicationToProcess.TargetX_SRMb__Degree__c) == false) {//Don't process applications that don't have degrees.
			IITRecruitmentPathHandler.stageRecruitmentPath(IITRecruitmentPathHandler.generateRecruitmentPathFromApplications(applicationToProcess, oldApplication)); //Generate a new recruitment path if the application is new or if recruitment path related data has changed and add it to the map for processing
		}
	}

	public static IIT_Recruitment_Path__c generateRecruitmentPathFromApplications(TargetX_SRMb__Application__c applicationToProcess, TargetX_SRMb__Application__c oldApplication) {//Wrapper function for applications
		return IITRecruitmentPathHandler.generateRecruitmentPathFromApplication(applicationToProcess);
	}

	public static IIT_Recruitment_Path__c generateRecruitmentPathFromApplication(TargetX_SRMb__Application__c applicationToProcess) {//Generate a new recruitment path from the application data
		if(applicationToProcess.TargetX_SRMb__Contact__c == null) {//Check that the contact exists for this application
			return null; //Do nothing if the contact doesn't exist. We don't have anything to tie a recruitment path to. This should never happen in the course of normal processing.
		}

		IIT_Recruitment_Path__c recruitmentPathToGenerate = new IIT_Recruitment_Path__c(IIT_Contact__c = applicationToProcess.TargetX_SRMb__Contact__c
			, IIT_Level__c = applicationToProcess.TargetX_SRMb__Level__c
			, IIT_Student_Type__c = applicationToProcess.TargetX_SRMb__Student_Type__c
			, IIT_Degree__c = applicationToProcess.TargetX_SRMb__Degree__c
			, IIT_Major__c = applicationToProcess.TargetX_SRMb__Possible_Academic_Major__c
			, IIT_Term__c = (String.isBlank(applicationToProcess.TargetX_SRMb__Start_Term__c) ? IITRecruitmentPathHandler.defaultTerm : applicationToProcess.TargetX_SRMb__Start_Term__c)
			, IIT_Year__c = (applicationToProcess.TargetX_SRMb__Start_Term_Year__c == null || applicationToProcess.TargetX_SRMb__Start_Term_Year__c.isNumeric() == false ? IITRecruitmentPathHandler.defaultYear : decimal.valueof(applicationToProcess.TargetX_SRMb__Start_Term_Year__c))
			, IIT_Applicant_Date__c = applicationToProcess.IIT_Application_Start_Date__c
			, IIT_Application_Submitter_Date__c = applicationToProcess.TargetX_SRMb__Application_Submit_Date__c
			, IIT_Intent_to_Enroll_Date__c = applicationToProcess.IIT_Deposit_Intent_to_Enroll_Date__c
			, IIT_Deposited_Date__c = applicationToProcess.IIT_Accept_Enrollment_Deposit_Date__c
			, IIT_Deferred_Date__c = applicationToProcess.IIT_Deferred_Date__c
			, IIT_Withdrawn_Date__c = applicationToProcess.IIT_Withdrawn_Date__c
			); //Map over recruitment path data from the application

		//Handle dates using dynamic apex
		if(applicationToProcess.TargetX_SRMb__Application_Decision__c != null) {
			if(applicationToProcess.TargetX_SRMb__Application_Decision__c == 'Denied to Applied'
			|| applicationToProcess.TargetX_SRMb__Application_Decision__c.indexOf('Deny') != -1
			) {//Check for a deny decision
				recruitmentPathToGenerate.IIT_Deny_Date__c = applicationToProcess.IIT_Application_Decision_Date__c;
			} else if(applicationToProcess.TargetX_SRMb__Application_Decision__c == 'Admit'
			|| applicationToProcess.TargetX_SRMb__Application_Decision__c == 'Admit Conditional'
			|| applicationToProcess.TargetX_SRMb__Application_Decision__c == 'Admit to Alternate'
			)
			 {//check for an admit decision
				recruitmentPathToGenerate.IIT_Admit_Date__c = applicationToProcess.IIT_Application_Decision_Date__c;
			}
		}

		IITRecruitmentPathHandler.sanitizeRecruitmentPath(recruitmentPathToGenerate);//Sanitize the recruitment path
		return recruitmentPathToGenerate;
	}

//General post processing
	public static void processStagedRecruitmentPaths() {//processes all prior staged recruitment paths and clears the respective static maps
		try {
			Map<String,IIT_Recruitment_Path__c> oldRecruitmentPathsMap = IITRecruitmentPathHandler.generatePossibleRecruitmentPathMatchMap(); //Get all existing recruitment paths by Contact

			for(String recruitmentPathKey : IITRecruitmentPathHandler.stagedRecruitmentPaths.keySet()) {//Iterate through every recruitment path staged for processing. Note that because of the maps, it is impossible to have duplicates!
				IIT_Recruitment_Path__c recruitmentPathToProcess = IITRecruitmentPathHandler.stagedRecruitmentPaths.get(recruitmentPathKey); //This won't be null as we have keys with appropriate values
				IIT_Recruitment_Path__c oldRecruitmentPath = oldRecruitmentPathsMap.get(recruitmentPathKey); //check if we have a old value that we want to reconcile against

				if(oldRecruitmentPath != null) {//We found an old recruitment path
					IITRecruitmentPathHandler.processMatchedRecruitmentPath(recruitmentPathToProcess , oldRecruitmentPath, false);//Process a match between two recruitment paths, specify that we're not in staging
				} else {
					IITRecruitmentPathHandler.recruitmentPathsToInsert.put(recruitmentPathKey,recruitmentPathToProcess);//Add the recruitment path to the list of those to insert
				}
			}

			if(IITRecruitmentPathHandler.recruitmentPathsToInsert.isEmpty() == false) {//Check that we have any records to insert
				try {
					insert IITRecruitmentPathHandler.recruitmentPathsToInsert.values(); //insert the recruitment Paths to insert
				} catch(Exception exceptionCaught) {//Catch any errors
					IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
				}
				IITRecruitmentPathHandler.recruitmentPathsToInsert.clear(); //clear already inserted records from the list
			}

			if(IITRecruitmentPathHandler.recruitmentPathsToUpdate.isEmpty() == false) {//Check that we have any records to update
				try {
					update IITRecruitmentPathHandler.recruitmentPathsToUpdate.values(); //Update all recruitment paths to update
				} catch(Exception exceptionCaught) {//Catch any errors
					IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
				}
				IITRecruitmentPathHandler.recruitmentPathsToUpdate.clear(); //clear already updated records from the map
			}

			IITRecruitmentPathHandler.stagedRecruitmentPaths.clear(); //clear all staged recruitment paths
			IITRecruitmentPathHandler.stagedContactIds.clear(); //clear all staged contact ids
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}

//General
	public static void stageRecruitmentPath(IIT_Recruitment_Path__c recruitmentPathToAdd) {//Adds a recruitment path to the static recruitmentPathListToObject map for processing
		if(recruitmentPathToAdd != null) {//Check that we received a recruitment path from the application
			String recruitmentPathKey = IITRecruitmentPathHandler.getRecruitmentPathMapKey(recruitmentPathToAdd); //Get the unique string key for this recruitment path
			IIT_Recruitment_Path__c stagedRecruitmentPath = IITRecruitmentPathHandler.stagedRecruitmentPaths.get(recruitmentPathKey); //Get the existing value for the key, if it exists

			if(stagedRecruitmentPath != null) {
				IITRecruitmentPathHandler.processMatchedRecruitmentPath(recruitmentPathToAdd,stagedRecruitmentPath,true);//handle a recruitment path match, specify that we're at the staging phase
			} else {
				stagedContactIds.add(recruitmentPathToAdd.IIT_Contact__c); //add the contact id to the staged recruitment paths
				IITRecruitmentPathHandler.stagedRecruitmentPaths.put(recruitmentPathKey,recruitmentPathToAdd); //Add the recruitment path to the list of recruitment paths to process, contained in the static map for batch processing
			}
		}
	}

    public static Map<String,IIT_Recruitment_Path__c> generatePossibleRecruitmentPathMatchMap() {//Generates a map of contact ids to associated recruitment path list
        Map<String,IIT_Recruitment_Path__c> mapToReturn = new Map<String,IIT_Recruitment_Path__c>(); //Make new map
        List<IIT_Recruitment_Path__c> recruitmentPathMap = [SELECT id
			, IIT_Contact__c
			, IIT_Level__c
			, IIT_Student_Type__c
			, IIT_Degree__c
			, IIT_Major__c
			, IIT_Term__c
			, IIT_Year__c
			, IIT_Suspect_Date__c
			, IIT_Inquiry_Date__c
			, IIT_Registrant_Date__c
			, IIT_Applicant_Date__c
			, IIT_Application_Submitter_Date__c
			, IIT_Admit_Date__c
			, IIT_Intent_to_Enroll_Date__c
			, IIT_Deposited_Date__c
			, IIT_Deny_Date__c
			, IIT_Deferred_Date__c
			, IIT_Withdrawn_Date__c
			, IIT_Enrolled_Date__c
			FROM IIT_Recruitment_Path__c
			WHERE IIT_Contact__c IN :IITRecruitmentPathHandler.stagedContactIds
			FOR UPDATE]; //Get all related recruitment paths to current contacts
        
        for(IIT_Recruitment_Path__c recruitmentPathToMap: recruitmentPathMap) { //Iterate through all of the recruitment paths
        	mapToReturn.put(IITRecruitmentPathHandler.getRecruitmentPathMapKey(recruitmentPathToMap),recruitmentPathToMap); //put the recruitment path into the return map by key
        }
        
        return mapToReturn; //return the completed recruitment path map map.
    }

    public static String getRecruitmentPathMapKey(IIT_Recruitment_Path__c recruitmentPathForKey) {//generates a recruitment path map key
    	return recruitmentPathForKey.IIT_Contact__c
    	+ (String.isBlank(recruitmentPathForKey.IIT_Level__c) ? '~' : recruitmentPathForKey.IIT_Level__c + '~')
    	+ (String.isBlank(recruitmentPathForKey.IIT_Student_Type__c) ? '~' : recruitmentPathForKey.IIT_Student_Type__c + '~')
    	+ (String.isBlank(recruitmentPathForKey.IIT_Degree__c) ? '~' : recruitmentPathForKey.IIT_Degree__c + '~')
    	+ (String.isBlank(recruitmentPathForKey.IIT_Major__c) ? '~' : recruitmentPathForKey.IIT_Major__c + '~')
    	+ recruitmentPathForKey.IIT_Term__c + '~'
    	+ String.valueOf(recruitmentPathForKey.IIT_Year__c); //Note that term and year should never be null and we want to throw an exception if they are
    }

    public static void sanitizeRecruitmentPath(IIT_Recruitment_Path__c recruitmentPathToSanitize) {//Sanitizes any additional recruitment path data.
		//Validate the level
		if(String.isBlank(recruitmentPathToSanitize.IIT_Degree__c) == false) { //Check that the degree is not blank
			if(	recruitmentPathToSanitize.IIT_Level__c != 'Undergraduate'
			&& (recruitmentPathToSanitize.IIT_Degree__c.contains('Undergraduate')
				|| recruitmentPathToSanitize.IIT_Degree__c.contains('Bachelor')
				)
			) {//Check that the degree contains Undergraduate or Bachelor
				recruitmentPathToSanitize.IIT_Level__c= 'Undergraduate'; //Set level to Undergraduate				
			} else if(recruitmentPathToSanitize.IIT_Level__c != 'Graduate'
			&&	(recruitmentPathToSanitize.IIT_Degree__c.startsWith('Master')
				|| recruitmentPathToSanitize.IIT_Degree__c == 'Certificate'
				|| recruitmentPathToSanitize.IIT_Degree__c == 'Doctor of Philosophy'
				|| recruitmentPathToSanitize.IIT_Degree__c == 'Non Degree Graduate'
				)
			) {//Check that the degree starts with Master, or equals Certificate, Doctor of Philosophy, or Non Degree Graduate
				recruitmentPathToSanitize.IIT_Level__c = 'Graduate'; //Set level to Graduate
			}
		}
    }

    public static void processMatchedRecruitmentPath(IIT_Recruitment_Path__c newRecruitmentPath, IIT_Recruitment_Path__c oldRecruitmentPath, boolean isInStaging) {//processes a match of old and new recruitment paths
    	//since the old recruitment path exists, its data is assumed the default. Thus we only need to check for priority of new recruitment path data

    	for(String dateField : IITRecruitmentPathHandler.statusDateMap.values() ) {/*iterate through each value in the status date map*/
    		if(newRecruitmentPath.get(dateField)  != null
    		&&	(oldRecruitmentPath.get(dateField) == null
    			|| (Date)oldRecruitmentPath.get(dateField) > (Date)newRecruitmentPath.get(dateField)
    			)
    		) {//Check that the date field exists on the new path and does not exist on the old path or is before the date on the old path
    			oldRecruitmentPath.put(dateField,(Date)newRecruitmentPath.get(dateField));//Migrate the field over to the old recruitment path
    		}
    	} //Don't worry about discarding the other key value data as those are used to determine the match and are on the old recruitment path

    	if(isInStaging == false
    	&& oldRecruitmentPath.Id != null
    	) {//Check that this wasn't performed from a staging context and it's an update we need to check.
    		IITRecruitmentPathHandler.recruitmentPathsToUpdate.put(oldRecruitmentPath.Id,oldRecruitmentPath);//Add the old recruitment path to the list of those to update
    	}
    }
}