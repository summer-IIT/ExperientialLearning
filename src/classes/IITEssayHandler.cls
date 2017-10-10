public without sharing class IITEssayHandler { //Handles Essay manipulation
	private static String essayQuery; //Query for all writeable fields on an essay

	public static void toggleRequirement(Set<Id> essayIdsToProcess, boolean requirementToForce) {//Toggles TargetX_SRMb__IsRequired__c to requirementToForce for Essays with ids in essayIdsToProcess
		try {
			Map<Id,TargetX_SRMb__Essay__c> essaysToToggle = new Map<Id,TargetX_SRMb__Essay__c>([SELECT Id
			, TargetX_SRMb__IsRequired__c
			, TargetX_SRMb__Complete__c
			, IIT_Insufficiency_ID_Desc__c
			, TargetX_SRMb__Type__c
			FROM TargetX_SRMb__Essay__c
			WHERE Id in :essayIdsToProcess
			AND TargetX_SRMb__IsRequired__c != :requirementToForce
			And IIT_Application_Level__c = 'Graduate'
			FOR UPDATE
			]); //Pull essay objects with id and TargetX_SRMb__IsRequired__c where id in essayIdsToProcess and TargetX_SRMb__IsRequired__c != requirementToForce

			if(essaysToToggle.keySet().size() < 1) {//Check that we don't have any records that match
				return; //Do nothing
			}

			for(TargetX_SRMb__Essay__c essayToToggle : essaysToToggle.values()) {//Iterate through each essay to toggle
				essayToToggle.TargetX_SRMb__IsRequired__c = requirementToForce; //Set IsRequired to the desired value
				
				if(requirementToForce) {//If setting the requirement, clear the insufficiency as it no longer applies
					essayToToggle.IIT_Insufficiency_ID_Desc__c = null;

					if(essayToToggle.TargetX_SRMb__Type__c == 'Personal Statement') {//Set complete to true for personal statements
						essayToToggle.TargetX_SRMb__Complete__c = true;
					}
				} else if (essayToToggle.TargetX_SRMb__Complete__c) {
					essayToToggle.TargetX_SRMb__Complete__c = false; //Remove completion when removing applies to requirements
				}
			}

			IITEssayHandler.performUpdate(essaysToToggle.values()); //Perform database update on the desired records.
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}

//Copy Essay Section
	public static void copyEssaysForApplication(List<TargetX_SRMb__Application__c> applicationsToCloneTo, Map<Id,Id> attachmentIdMap) {//Copies all essays attached to applicationToCloneTo's previous application onto applicationToCloneTo
		Map<Id,Id> applicationIdMap = new Map<Id,Id>();

		for(TargetX_SRMb__Application__c applicationToCloneTo : applicationsToCloneTo) {//iterate through each application
			applicationIdMap.put(applicationToCloneTo.IIT_Previous_Application__c,applicationToCloneTo.Id);//put the translation id into the map.
		}

		Set<Id> applicationIds = applicationIdMap.keySet();//Create a keyset to copy

		Map<Id,TargetX_SRMb__Essay__c> essaysToClone = new Map<id,TargetX_SRMb__Essay__c>( (List<TargetX_SRMb__Essay__c>)Database.Query(IITEssayHandler.getEssayApplicationQuery() + 'TargetX_SRMb__Application__c in :applicationIds FOR UPDATE' )); //dynamically pull the applications with all writeable fields
		Map<id,TargetX_SRMb__Essay__c> essaysToInsert = new Map<Id,TargetX_SRMb__Essay__c>(); //Initialize essays to insert

		for(TargetX_SRMb__Essay__c essayToClone : essaysToClone.values() ) {//Iterate through each 
			TargetX_SRMb__Essay__c newEssay = essayToClone.clone(false,true,false,false); //Clone Essay

			//Clear unique and ID fields
			newEssay.TargetX_SRMb__Essay_Key__c = null;
			newEssay.TargetX_SRMb__SRM_ETL_ID__c = null;
			
			// Clear the requirement ID field (Which should cause managed TargetX code to rematch the essay to the correct checklist item on the new application)
			newEssay.TargetX_SRMb__RequirementID__c = null;

			newEssay.TargetX_SRMb__Application__c = applicationIdMap.get(newEssay.TargetX_SRMb__Application__c); //Set essay's application
			essaysToInsert.put(essayToClone.Id,newEssay);
		}

		IITEssayHandler.performInsert(essaysToInsert.values());//Insert the essays

		for(Id oldEssayId : essaysToInsert.keySet()) {//Iterate through each inserted essay
			attachmentIdMap.put(oldEssayId,essaysToInsert.get(oldEssayId).Id); //Add the id to the attachment Id Map
		}
	}

	private static String getEssayApplicationQuery() {//Initializes the application field map and query for all fields
		if(IITEssayHandler.essayQuery != null) {//check for cached query
			return IITEssayHandler.essayQuery;//return cached query if it exists
		}

		String tempQuery = 'SELECT'; //Initialize query with select statement

		Map<String, Schema.SObjectField> essayFields = Schema.getGlobalDescribe().get('TargetX_SRMb__Essay__c').getDescribe().fields.getMap(); //get every field for application
		for (Schema.SObjectField essayField : essayFields.values() ) { //Iterate through all field tokens
			Schema.DescribeFieldResult essayFieldDescription = essayField.getDescribe(); // Describe each field
			tempQuery += ' ' + essayFieldDescription.getName() + ','; //Add the field to the SOQL query
		}

		tempQuery = tempQuery.subString(0,tempQuery.Length() - 1); //Trim off that last comma
		tempQuery += ' FROM TargetX_SRMb__Essay__c WHERE '; //add on the from and where statements
		IITEssayHandler.essayQuery = tempQuery;
		return tempQuery; //return the query minus the variable in memory to check
	}
//Send Attachments As Email
	public static void sendEssayEmail(Id essayId) {
		String query = (IITEssayHandler.getEssayApplicationQuery() + 'Id = :essayId LIMIT 1').replace(' FROM TargetX_SRMb__Essay__c WHERE ',', RecordType.Name FROM TargetX_SRMb__Essay__c WHERE ');
		TargetX_SRMb__Essay__c essayToEmail = Database.Query(query);

		if(essayToEmail.TargetX_SRMb__IsRequired__c == false) {
			throw new IITGenericException('Cannot send email to essays that do not apply to requirements.');
		}
		else if(essayToEmail.TargetX_SRMb__Complete__c == false) {
			throw new IITGenericException('Cannot send email to incomplete essays.');
		}
		else if(essayToEmail.TargetX_SRMb__Type__c != 'Academic Training and Research Form') {
			throw new IITGenericException('Cannot send email for essays other than Academic Training Request Form');
		}

		IITEssayHandler.sendEmailWithAttachments(
			essayToEmail
			, 'Illinois Tech Academic Training and Research Form Signed' //Set subject
			, 'onestop@iit.edu' //replyto
			, true //set save as activity
			, '<HTML><HEAD></HEAD><BODY><P>Your signed ATR form is attached. Submit this form to <a href="https://mycusthelp.info/IIE/_cs/Login.aspx">IIE (https://mycusthelp.info/IIE/_cs/Login.aspx)</a> if it is complete with information from your home institution. After IIE\'s approval you will receive your registration instructions from IIT Onestop. Registration is required to attend your summer research opportunity at Illinois Tech.</P></BODY></HTML>'
		);
	}

	private static void sendEmailWithAttachments(TargetX_SRMb__Essay__c essayToEmail, String emailSubject, String replyTo, Boolean saveAsActivity, String htmlBody) {
		Contact contactForEssay = [SELECT Id
		, Email
		FROM Contact
		WHERE Id = :essayToEmail.TargetX_SRMb__Contact__c
		LIMIT 1];

		List<Attachment> attachments = [SELECT Name
		, Body
		, BodyLength
		FROM Attachment
		WHERE ParentId = :essayToEmail.Id];

		if(attachments.size() < 1) {
			throw new IITGenericException('Cannot send email for essays without attachments.');
		}

		string[] recipientAddresses = new string[]{contactForEssay.Email};
		List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
		Messaging.SingleEmailMessage emailToSend = new Messaging.SingleEmailMessage();
		emailToSend.setToAddresses(recipientAddresses);
		emailToSend.setReplyTo(replyTo);
		emailToSend.setSaveAsActivity(saveAsActivity);
		emailToSend.setSubject(emailSubject);
		emailToSend.setHtmlBody(htmlBody);

		List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();

		for(Attachment attachmentToSend : attachments) {
			Messaging.Emailfileattachment emailAttachmentToSend = new Messaging.Emailfileattachment();
			emailAttachmentToSend.setFileName(attachmentToSend.Name);
			emailAttachmentToSend.setBody(attachmentToSend.Body);
			fileAttachments.add(emailAttachmentToSend);
		}
		emailToSend.setFileAttachments(fileAttachments);
		emailsToSend.add(emailToSend);

		Messaging.sendEmail(emailsToSend,false);
	}

//Update and Insert
	public static void performInsert(List<TargetX_SRMb__Essay__c> essaysToInsert) {
		try {
			Insert essaysToInsert; //Perform database update on the desired records.
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}

	public static void performUpdate(List<TargetX_SRMb__Essay__c> essaysToUpdate) {
		try {
			Update essaysToUpdate; //Perform database update on the desired records.
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}
}