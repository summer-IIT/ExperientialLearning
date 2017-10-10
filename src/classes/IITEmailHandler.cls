public without sharing class IITEmailHandler { //Handles IIT Email custom object manipulation

	@TestVisible
	private static Map<String, IITEmailMapping__c> emailMappings;
	
static {//Static constructor
	emailMappings = IITEmailMapping__c.getAll(); //Get all emails defined in custom settings
	IITEmailHandler.validateEmailMappings();
	IITEmailHandler.removeDisabledMappings();
}

//Properties
	public String contactID {set; get;} //The contact id
	public String emailAddress {set; get;} //The email address
	
	public IITEmailHandler(String contactID_i, String emailAddress_i) {//class constructor
		contactID = contactID_i;
		emailAddress = emailAddress_i;
	}
	
//Mapping Section
	public static void validateEmailMappings() {//Validates aemail mappings
		Map<String,Schema.SobjectField> contactFields = Schema.SobjectType.Contact.fields.getMap(); //Get all of the fields for Contacts, cache this later

		//Loop through setting definitions
		for(IITEmailMapping__c emailMapping : emailMappings.values() ) {
			try {
				if(IITDynamicApexHandler.checkDynamicField(contactFields.get(emailMapping.Email_Address_API_Name__c)) != IITDynamicApexHandler.IITDynamicFieldCheckState.FIELD_DOES_NOT_EXIST) {
					//TODO notify user that Email Mapping is good
				}
				else {
					emailMapping.Disable__c = true;
				}
				IITExceptionHandler.forceException();
			} catch(Exception exceptionCaught) {
				IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
			}
		}
	}

	public static void removeDisabledMappings() {//removes disabled mappings from the email map.
		Set<String> removeEmailMappings = new Set<String>();//Initialize list of email mappings to remove
		
		for(String emailMapping : emailMappings.keySet()) {
			if(emailMappings.get(emailMapping).Disable__c) {//Check to see if the mapping is disabled
				removeEmailMappings.add(emailMapping); //Add email mapping to list of those to remove
			}
		}
		
		emailMappings.keySet().removeAll(removeEmailMappings); //Remove all invalid email mappings
	}
	
//Sanitization section
	public static void sanitizeContactsEmails(List<Contact> contactsToSanitize) {//Iterates through a list of contacts and sanitizes their emails
		for(Contact contactToSanitize: contactsToSanitize) { //Iterate through the new contacts.
			IITEmailHandler.sanitizeContactEmails(contactToSanitize);
		}
	}

	public static void sanitizeContactEmails(Contact contact) { //Sanitizes all the email address on a contact record.
		for(String emailMapping : emailMappings.keySet()) { //Iterate through each phone mapping
			IITEmailMapping__c emailMappingObject = emailMappings.get(emailMapping); //Pull the email mapping down.
			contact.put(emailMappingObject.Email_Address_API_Name__c,IITEmailHandler.sanitizeEmailAddress((String)contact.get(emailMappingObject.Email_Address_API_Name__c)));//Assign the sanitized email address
		}
	}

	public static String sanitizeEmailAddress(string emailAddressToSanitize) { //Sanitizes an email address and returns it.
	//Returns null if the email is blank
		if( String.isBlank(emailAddressToSanitize) ) {//Check for null or empty
           return null; //return a null string
        }
		
		emailAddressToSanitize = emailAddressToSanitize.toLowerCase().trim(); //make the email lowercase and strip leading and trailing spaces
		
		if( String.isBlank(emailAddressToSanitize) ) {//Check for null or empty
           return null; //return a null string
        }
		
		return emailAddressToSanitize; //return the santized string
	}

//Update and Insert section
	public static void stageEmailForProcessing(List<Contact> newContacts, Map<id,Contact> oldContacts) {//Pulls email data for a list of contacts and serializes it, sending it to future functions for inserting or updating email objects as appropriate.
		try {
			List<IITEmailHandler> emailHandlers = new List<IITEmailHandler>(); //Initialize a list to hold email handlers for processing

			for(Contact newContact: newContacts) {//Iterate through contacts
				Contact oldContact = null;
				
				if(oldContacts != null) {//Check that the old contents map exists
					oldContact = oldContacts.get(newContact.id); //Get the old contact.
				}

				for(String emailMapping : emailMappings.keySet()) { //Iterate through each phone mapping
					IITEmailMapping__c emailMappingObject = emailMappings.get(emailMapping); //Pull the email mapping down.
					
					if(String.isBlank((String)newContact.get(emailMappingObject.Email_Address_API_Name__c)) == false
					&&	(oldContact == null
						|| oldContact.get(emailMappingObject.Email_Address_API_Name__c) != newContact.get(emailMappingObject.Email_Address_API_Name__c)
						)
					) {//Check that email fields in the set have been populated and have changed	
						IITEmailHandler emailHandler = new IITEmailHandler(newContact.id,(String)newContact.get(emailMappingObject.Email_Address_API_Name__c)); //Initialize the email handler for use in processing
						emailHandlers.add(emailHandler); //Add the email handler to the list for processing
					}
				}
			}
				
			if(oldContacts == null) {//Don't check for other records, just create. This is for inserts.
				IITEmailHandler.createEmailsFromList(emailHandlers); //Create email records from email objects
			} else {//Check for other records and potentially update them.
				IITEmailHandler.processEmailsFromList(emailHandlers); //Create or update email records from email objects
			}
			IITExceptionHandler.forceException();
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}

//Insert section
	public static void createEmailsFromList(List<IITEmailHandler> emailHandlersToCreate) {//Iterates through the email objects and creates them on the associated contacts
		List<IIT_Email__c> emailsToInsert = new List<IIT_Email__c>(); //Create a list of email addresses to insert
		
		for(IITEmailHandler emailHandler: emailHandlersToCreate) {//Iterate through the serialized email records
			IIT_Email__c emailToInsert = new IIT_Email__c(); //Create new email record to insert
			populateEmailData(emailToInsert, emailHandler); //populate the data to the email record
			emailsToInsert.add(emailToInsert); //Add the record for insertion
		}
		
		insert emailsToInsert; //Insert the record
	}

//Update section
	public static void processEmailsFromList(List<IITEmailHandler> emailHandlersToProcess) {//Iterates through a list of email objects and creates or updates them
		List<IIT_Email__c> emailsToInsert = new List<IIT_Email__c>(); //Create a list of email records to insert
		Map<id,IIT_Email__c> emailsToUpdate = new Map<id,IIT_Email__c>(); //Create a map to verify if an email record is already in the update list.
		Map<String,List<IITEmailHandler>> contactIdToEmailHandlerList = new Map<String,List<IITEmailHandler>>(); //Create a map of contact ID to EmailHandler List for processing

		for(IITEmailHandler emailHandler: emailHandlersToProcess) {//Iterate through the email objects
			List<IITEmailHandler> emailHandlerList = contactIdToEmailHandlerList.get(emailHandler.contactID); //Pull the list down from the map, this will be null if none exists.
			
			if(emailHandlerList == null) {//Check that the list is null.
				emailHandlerList = new List<IITEmailHandler>(); //Initialize the email handler list for use in the map
				contactIdToEmailHandlerList.put(emailHandler.contactID,emailHandlerList); //Add the list to the map for later processing
			}
			
			emailHandlerList.add(emailHandler); //Add the email handler object to the list			
		}
		
		Map<id,List<IIT_Email__c>> mapContactsToEmails = IITEmailHandler.mapContactsToEmails(contactIdToEmailHandlerList.keySet()); //Get a list of all existing emails for the list of contacts
		
		for(String contactIdToCheck: contactIdToEmailHandlerList.keySet() ) {//Iterate through all the contacts
			List<IITEmailHandler> emailHandlersToProcessFromContact = contactIdToEmailHandlerList.get(contactIdToCheck); //Pull the list of emails to process from the map for processing
			
			for(IITEmailHandler emailHandlerToProcess : emailHandlersToProcessFromContact) {//Iterate through the list of email handlers for the contact
				IIT_Email__c emailToModify = null; //Intialize a Email record container
				List<IIT_Email__c> emailsToCheck = mapContactsToEmails.get(contactIdToCheck); //Locally store the emails

				if(emailsToCheck != null) {//Check that the map has a contact id
					for(IIT_Email__c emailToCheck : emailsToCheck) {//Iterate through the Email records and check for matches
						if(processEmailMatch(emailToCheck, emailHandlerToProcess) ) { //Check that the email matches, this will also apply dates
							emailToModify = emailToCheck; //Set the email variable to contain a value so we know to update
							break; //break out of the email loop
						}
					}
				}

				if(emailToModify == null) {//Check that we haven't found a match
					emailToModify = new IIT_Email__c(); //Make a new email record
					populateEmailData(emailToModify, emailHandlerToProcess); //Populate the email record with the data
					emailsToInsert.add(emailToModify); //Add the email to the list of those to insert
				} else {
					emailsToUpdate.put(emailToModify.id,emailToModify); //Add the email to the list of those to update
				}
			}
		}
		
		try {
			insert emailsToInsert;
			IITExceptionHandler.forceException();
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}

		try{
			update emailsToUpdate.values();
			IITExceptionHandler.forceException();
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}
	
    public static Map<id,List<IIT_Email__c>> mapContactsToEmails(Set<String> contactsToMap) {//Generates a map of contact ids to associated email record list
        Map<id,List<IIT_Email__c>> mapOfContactsToEmails = new Map<Id,List<IIT_Email__c>>(); //Make new map
        List<Contact> contacts = [SELECT id,
			(SELECT id
			, IIT_Contact__c
			, IIT_Email_Address__c
			FROM Contact.IIT_Emails__r)
		FROM Contact WHERE id IN : contactsToMap]; //Get contact all related email manipulation data.
        
        for(Contact newContact: contacts) { //Iterate through all of the contacts.
            mapOfContactsToEmails.put(newContact.id, newContact.IIT_Emails__r); //Add the email list to the map associated with the contact.
        }
        
        return mapOfContactsToEmails; //return the completed email list.
    }
	
	public static boolean processEmailMatch(IIT_Email__c emailToMatch, IITEmailHandler emailHandlerToMatch) {//Checks an email record to see if it is a match
	//Modifies the email record and returns true if it is a match. Otherwise returns false
		if(emailToMatch.IIT_Email_Address__c == emailHandlerToMatch.emailAddress) {//Check that email address matches
			//Do nothing for now.
			//TODO: Add advanced email metadata processing and population here
			return true;
		}
		
		return false;
	}
//Core functionality
	public static void populateEmailData(IIT_Email__c emailToModify, IITEmailHandler emailHandler) {//Populates data from an email handler object to an email record
		emailToModify.IIT_Contact__c = emailHandler.contactID; //Set the contact.
		emailToModify.IIT_Email_Address__c = emailHandler.emailAddress; //Set the email address
	}
}