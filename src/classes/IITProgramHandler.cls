public without sharing class IITProgramHandler { //Handles IIT Program custom object manipulation

	private static Map<String, List<IIT_Program__c>> allProgramsMapCache; //Cached map of degree_major contactenation as a key and the program object as the value.
	private static Map<String, IIT_Department_Sharing__c> departmentSharingMap; //Cached map of department sharing rules

//Global functions region
	public static Map<String,List<IIT_Program__c>> getAllProgramsMap() { //pulls all active programs and returns a map of degree_major contactenation as a key and the program object as the value.
		if(IITProgramHandler.allProgramsMapCache == null) { //Check that the programs map cache is not cached properly
			IITProgramHandler.refreshProgramCache(); //Recache the programs.
		}

		return IITProgramHandler.allProgramsMapCache; //return the programs
	}
	
	public static void refreshProgramCache() { //Refreshes the program map.
		IITProgramHandler.allProgramsMapCache = new Map<String,List<IIT_Program__c>>(); //Initialize map to return.
		List<IIT_Program__c> allProgramsList = [SELECT id
		, IIT_Program_Name__c
		, IIT_Level__c
		, IIT_Degree__c
		, IIT_Major__c
		, IIT_College__c
		, IIT_Department__c
		, IIT_End_Term_Banner_Code__c
		, IIT_Start_Term_Banner_Code__c
		, IIT_Decision_Reviewer__c
		, IIT_Assign_Contact_Owner_By_Program__c
		, IIT_Assign_Application_Owner_By_Program__c
		, OwnerId
		FROM IIT_Program__c
		ORDER BY IIT_End_Term_Banner_Code__c]; //Selects all programs and all desired fields for iteration.
		
		for(IIT_Program__c programToMap: allProgramsList) { //Iterate through all programs and assign them to the map.
			IITProgramHandler.addProgramToMapCache(programToMap.IIT_Degree__c + '_' + programToMap.IIT_Major__c, programToMap); //Assign the program to the contacenation of its degree, an underscore, and its major. This isn't always a unique key due to deprecated programs
		}
	}

	private static void addProgramToMapCache(string mapKey, IIT_Program__c programToAdd) {//Adds a program to the map cache's list
		List<IIT_Program__c> programList = IITProgramHandler.allProgramsMapCache.get(mapKey); //get the current list down

		if(programList == null) {//this will be null if not list exists.
			programList = new List<IIT_Program__c>();
			IITProgramHandler.allProgramsMapCache.put(mapKey,programList);
		}

		programList.add(programToAdd);
	}

//Department Sharing
	public static Map<String, IIT_Department_Sharing__c> getDepartmentSharingMap() { //pulls all department map cache settings
		if(IITProgramHandler.departmentSharingMap == null) { //Check that the department sharing map is not cached
			IITProgramHandler.refreshDepartmentSharingMap(); //Recache the department sharing map
		}//end if

		return IITProgramHandler.departmentSharingMap; //return the maps
	}//end method getDepartmentSharingMap

	public static void refreshDepartmentSharingMap() {//Populates the department sharing map
		Map<String, IIT_Department_Sharing__c> tempDepartmentSharingMap = IIT_Department_Sharing__c.getAll(); //Get all department sharing defined in custom settings

		IITProgramHandler.departmentSharingMap = new Map<String, IIT_Department_Sharing__c>();

		for(IIT_Department_Sharing__c departmentSharing : tempDepartmentSharingMap.values()) {//iterate through all department sharing maps and assign them appropriately
			IITProgramHandler.departmentSharingMap.put(departmentSharing.IIT_Department_Name__c,departmentSharing); //add entry to the static map using the department name
		}//end for loop
	}//end method refreshDepartmentSharingMap

//Contact Processing Region
	public static void processProgramsForContacts(List<Contact> contactsToProcess) {//Takes a list of contacts and assigns programs to them based on Degree Type and Major and populates valid data back to the contact.
		try {
			Map<String,List<IIT_Program__c>> allProgramsMap = IITProgramHandler.getAllProgramsMap(); //Gets all the active programs in a map with the contacenation of its degree, an underscore, and its major as the key and the program object as the value.
			
			for(Contact contactToProcess : contactsToProcess) {//Iterate through each contact

				if( String.isBlank(contactToProcess.TargetX_SRMb__Degree__c)
				|| String.isBlank(contactToProcess.TargetX_SRMb__Anticipated_Major__c)
				) { //If the degree or major is null, we can't have a program match.
					IITProgramHandler.processProgramForContact(contactToProcess,null);
					continue; //Skip to the next contact
				}
				
				String degreeUnderscoreMajor = contactToProcess.TargetX_SRMb__Degree__c + '_' + contactToProcess.TargetX_SRMb__Anticipated_Major__c; //Assign a string to check against the map.
				
				if( allProgramsMap.containsKey(degreeUnderscoreMajor) ) {//Check that the program map has a matching degree and major combination.
					List<IIT_Program__c> matchedPrograms = allProgramsMap.get(degreeUnderscoreMajor); //Get the program list matching the degree and major combination
					IITProgramHandler.processProgramForContact(contactToProcess,matchedPrograms);
				}
				else {//No match was found. Treat this as a null program.
					IITProgramHandler.processProgramForContact(contactToProcess,null);
				}
			}
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}
	
	public static void processProgramForContact(Contact contactToProcess, List<IIT_Program__c> programsToProcess) {//Takes a contact and a program and assigns the program's validated data to the contact.
	//If program is null, instead clear the program fields for the contact.
		if(programsToProcess == null
		|| programsToProcess.size() < 1
		) {//If the program is null
			contactToProcess.IIT_Program__c = null; //Clear the program field on the contact.
			contactToProcess.TargetX_SRMb__Program__c = null; //Clear the program name on the contact.
			return; //Stop doing anything.
		} else {//The program is not null
			for(IIT_Program__c programToProcess : programsToProcess) {//Iterate through each program
				if(contactToProcess.IIT_Banner_Term__c == 0
				|| (	(programToProcess.IIT_Start_Term_Banner_Code__c == null
						|| programToProcess.IIT_Start_Term_Banner_Code__c <= contactToProcess.IIT_Banner_Term__c
						)
					&&	(programToProcess.IIT_End_Term_Banner_Code__c == null
						|| programToProcess.IIT_End_Term_Banner_Code__c > contactToProcess.IIT_Banner_Term__c
						)
					)
				) {//Check that the contact's banner term does not exist; or the program's start term does not exist or  the program's start term is less than or equal to the contact's banner term, and the program's end term does not exist or the program's end term is less than the contact's banner term.
					contactToProcess.IIT_Program__c = programToProcess.id; //Set the contact's program object reference.
					contactToProcess.TargetX_SRMb__Program__c = programToProcess.IIT_Program_Name__c; //Set the contact's program name field to the sanitized program name
					contactToProcess.TargetX_SRMb__Level__c = programToProcess.IIT_Level__c; //Set the contact's level to the program's level.
					contactToProcess.TargetX_SRMb__College__c = programToProcess.IIT_College__c; //Set the contact's college to the program's college.
					contactToProcess.Department = programToProcess.IIT_Department__c; //Set the contact's department to the program's department.

					if(programToProcess.IIT_Assign_Contact_Owner_By_Program__c) {//if assigning the contact's owner by program is set to true
						contactToProcess.OwnerId = programToProcess.OwnerId;//set the contact's owner to the program's owner
						contactToProcess.TGTX_Group_Assignment_Override__c = true;//turn off group assignment so we don't get into a fight with that functionality
					}

					if(programToProcess.IIT_Level__c == 'Graduate') {//for graduate
						IIT_Department_Sharing__c departmentSharing = IITProgramHandler.getDepartmentSharingMap().get(programToProcess.IIT_Department__c);//Get the department sharing object based on department

						if(departmentSharing != null) {//check that the department sharing is not null
							contactToProcess.put(departmentSharing.IIT_Department_Field__c,true);//set the department sharing field based on the sharing setting
						}
					}
					return;
				} //end if
			} //end for

			//No match found.
			contactToProcess.IIT_Program__c = null; //Clear the program field on the contact.
			contactToProcess.TargetX_SRMb__Program__c = null; //Clear the program name on the contact.
		}
	}
	
//Application Processing Region
	public static void processProgramsForApplications(List<TargetX_SRMb__Application__c> applicationsToProcess, Map<Id,TargetX_SRMb__Application__c> oldApplicationsMap) {//Takes a list of applications and assigns programs to them based on Degree Type and Major and populates valid data back to the application.
		try {
			for(TargetX_SRMb__Application__c applicationToProcess : applicationsToProcess) {//Iterate through each application

				if( String.isBlank(applicationToProcess.TargetX_SRMb__Degree__c)
				|| String.isBlank(applicationToProcess.TargetX_SRMb__Possible_Academic_Major__c)
				) { //If the degree or major is null, we can't have a program match.
					processProgramForApplication(applicationToProcess,null);
					continue; //Skip to the next application
				}

				if(applicationToProcess.id != null
				&& oldApplicationsMap.get(applicationToProcess.id) != null
				&& oldApplicationsMap.get(applicationToProcess.id).TargetX_SRMb__Degree__c == applicationToProcess.TargetX_SRMb__Degree__c
				&& oldApplicationsMap.get(applicationToProcess.id).TargetX_SRMb__Possible_Academic_Major__c == applicationToProcess.TargetX_SRMb__Possible_Academic_Major__c
				) {//check that data has not changed in any appreciable form.
					continue; //skip to the next record
				}
				IITProgramHandler.determineProgramForApplication(applicationToProcess);
			}
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}

	public static void determineProgramForApplication(TargetX_SRMb__Application__c applicationToProcess) {
		String degreeUnderscoreMajor = applicationToProcess.TargetX_SRMb__Degree__c + '_' + applicationToProcess.TargetX_SRMb__Possible_Academic_Major__c; //Assign a string to check against the map.
		
		if( IITProgramHandler.getAllProgramsMap().containsKey(degreeUnderscoreMajor) ) {//Check that the program map has a matching degree and major combination.
			List<IIT_Program__c> matchedPrograms = IITProgramHandler.getAllProgramsMap().get(degreeUnderscoreMajor); //Assign the program from the map for further manipulation.
			processProgramForApplication(applicationToProcess,matchedPrograms);
		}
		else {//No match was found. Treat this as a null program.
			processProgramForApplication(applicationToProcess,null);
		}		
	}

	public static void processProgramForApplication(TargetX_SRMb__Application__c applicationToProcess, List<IIT_Program__c> programsToProcess) {//Takes an application and a program and assigns the program's validated data to the application.
	//If program is null, instead clear the program fields for the application.
		if(programsToProcess == null
		|| programsToProcess.size() < 1
		) {//If the program is null
			applicationToProcess.IIT_Program__c = null; //Clear the program field on the application.
			applicationToProcess.TargetX_SRMb__Program__c = null; //Clear the program name on the application.
			return; //Stop doing anything.
		}
		else {//The program is not null
			for(IIT_Program__c programToProcess : programsToProcess) {//Iterate through each program
				if(applicationToProcess.IIT_Banner_Term__c == 0
				|| (	(programToProcess.IIT_Start_Term_Banner_Code__c == null
						|| programToProcess.IIT_Start_Term_Banner_Code__c <= applicationToProcess.IIT_Banner_Term__c
						)
					&&	(programToProcess.IIT_End_Term_Banner_Code__c == null
						|| programToProcess.IIT_End_Term_Banner_Code__c > applicationToProcess.IIT_Banner_Term__c
						)
					)
				) {//Check that the contact's banner term does not exist; or the program's start term does not exist or  the program's start term is less than or equal to the contact's banner term, and the program's end term does not exist or the program's end term is less than the contact's banner term.
					applicationToProcess.IIT_Program__c = programToProcess.id; //Set the applications program object reference.
					applicationToProcess.TargetX_SRMb__Program__c = programToProcess.IIT_Program_Name__c; //Set the application's program name field to the sanitized program name
					applicationToProcess.TargetX_SRMb__Level__c = programToProcess.IIT_Level__c; //Set the application's level to the program's level.
					applicationToProcess.TargetX_SRMb__College__c = programToProcess.IIT_College__c; //Set the application's college to the program's college.
					applicationToProcess.Department__c = programToProcess.IIT_Department__c; //Set the application's department to the program's department.

					if(programToProcess.IIT_Assign_Application_Owner_By_Program__c) {
						applicationToProcess.IIT_Application_Owner__c = programToProcess.OwnerId;
					}

					if(String.isBlank(programToProcess.IIT_Decision_Reviewer__c) == false) {
						applicationToProcess.IIT_Decision_Reviewer__c = programToProcess.IIT_Decision_Reviewer__c;
					}
					return;
				}//end if
			}//end for

			//no match found
			applicationToProcess.IIT_Program__c = null; //Clear the program field on the application.
			applicationToProcess.TargetX_SRMb__Program__c = null; //Clear the program name on the application.
		}//end if
	} //end method
}