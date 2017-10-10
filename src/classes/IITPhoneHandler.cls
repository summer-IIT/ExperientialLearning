public without sharing class IITPhoneHandler { //Handles IIT Phone custom object manipulation
	@TestVisible
	private static Map<String, IITPhoneMapping__c> phoneMappings;//Mapping that holds all phone mapping custom objects
	private static String phoneSanitizationString;//string value of regex for sanitizing phone numbers
	private static Pattern phoneSanitizationRegex;//regex for sanitizing phone numbers
	private static Pattern phoneSanitizationRegexNANPA; //regex for NANPA standard phone numbers
	private static Pattern phoneSanitizationRegexE164; //regex for E.164 standard numbers

//Reference https://github.com/googlei18n/libphonenumber/ when we want to get more fancy
	
static {//Static constructor
	phoneMappings = IITPhoneMapping__c.getAll(); //Get all emails defined in custom settings
	IITPhoneHandler.validatePhoneMappings();
	IITPhoneHandler.removeDisabledMappings();

	IITPhoneHandler.phoneSanitizationRegex = Pattern.compile('\\D+');
	IITPhoneHandler.phoneSanitizationRegexNANPA = Pattern.compile('\\(\\d{3}\\) \\d{3}-\\d{4}'); //Pattern matching NANPA phone number standard
	IITPhoneHandler.phoneSanitizationRegexE164 = Pattern.compile('\\+\\d+'); //Pattern matchin E.164 standard
}

	public String contactID {set; get;} //The contact id
	public String phoneNumber {set; get;} //The phone number
	
	public IITPhoneHandler(String contactID_i, String phoneNumber_i) { //class constructor
		contactID = contactID_i;
		phoneNumber = phoneNumber_i;
	}
	
//Mapping Section
	public static void validatePhoneMappings() {//Validates phone mappings
		Map<String,Schema.SobjectField> contactFields = Schema.SobjectType.Contact.fields.getMap(); //Get all of the fields for Contacts, cache this later

		//Loop through setting definitions
		for(IITPhoneMapping__c phoneMapping : phoneMappings.values() ) {
			try {
				if(IITDynamicApexHandler.checkDynamicField(contactFields.get(phoneMapping.Phone_Number_API_Name__c)) != IITDynamicApexHandler.IITDynamicFieldCheckState.FIELD_DOES_NOT_EXIST
				|| IITDynamicApexHandler.checkDynamicField(contactFields.get(phoneMapping.Activity_Date_API_Name__c)) != IITDynamicApexHandler.IITDynamicFieldCheckState.FIELD_DOES_NOT_EXIST
				) {
					//TODO notify user that Phone Mapping is good
				}
				else {
					phoneMapping.Disable__c = true;
				}
				IITExceptionHandler.forceException();
			} catch(Exception exceptionCaught) {
				IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
			}
		}
	}

	public static void removeDisabledMappings() {//removes disabled mappings from the phone map.
		Set<String> removePhoneMappings = new Set<String>();//Initialize list of phone mappings to remove
		
		for(String phoneMapping : phoneMappings.keySet()) {
			if(phoneMappings.get(phoneMapping).Disable__c) {//Check to see if the mapping is disabled
				removePhoneMappings.add(phoneMapping); //Add phone mapping to list of those to remove
			}
		}
		
		phoneMappings.keySet().removeAll(removePhoneMappings); //Remove all invalid phone mappings
	}

//Sanitization section
	public static void sanitizeContactsPhoneNumbers(List<Contact> contactsToSanitize) {//Iterates through a list of contacts and sanitizes their phone numbers
		for(Contact contactToSanitize: contactsToSanitize) { //Iterate through the new contacts.
			IITPhoneHandler.sanitizeContactPhoneNumbers(contactToSanitize);
		}
	}

	public static void sanitizeContactPhoneNumbers(Contact contact) { //Sanitizes all the phone numbers on a contact record.
		for(String phoneMapping : phoneMappings.keySet()) { //Iterate through each phone mapping
			IITPhoneMapping__c phoneMappingObject = phoneMappings.get(phoneMapping); //Pull the phone mapping down.
			contact.put(phoneMappingObject.Phone_Number_API_Name__c,IITPhoneHandler.sanitizePhoneNumber((String)contact.get(phoneMappingObject.Phone_Number_API_Name__c)));//Assign the sanitized phone number
			contact.put(phoneMappingObject.Activity_Date_API_Name__c, System.today());//Timestamp the phone number
		}
	}

	public static String sanitizePhoneNumber(string phoneNumberToSanitize) { //Sanitizes a phone number and returns it.
	//Returns null if the phone number is blank
		if( String.isBlank(phoneNumberToSanitize) ) {//Check for null or empty
           return null; //return a null string
        }

		if(IITPhoneHandler.phoneSanitizationRegexNANPA.matcher(phoneNumberToSanitize).matches()
		|| IITPhoneHandler.phoneSanitizationRegexE164.matcher(phoneNumberToSanitize).matches()
		) {//If we already have a valid standardized phone number stop here to save cycles
			return phoneNumberToSanitize;
		}

		Matcher phoneRegexMatcher = IITPhoneHandler.phoneSanitizationRegex.matcher(phoneNumberToSanitize);//See if any matches on the phone record exist

		if( phoneRegexMatcher.find() ) {//check for a match
			phoneNumberToSanitize = phoneNumberToSanitize.replaceAll(IITPhoneHandler.phoneSanitizationRegex.pattern(),''); //remove all invalid character matches
		}
		
		if( String.isBlank(phoneNumberToSanitize) ) {//Check for null or empty
           return null; //return a null string
        }

        if(phoneNumberToSanitize.length() == 11
        && phoneNumberToSanitize.startsWith('1')
        ) { //Phone number is 11 digits long and starts with 1, identifying it as a NANPA phone number
        	phoneNumberToSanitize = phoneNumberToSanitize.substring(1);//Strip off the leading 1 from a NANPA phone number
        }

        if(phoneNumberToSanitize.length() == 10) {//NANPA standard size
        	phoneNumberToSanitize = '(' + phoneNumberToSanitize.substring(0,3) + ') ' + phoneNumberToSanitize.substring(3,6) + '-' + phoneNumberToSanitize.substring(6); //Format to (###) ###-####
        } else {//We are in e164 land
        	phoneNumberToSanitize = '+' + phoneNumberToSanitize; //Format to +############
        }
		
		return phoneNumberToSanitize; //return the santized string
	}

//Update and Insert section
	public static void stagePhoneForProcessing(List<Contact> newContacts, Map<id,Contact> oldContacts) { //Creates a new phone object or updates a phone object and adds it to a list of contacts on insert or update
		try {
			List<IITPhoneHandler> phoneHandlers = new List<IITPhoneHandler>(); //Initialize a phone handler list for processing
			
			for(Contact newContact : newContacts) { //Iterate through contacts
				Contact oldContact = null;
				
				if(oldContacts != null) {
					oldContact = oldContacts.get(newContact.id);
				}
				
				for(String phoneMapping : phoneMappings.keySet()) { //Iterate through each phone mapping
					IITPhoneMapping__c phoneMappingObject = phoneMappings.get(phoneMapping); //Pull the phone mapping down.
					
					if(String.isBlank((String)newContact.get(phoneMappingObject.Phone_Number_API_Name__c)) == false
					&&	(oldContact == null
						|| oldContact.get(phoneMappingObject.Phone_Number_API_Name__c) != newContact.get(phoneMappingObject.Phone_Number_API_Name__c)
						)
					) {//Check that phone fields in the set have been populated and have changed	
						IITPhoneHandler phoneHandler = new IITPhoneHandler(newContact.id,(String)newContact.get(phoneMappingObject.Phone_Number_API_Name__c)); //Initialize the phone handler for use in processing
						phoneHandlers.add(phoneHandler); //Add the phone handler to the list for processing
					}
				}
			} // end contact for loop
			
			if(oldContacts == null) {//Don't check for other records, just create. This is for inserts
				IITPhoneHandler.createPhonesFromList(phoneHandlers); //Pass the phone numbers for creation
			} else {
				IITPhoneHandler.processPhonesFromList(phoneHandlers); //Pass the phone numbers for creation or update
			}
			IITExceptionHandler.forceException();
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	} // end stagePhoneForProcessing function

	public static void createPhonesFromList(List<IITPhoneHandler> phoneNumberstoCreate) { // function that receives phone numbers and creates phone records
	
		List<IIT_Phone__c> phonesToInsert = new List<IIT_Phone__c>(); //Create a list of phone records to insert
		
		for(IITPhoneHandler phoneHandler : phoneNumbersToCreate) { // iterate through phone numbers
			IIT_Phone__c phoneToInsert = new IIT_Phone__c();  //Create new phone record to insert
			IITPhoneHandler.populatePhoneData(phoneToInsert,phoneHandler); //Populate data from phone handler to phone record
			phonesToInsert.add(phoneToInsert); //Add phone record for bulk insertion
		} // end phoneHandler for loop
		
		insert phonesToInsert; // Bulk insert phone records into database
	}
	
	public static void processPhonesFromList(List<IITPhoneHandler> phoneHandlersToProcess) {//Iterates through the phone objects and creates or updates them
		List<IIT_Phone__c> phonesToInsert = new List<IIT_Phone__c>(); //Create a list of phone records to insert
		Map<id,IIT_Phone__c> phonesToUpdate = new Map<id, IIT_Phone__c>(); //Create a map to verify if a phone record is already in the update list.
		Map<String,List<IITPhoneHandler>> contactIdToPhoneHandlerList = new Map<String,List<IITPhoneHandler>>(); //Create a map of contact ID to PhoneHandler List for processing

		for(IITPhoneHandler phoneHandler: phoneHandlersToProcess) {//Iterate through the serialized phone objects
			List<IITPhoneHandler> phoneHandlerList = contactIdToPhoneHandlerList.get(phoneHandler.contactID); //Pull the list down from the map
			
			if(phoneHandlerList == null) {//check that the list is null
				phoneHandlerList = new List<IITPhoneHandler>(); //Initialize the phone handler list for use in the map
				contactIdToPhoneHandlerList.put(phoneHandler.contactID,phoneHandlerList); //Add the list to the map for later processing
			}

			phoneHandlerList.add(phoneHandler); //Add the phone handler to the list associated with the contact in the map for later processing
		}
		
		Map<id,List<IIT_Phone__c>> mapContactsToPhones = IITPhoneHandler.mapContactsToPhones(contactIdtoPhoneHandlerList.keySet()); //Get a list of all existing phones for the list of contacts
		
		for(String contactIdToCheck: contactIdtoPhoneHandlerList.keySet()) {//Iterate through all the contacts
			List<IITPhoneHandler> phoneHandlersToProcessFromContact = contactIdToPhoneHandlerList.get(contactIdToCheck); //Pull the list of phones to process from the map for processing
			
			for(IITPhoneHandler phoneHandlerToProcess : phoneHandlersToProcessFromContact) {//Iterate through the list of phone handlers for the contact
				IIT_Phone__c phoneToModify = null; //Intialize a Phone record container

				if(mapContactsToPhones.containsKey(contactIdToCheck) ){//Check that the map has a contact id
					List<IIT_Phone__c> phonesToCheck = mapContactsToPhones.get(contactIdToCheck); //Locally store the phones

					for(IIT_Phone__c phoneToCheck : phonesToCheck) {//Iterate through the Phone records and check for matches
						if(processPhoneMatch(phoneToCheck, phoneHandlerToProcess) ) { //Check that the phone matches, this will also apply dates
							phoneToModify = phoneToCheck; //Set the phone variable to contain a value so we know to update
							break; //break out of the phone loop
						}
					}
				}

				if(phoneToModify == null) {//Check that we haven't found a match
					phoneToModify = new IIT_Phone__c(); //Make a new phone record
					populatePhoneData(phoneToModify, phoneHandlerToProcess); //Populate the phone record with the data
					phonesToInsert.add(phoneToModify); //Add the phone to the list of those to insert
				} else {
					phonesToUpdate.put(phoneToModify.id,phoneToModify);
				}
			}
		}
		
		try {
			insert phonesToInsert;
			IITExceptionHandler.forceException();
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
		
		try {
			update phonesToUpdate.values();
			IITExceptionHandler.forceException();
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}
	
    public static Map<id,List<IIT_Phone__c>> mapContactsToPhones(Set<String> contactsToMap) {//Generates a map of contact ids to associated phone record list
        Map<id,List<IIT_Phone__c>> mapOfContactsToPhones = new Map<Id,List<IIT_Phone__c>>(); //Make new map
        List<Contact> contacts = [SELECT id,
			(SELECT id
			, IIT_Contact__c
			, IIT_Phone_Number__c
			FROM Contact.IIT_Phones__r)
		FROM Contact WHERE id IN : contactsToMap]; //Get contact all related phone manipulation data.
        
        for(Contact newContact: contacts) { //Iterate through all of the contacts.
            mapOfContactsToPhones.put(newContact.id, newContact.IIT_Phones__r); //Add the phone list to the map associated with the contact.
        }
        
        return mapOfContactsToPhones; //return the completed phone list.
    }
	
	public static boolean processPhoneMatch(IIT_Phone__c phoneToMatch, IITPhoneHandler phoneHandlerToMatch) {//Checks an phone record to see if it is a match
	//Modifies the phone record and returns true if it is a match. Otherwise returns false
		string comparatorReplacement = '[^\\d]+'; //string for replace all to handle everything not a number

		if(phoneToMatch.IIT_Phone_Number__c.replaceAll(comparatorReplacement,'') == phoneHandlerToMatch.phoneNumber.replaceAll(comparatorReplacement,'') ) {//Check that phone number matches
			//Do nothing for now.
			//TODO: Add advanced phone metadata processing and population here
			return true;
		}
		
		return false;
	}

//Core functionality
	public static void populatePhoneData(IIT_Phone__c phoneToModify, IITPhoneHandler phoneHandler) {//Populates data from an phone handler object to an phone record
			phoneToModify.IIT_Contact__c = phoneHandler.contactID; //Set the contact
			phoneToModify.IIT_Phone_Number__c = phoneHandler.phoneNumber;  //Set the phone number
	}	
}