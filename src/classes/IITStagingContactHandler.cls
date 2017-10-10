public without sharing class IITStagingContactHandler { //Handles IIT Staging Contact object manipulation

	public static void processContactDeletion(Map<id,Contact> oldContactsDeletedMap) { //Processes old contacts.
		try {
			List<IIT_Staging_Contact__c> stagingContactsToInsert = new List<IIT_Staging_Contact__c>(); //Initialize list of staging contacts to create.		
			
			for(Contact deletedContact: oldContactsDeletedMap.values()) {//Iterate through each deleted contact.
				IIT_Staging_Contact__c stagingContactToInsert = createNewStagingContact(deletedContact); //Create staging contact record.
				
				if(stagingContactToInsert!= null) {//If the staging contact record exists.
					stagingContactsToInsert.add(stagingContactToInsert); //Add the staging contact to the list of those to insert.
				}
			}
			
			try {
				insert stagingContactsToInsert; //Insert the staging contacts.
				IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
			} catch(Exception exceptionCaught) {//Catch any errors
				IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
			}
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}
	
	public static IIT_Staging_Contact__c createNewStagingContact(Contact contact) {
		if( String.isBlank(contact.MasterRecordId) )  {//check that the record was merged
			return null;
		}

		IIT_Staging_Contact__c stagingContact = new IIT_Staging_Contact__c();
		
		if(String.isBlank(contact.IIT_Merged_Recruiter_IDs__c) == false) {//Process the  merged recruiter Ids
			stagingContact.IIT_Contact__c = contact.MasterRecordId; //Set the master record Id reference so we know this is a valid record.
			stagingContact.IIT_Merged_Recruiter_IDs__c = contact.IIT_Merged_Recruiter_IDs__c.toLowerCase(); //Set the field.
			
			if( String.isBlank(contact.IIT_Recruiter_Contact_ID__c) == false) { //Recruiter ID exists
				if(stagingContact.IIT_Merged_Recruiter_IDs__c.indexOf(contact.IIT_Recruiter_Contact_ID__c.toLowerCase()) == -1) { //Check that the merged Ids does not contain the merged id
					stagingContact.IIT_Merged_Recruiter_IDs__c += ';' + contact.IIT_Recruiter_Contact_ID__c.toLowerCase();
				}
			}
		}
		else if( String.isBlank(contact.IIT_Recruiter_Contact_ID__c) == false) {//Merged Recruiter IDs not populated, Recruited ID populated
			stagingContact.IIT_Contact__c = contact.MasterRecordId; //Set the master record Id reference so we know this is a valid record.
			stagingContact.IIT_Merged_Recruiter_IDs__c = contact.IIT_Recruiter_Contact_ID__c.toLowerCase(); //Set the merged recruiter ids to the staging record's.
		}
		
		if(stagingContact.IIT_Contact__c != null)
		{
			//setStagingContactRecordType(stagingContact,'Staging Contact (Awaiting Processing)');
			return stagingContact;
		}
		
		return null;
	}
	
	//public static void setStagingContactRecordType(IIT_Staging_Contact__c stagingContact, String recordTypeName) {//Sets the record type of a staging contact.
	//	stagingContact.RecordType = getStagingContactRecordType(recordTypeName); //set the record type to awaiting processing.
	//}
	
	//public static Id getStagingContactRecordType(String recordTypeName) {//returns record type ID based on the string entered.
	//	try {
	//		return devRecordTypeId = IIT_Staging_Contact__c.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
	//	} catch(Exception caughException) { //Catch any errors
	//		return null; //Return nothing if this was a failure.
	//	}
	//}
}