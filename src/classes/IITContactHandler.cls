public without sharing class IITContactHandler { //Handles Contact manipulation

/* @author Illinois Institute of Technology 
* @date 2015
* @description Object handler on Contact object to support handling multiplicity relationships
*/

	public static void processContactTrigger(List<Contact> contactsToProcess, Map<id, Contact> oldContactsMap, IITTriggerContext triggerContext) { //Processes a list of contacts to enqueue
		try {
			if(triggerContext == IITTriggerContext.AFTER_INSERT
			|| triggerContext == IITTriggerContext.AFTER_UPDATE
			) {//Check for insert or update
				if(System.isBatch()
				|| System.isFuture()
				) { //Check that the job is not in batch or future. No need to get the expanded context if it is.
					processContactList(contactsToProcess,oldContactsMap,triggerContext); //run normally
				} else { //The job is not using the expanded future/queue/batch limits. Queue it to get that expansion
					ID jobID = System.enqueueJob( new IITContactJobProcessList(contactsToProcess,oldContactsMap, triggerContext) ); //Queue the job for processing
				}
			}
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}//end method

	public static void processContactList(List<Contact> contactsToProcess, Map<id, Contact> oldContactsMap, IITTriggerContext triggerContext) { //Processes a list of contacts
		try {
			if (triggerContext == IITTriggerContext.AFTER_INSERT) {
				//Suboptimized list processing here
				IITEmailHandler.stageEmailForProcessing(contactsToProcess, null); //Call Email object functionality
				IITPhoneHandler.stagePhoneForProcessing(contactsToProcess, null); //Call Phone multiplicity functionality
				IITAddressHandler.processAddresses(contactsToProcess, null); //Call Address functionality

				//Setup bulkified processing

				//Bulkified processing
				for(Contact contactToProcess : contactsToProcess) {//Iterate through each contact and process individually 
					IITRecruitmentPathHandler.stageRecruitmentPathForNewContact(contactToProcess); //Stage recruitment path data for processing
				}

				//Finalize bulkified processing
				IITRecruitmentPathHandler.processStagedRecruitmentPaths(); //process all recruitment paths stages per application.
			} else if(triggerContext == IITTriggerContext.AFTER_UPDATE) {
				//Suboptimized list processing here
				IITEmailHandler.stageEmailForProcessing(contactsToProcess, oldContactsMap); //Call Email object functionality
				IITPhoneHandler.stagePhoneForProcessing(contactsToProcess, oldContactsMap); //Call Phone multiplicity functionality
				IITAddressHandler.processAddresses(contactsToProcess, oldContactsMap); //Call Address functionality

				//Setup bulkified processing

				//Bulkified processing
				for(Contact contactToProcess : contactsToProcess) {//Iterate through each contact and process individually 
					IITRecruitmentPathHandler.stageRecruitmentPathForContact(contactToProcess, oldContactsMap.get(contactToProcess.Id)); //Stage recruitment path data for processing
				}

				//Finalize bulkified processing
				IITRecruitmentPathHandler.processStagedRecruitmentPaths(); //process all recruitment paths stages per application.
			} else if(triggerContext == IITTriggerContext.BEFORE_INSERT) {
				//Suboptimized list processing here
				addressPlusContactZipLookup.zipLookup(contactsToProcess, new Map<Id, Contact>()); //Call	 TargetX Address Plus lookup
				IITProgramHandler.processProgramsForContacts(contactsToProcess); //Validate program data

				//Setup bulkified processing

				//Bulkified processing
				for(Contact contactToProcess : contactsToProcess) {//Iterate through each contact and process individually
					IITContactHandler.sanitizeCountry(contactToProcess, null); //Sanitize contact country
					IITEmailHandler.sanitizeContactEmails(contactToProcess); //Sanitize emails
					IITPhoneHandler.sanitizeContactPhoneNumbers(contactToProcess); //Sanitize phone number
					IITAddressHandler.sanitizeContactAddresses(contactToProcess, null); //Sanitize the address
					IITRecruitmentPathHandler.sanitizeContactRecruitmentData(contactToProcess); //Validate recruitment data
				}

				//Finalize bulkified processing
			} else if(triggerContext == IITTriggerContext.BEFORE_UPDATE) {
				//Suboptimized list processing here
				addressPlusContactZipLookup.zipLookup(contactsToProcess, oldContactsMap); //Call TargetX Address Plus
				IITProgramHandler.processProgramsForContacts(contactsToProcess); //Validate program data //Validate program data

				//Setup bulkified processing

				//Bulkified processing
				for(Contact contactToProcess : contactsToProcess) {//Iterate through each contact and process individually
					Contact oldContact = (oldContactsMap != null && contactToProcess.id != null ? oldContactsMap.get(contactToProcess.id) : null); //assign the old contact
					IITContactHandler.sanitizeCountry(contactToProcess, oldContact); //sanitize country data
					IITEmailHandler.sanitizeContactEmails(contactToProcess); //Sanitize emails
					IITPhoneHandler.sanitizeContactPhoneNumbers(contactToProcess); //Sanitize phone number
					IITAddressHandler.sanitizeContactAddresses(contactToProcess, oldContact); //Sanitize the address
					IITRecruitmentPathHandler.sanitizeContactRecruitmentData(contactToProcess); //Validate recruitment data
				}

				//Finalize bulkified processing
			}
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}//end method
//Country sanitization functionality
	public static void sanitizeCountry(Contact contactToSanitize, Contact oldContact) {//sanitizes all non-address country fields on the contact record.
		if( String.isBlank(contactToSanitize.TargetX_SRMb__Birth_Country__c) == false
		&&	(oldContact == null
			|| oldContact.TargetX_SRMb__Birth_Country__c != contactToSanitize.TargetX_SRMb__Birth_Country__c
			)
		) {//sanitize birth country if a change has occurred
			contactToSanitize.TargetX_SRMb__Birth_Country__c = IITAddressHandler.sanitizeCountry(contactToSanitize.TargetX_SRMb__Birth_Country__c); 
		}//end if

		if( String.isBlank(contactToSanitize.TargetX_SRMb__Country_of_Permanent_Residence__c) == false
		&&	(oldContact == null
			|| oldContact.TargetX_SRMb__Country_of_Permanent_Residence__c != contactToSanitize.TargetX_SRMb__Country_of_Permanent_Residence__c
			)
		) {//sanitize country of permanent residence if a change has occurred
			contactToSanitize.TargetX_SRMb__Country_of_Permanent_Residence__c = IITAddressHandler.sanitizeCountry(contactToSanitize.TargetX_SRMb__Country_of_Permanent_Residence__c);
		}//end if

		if(String.isBlank(contactToSanitize.IIT_Primary_Country_of_Citizenship__c) == false
		&&	(oldContact == null
			|| oldContact.IIT_Primary_Country_of_Citizenship__c != contactToSanitize.IIT_Primary_Country_of_Citizenship__c
			)
		) {//Sanitize country of citizenship if a change has occurred
			contactToSanitize.IIT_Primary_Country_of_Citizenship__c = IITAddressHandler.sanitizeCountry(contactToSanitize.IIT_Primary_Country_of_Citizenship__c);
		}//end if

		if(String.isBlank(contactToSanitize.TargetX_SRMb__Primary_Other_Citizenship__c) == false
		&&	(oldContact == null
			|| oldContact.TargetX_SRMb__Primary_Other_Citizenship__c != contactToSanitize.TargetX_SRMb__Primary_Other_Citizenship__c
			)
		) {//Sanitize primary other country of citizenship if a change has occurred
			contactToSanitize.TargetX_SRMb__Primary_Other_Citizenship__c = IITAddressHandler.sanitizeCountry(contactToSanitize.TargetX_SRMb__Primary_Other_Citizenship__c);
		}//end if

		if(String.isBlank(contactToSanitize.TargetX_SRMb__Secondary_Other_Citizenship__c) == false
		&&	(oldContact == null
			|| oldContact.TargetX_SRMb__Secondary_Other_Citizenship__c != contactToSanitize.TargetX_SRMb__Secondary_Other_Citizenship__c
			)
		) {//Sanitize secondary other country of citizenship if a change has occurred
			contactToSanitize.TargetX_SRMb__Secondary_Other_Citizenship__c = IITAddressHandler.sanitizeCountry(contactToSanitize.TargetX_SRMb__Secondary_Other_Citizenship__c); 
		}//end if

		if(String.isBlank(contactToSanitize.TargetX_SRMb__Dual_Citizenship__c) == false
		&&	(oldContact == null
			|| oldContact.TargetX_SRMb__Dual_Citizenship__c != contactToSanitize.TargetX_SRMb__Dual_Citizenship__c
			)
		) {//Sanitize dual country of citizenship if a change has occurred
			contactToSanitize.TargetX_SRMb__Dual_Citizenship__c = IITAddressHandler.sanitizeCountry(contactToSanitize.TargetX_SRMb__Dual_Citizenship__c);
		}//end if
	}//end method

//Attachment functionality
	public static void toggleHasAttachments(Set<Id> contactsIdsToProcess, Boolean valueToToggle) {//Toggles Has Has Attachments to a specified boolean value
		List<Contact> contactsToToggle = [SELECT Id
		, IIT_Has_Attachments__c
		, (	SELECT Id
			FROM Attachments
		)
		FROM Contact
		WHERE Id IN :contactsIdsToProcess
		FOR UPDATE]; //Pull the contacts in the ID set and their attachments

		List<Contact> contactsToUpdate = new List<Contact>(); //Initialize a container for the contacts to actually update

		for(Contact contactToProcess : contactsToToggle) {//Iterate through each contact
			if(contactToProcess.IIT_Has_Attachments__c != valueToToggle
			&& (valueToToggle
				|| contactToProcess.Attachments.size() == 0
				)
			) {//Check that the value is not what we want it to be and that the value is true or the number of attachments on the contact is 0
				contactToProcess.IIT_Has_Attachments__c = valueToToggle; //set Has Attachments to the desired value
				contactsToUpdate.add(contactToProcess); //Add the contact to the list of those being updated
			}
		}

		if(contactsToUpdate.size() > 0) {//Check that we have any records to update.
			IITContactHandler.updateContacts(contactsToUpdate); //Call update function
		}
	}//end method
//English Proficiency functionality
	public static void assignEnglishProficiency(Map<id,String> contactProficiencyMap) {//Assigns english proficiencies to contacts and updates them.
		List<Contact> contactsToAssess = [SELECT Id
		, IIT_English_Proficiency__c
		, IIT_Primary_Country_of_Citizenship__c
		FROM Contact
		WHERE TargetX_SRMb__Level__c = 'Graduate'
		AND Id in :contactProficiencyMap.keySet()
		FOR UPDATE]; //pull down all contacts that may need assessment

		Map<id,Contact> contactsToUpdate = new Map<id,Contact>();//initialize contacts to update;

		for(Contact contactToAssess : contactsToAssess) {//iterate through each contact

			String proficiency = IITTestScoreHandler.compareProficiency(contactToAssess.IIT_English_Proficiency__c, contactProficiencyMap.get(contactToAssess.Id));//determine the proficiency
			if(proficiency != contactToAssess.IIT_English_Proficiency__c) {//determine if the proficiency changed
				contactToAssess.IIT_English_Proficiency__c = proficiency; //Assign the new proficiency
				contactsToUpdate.put(contactToAssess.id,contactToAssess);//add contact to update list
			}//end if
		}//end for

		if(contactsToUpdate.isEmpty() == false) {//check that there are contacts to update
			IITContactHandler.updateContacts(contactsToUpdate.values());//safely update contacts
		}//end if
	}//end method

//Application to Contact rollup section
	public static void rollupApplicationData(Map<id,TargetX_SRMb__Application__c> applicationstoContacts) {//rolls up contact data from the application
		Set<Id> contactIds = applicationstoContacts.keySet();

		List<Contact> contactsToRollup = [SELECT Id
		, TGTX_Master_Application__c
		, IIT_Primary_Application_Priority__c
		, IIT_Primary_Country_of_Citizenship__c
		, TargetX_SRMb__Citizenship__c
		, TargetX_SRMb__Anticipated_Start_Term__c
		, TargetX_SRMb__Anticipated_Start_Year__c
		, TargetX_SRMb__Level__c
		, TargetX_SRMb__Student_Type__c
		, TargetX_SRMb__Degree__c
		, TargetX_SRMb__Anticipated_Major__c
		, TargetX_SRMb__Concentration__c
		, TargetX_SRMb__Anticipated_Enrollment_Status__c
		, TargetX_SRMb__Status__c
		, TargetX_SRMb__Stage_Date__c
		FROM Contact
		WHERE Id in :contactIds
		FOR UPDATE]; //pull up contact data to assess

		Map<Id,Contact> contactsToUpdate = new Map<Id,Contact>();//initialize contacts to update;

		for(Contact contactToAssess : contactsToRollup) {//iterate through each contact
			TargetX_SRMb__Application__c application = applicationstoContacts.get(contactToAssess.id); //pull down the application for handling
			boolean shouldUpdateContact = false; //boolean value on whether or not we should update the contact.

			double contactPriority = (contactToAssess.IIT_Primary_Application_Priority__c == null ? 0 : Double.valueOf(contactToAssess.IIT_Primary_Application_Priority__c));//convert the contact's priority to a number

			if(application.IIT_Application_Priority__c < contactPriority
			&& contactToAssess.TGTX_Master_Application__c != application.Id
			) {//check that the application priority is greater
				continue;//skip to the next contact
			}//end if

			if(contactToAssess.TGTX_Master_Application__c != application.id) {//check that the master application isn't already set to this application
				contactToAssess.TGTX_Master_Application__c = application.id; //set the master application
				shouldUpdateContact = true;//set the contact to be updated
			}//end if

			if(contactPriority != application.IIT_Application_Priority__c) {//check that the application priority isn't the same
				contactToAssess.IIT_Primary_Application_Priority__c = String.valueOf(application.IIT_Application_Priority__c); //set the application priority
				shouldUpdateContact = true;//set the contact to be updated
			}//end if

			if(String.isBlank(application.Citizenship_Status__c) == false
			&& contactToAssess.TargetX_SRMb__Citizenship__c != application.Citizenship_Status__c
			) {//check that the citizenship status on the app isn't null and doesn't match the contact
				contactToAssess.TargetX_SRMb__Citizenship__c = application.Citizenship_Status__c; //set the contact's citizenship status to the application's
				shouldUpdateContact = true;//set the contact to be updated
			}//end if

			if(String.isBlank(application.Citizenship_Country__c) == false
			&& contactToAssess.IIT_Primary_Country_of_Citizenship__c != application.Citizenship_Country__c
			) {//check that the citizenship country on the app isn't null and doesn't match the contact
				contactToAssess.IIT_Primary_Country_of_Citizenship__c = IITAddressHandler.sanitizeCountry(application.Citizenship_Country__c); //set the contact's country of citizenship to the application's
				shouldUpdateContact = true;//set the contact to be updated
			}//end if

			if(IITApplicationHandler.isStandardUGApp(application) == false) {
				if(String.isBlank(application.TargetX_SRMb__Start_Term__c) == false
				&& contactToAssess.TargetX_SRMb__Anticipated_Start_Term__c != application.TargetX_SRMb__Start_Term__c
				) {//check that the start term on the app isn't null and doesn't match the contact
					contactToAssess.TargetX_SRMb__Anticipated_Start_Term__c = application.TargetX_SRMb__Start_Term__c;
					shouldUpdateContact = true;//set the contact to be updated
				}//end if

				if(String.isBlank(application.TargetX_SRMb__Start_Term_Year__c) != null
				&& contactToAssess.TargetX_SRMb__Anticipated_Start_Year__c != Integer.valueOf(application.TargetX_SRMb__Start_Term_Year__c)
				) {//check that the start year on the app isn't null and doesn't match the contact
					contactToAssess.TargetX_SRMb__Anticipated_Start_Year__c = Integer.valueOf(application.TargetX_SRMb__Start_Term_Year__c);
					shouldUpdateContact = true;//set the contact to be updated
				}//end if

				if(String.isBlank(application.TargetX_SRMb__Level__c) == false
				&& contactToAssess.TargetX_SRMb__Level__c != application.TargetX_SRMb__Level__c
				) {//check that the level on the app isn't null and doesn't match the contact
					contactToAssess.TargetX_SRMb__Level__c = application.TargetX_SRMb__Level__c;
					shouldUpdateContact = true;//set the contact to be updated
				}//end if

				if(String.isBlank(application.TargetX_SRMb__Degree__c) == false
				&& contactToAssess.TargetX_SRMb__Degree__c != application.TargetX_SRMb__Degree__c
				) {//check that the degree on the app isn't null and doesn't match the contact
					contactToAssess.TargetX_SRMb__Degree__c = application.TargetX_SRMb__Degree__c;
					shouldUpdateContact = true;//set the contact to be updated
				}//end if

				if(String.isBlank(application.TargetX_SRMb__Possible_Academic_Major__c) == false
				&& contactToAssess.TargetX_SRMb__Anticipated_Major__c != application.TargetX_SRMb__Possible_Academic_Major__c
				) {//check that the major on the app isn't null and doesn't match the contact
					contactToAssess.TargetX_SRMb__Anticipated_Major__c = application.TargetX_SRMb__Possible_Academic_Major__c;
					shouldUpdateContact = true;//set the contact to be updated
				}//end if

				if(String.isBlank(application.TargetX_SRMb__Possible_Academic_Major__c) == false
				&& contactToAssess.TargetX_SRMb__Anticipated_Major__c != application.TargetX_SRMb__Possible_Academic_Major__c
				) {//check that the major on the app isn't null and doesn't match the contact
					contactToAssess.TargetX_SRMb__Anticipated_Major__c = application.TargetX_SRMb__Possible_Academic_Major__c;
					shouldUpdateContact = true;//set the contact to be updated
				}//end if

				if(String.isBlank(application.TargetX_SRMb__Student_Type__c) == false
				&& contactToAssess.TargetX_SRMb__Student_Type__c != application.TargetX_SRMb__Student_Type__c
				) {//check that the student type on the app isn't null and doesn't match the contact
					contactToAssess.TargetX_SRMb__Student_Type__c = application.TargetX_SRMb__Student_Type__c;
					shouldUpdateContact = true;//set the contact to be updated
				}//end if

				if(contactToAssess.TargetX_SRMb__Concentration__c != application.TargetX_SRMb__Concentration__c) {//check that the concentration on the app doesn't match the contact
					contactToAssess.TargetX_SRMb__Concentration__c = application.TargetX_SRMb__Concentration__c;
					shouldUpdateContact = true;//set the contact to be updated
				}//end if

				if(String.isBlank(application.TargetX_SRMb__Anticipated_Enrollment_Status__c) == false
				&& contactToAssess.TargetX_SRMb__Anticipated_Enrollment_Status__c != application.TargetX_SRMb__Anticipated_Enrollment_Status__c
				) {//check that the full time part time on the app isn't null and doesn't match the contact
					contactToAssess.TargetX_SRMb__Anticipated_Enrollment_Status__c = application.TargetX_SRMb__Anticipated_Enrollment_Status__c;
					shouldUpdateContact = true;//set the contact to be updated
				}//end if

				String statusToUse = 'Applicant'; //Define stage to start
				Date dateToUse = application.IIT_Application_Start_Date__c; //Define stage date to use

				if(application.TargetX_SRMb__Stage__c == 'Submitted') {//Check that the application is submitted
					if(application.TargetX_SRMb__Status__c == 'Incomplete') {//Check that the app is incomplete
						statusToUse = 'Application Submitter';
						dateToUse = application.TargetX_SRMb__Application_Submit_Date__c;
					} else if(application.TargetX_SRMb__Status__c == 'Complete') {//Check that the app is complete
						statusToUse = 'Application Submitter';
						dateToUse = application.TargetX_SRMb__Application_Submit_Date__c;
						//IIT_Application_Complete_Date__c
					} else if(application.TargetX_SRMb__Status__c == 'Decision Made') {
						if(application.IIT_Application_Processing_Status__c == 'Decision Approved') {//Check for decision approved
							if(application.TargetX_SRMb__Application_Decision__c == 'Admit'
							|| application.TargetX_SRMb__Application_Decision__c == 'Admit Conditional'
							) {//check for admit statuses
								if(application.TargetX_SRMb__Deposit_Intent_to_Enroll__c == 'Yes'
								&& application.IIT_Deposit_Intent_to_Enroll_Date__c != null
								) {//check that intent to enroll is Yes and its date is not null
									statusToUse = 'Intent to Enroll';
									dateToUse = application.IIT_Deposit_Intent_to_Enroll_Date__c;
									//To do: Check for deposit IIT_Accept_Enrollment_Deposit_Date__c fr UG when they go live
								} else {
									statusToUse = 'Admit';
									dateToUse = application.IIT_Admit_Date__c;
								}//end intent to enroll if
							} else if(application.TargetX_SRMb__Application_Decision__c == 'Deny'
							|| application.TargetX_SRMb__Application_Decision__c == 'Denied to Applied'
							|| application.TargetX_SRMb__Application_Decision__c == 'JC Deny'
							|| application.TargetX_SRMb__Application_Decision__c == 'English Deny'
							) {//check for deny decisions
								statusToUse = 'Deny';
								dateToUse = application.IIT_Deny_Date__c;
							} else {
								statusToUse = 'Application Submitter';
								dateToUse = application.TargetX_SRMb__Application_Submit_Date__c;
							}//end decision if
						} else {
							statusToUse = 'Application Submitter';
							dateToUse = application.TargetX_SRMb__Application_Submit_Date__c;
						} //end decision approved if
					} else if(application.TargetX_SRMb__Status__c == 'Deferred') {//Check that the app is deferred
						statusToUse = 'Deferred';
						dateToUse = application.IIT_Deferred_Date__c;
					} else if(application.TargetX_SRMb__Status__c == 'Withdrawn') {//Check that the app is withdrawn
						statusToUse = 'Withdrawn';
						dateToUse = application.IIT_Withdrawn_Date__c;
					} //end status if
				}//end stage if

				if(contactToAssess.TargetX_SRMb__Status__c != statusToUse
				|| contactToAssess.TargetX_SRMb__Stage_Date__c != dateToUse
				) {//check for a date discrepency
					contactToAssess.TargetX_SRMb__Status__c = statusToUse;
					contactToAssess.TargetX_SRMb__Stage_Date__c = dateToUse;
					shouldUpdateContact = true;
				}
			}//end UG exclusion

			if(shouldUpdateContact) {//if the contact should be updates
				contactsToUpdate.put(contactToAssess.id,contactToAssess);//add the contact to the list to be updated.
			}//end if
		}//end for

		if(contactsToUpdate.isEmpty() == false) {//check that there are contacts to update
			IITProgramHandler.processProgramsForContacts(contactsToUpdate.values()); //Validate program data
			IITContactHandler.updateContacts(contactsToUpdate.values());//safely update contacts
		}//end if
	}//end method

//updates contacts.
	public static void updateContacts(List<Contact> contactsToUpdate) {//Standardized update function with appropriate error trapping
		try {
			update contactsToUpdate;
			IITExceptionHandler.forceException();
		} catch(DmlException dmlExceptionCaught) {
			IITExceptionHandler.sendDMLExceptionEmail(dmlExceptionCaught);
		} catch(Exception exceptionCaught) {
			IITExceptionHandler.sendExceptionEmail(exceptionCaught);
		}
	}//end method
}