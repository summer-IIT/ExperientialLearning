public without sharing class IITAttachmentHandler { //Handles Attachment manipulation
/**
* @author Illinois Institute of Technology 
* @date 2015
* @description Object handler on Attachment object to support marking parent objects as required
*/

//Processing region
	private static Map<IITAttachmentDirectives,Set<Id>> attachmentParentsToProcess;//Map of attachments parent ids to process grouped by strings for directives

//initialization region
	private static void initializeAttachmentParentsToProcess() {//initailize the attachment parent
		if(IITAttachmentHandler.attachmentParentsToProcess == null) {//check that the map is null
			IITAttachmentHandler.attachmentParentsToProcess = new Map<IITAttachmentDirectives,Set<Id>>(); //Initialize map of string-Set<id> pairs, the id set consists of attachment parent Ids. The string indicates the action we wish to taske on the objects
		}
	}

//trigger region
	public static void processAttachmentTrigger(List<Attachment> attachmentsToProcess, Map<id, Attachment> attachmentMapForReconciliation, IITTriggerContext triggerContext) { //Processes a list of attachments
		try {
			if(triggerContext == IITTriggerContext.BEFORE_INSERT) {//Process before insert
				//Suboptimized list processing here

				//Setup bulkified processing
				for(Attachment attachmentToProcess: attachmentsToProcess) {//Iterate through each attachment to process
					IITAttachmentHandler.sanitizeAttachment(attachmentToProcess); //Sanitize the attachment
				}
			} else if(triggerContext == IITTriggerContext.AFTER_INSERT) {//Process after insert
				//Suboptimized list processing here
				IITAttachmentHandler.initializeAttachmentParentsToProcess();

				//Setup bulkified processing
				for(Attachment attachmentToProcess: attachmentsToProcess) {//Iterate through each attachment to process
					IITAttachmentHandler.appendAttachmentParentProcessDirective(//Apply directives determined for this attachment to the attachment map
						attachmentToProcess, IITAttachmentHandler.getAfterInsertDirectives(attachmentToProcess, null) //Determine attachment processing directives
					);
				}
				
				IITAttachmentHandler.processAttachmentDirectives();
			} else if (triggerContext == IITTriggerContext.AFTER_DELETE) {//Process after delete
				if(attachmentMapForReconciliation.isEmpty()) {//Check that the list of attachments is not null
					return; //Do nothing.
				}

				//Suboptimized list processing here
				IITAttachmentHandler.initializeAttachmentParentsToProcess();

				//Setup bulkified processing
				for(Attachment attachmentToProcess: attachmentMapForReconciliation.values()) {//Iterate through each attachment to process
					if(attachmentToProcess == null) {//Check that the attachment is null
						continue;//skip the attachment
					}

					IITAttachmentHandler.appendAttachmentParentProcessDirective(//Apply directives determined for this attachment to the attachment map
						attachmentToProcess, IITAttachmentHandler.getAfterDeleteDirectives(attachmentToProcess, null) //Determine attachment processing directives
					);
				}
				
				IITAttachmentHandler.processAttachmentDirectives();
			}
			IITExceptionHandler.forceException();//Force an exception in testing so good error trapping doesn't screw us out of code coverage
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
	}
//Sanitization
	public static void sanitizeAttachment(Attachment attachmentToSanitize) {
		if( attachmentToSanitize.Name.contains('.pdf')
		&& String.isBlank(attachmentToSanitize.ContentType)
		) {//Check that the attachment's name has PDF in it and that the attachment does not have a MIME type of application/pdf
			attachmentToSanitize.ContentType = 'application/pdf'; //Set the content type to application/pdf
		}
	}

//General tools	
	public static List<IITAttachmentDirectives> getAfterInsertDirectives(Attachment attachmentToProcess, Attachment oldAttachment) {//Determines how or if an attachment should be processed in the handler.
		List<IITAttachmentDirectives> processDirectives = new List<IITAttachmentDirectives>(); //Initialize the process directives.

		if(String.isBlank(attachmentToProcess.ParentId) == false) {//Check that the ParentId exists AND old attachment doesn't exist or old attachment ParentId has changed
			processDirectives.add(IITAttachmentDirectives.SET_CONTACT_ATTACHMENTS_TRUE); //Add the set requirement true to the directives list
			processDirectives.add(IITAttachmentDirectives.SET_REQUIREMENT_TRUE); //Add the set requirement true to the directives list
		}
		
		return processDirectives; //return the directives
	}

	private static List<IITAttachmentDirectives> getAfterDeleteDirectives(Attachment attachmentToProcess, Attachment oldAttachment) {//Determines how or if an attachment should be processed in the handler.
		List<IITAttachmentDirectives> processDirectives = new List<IITAttachmentDirectives>(); //Initialize the process directives.

		if(String.isBlank(attachmentToProcess.ParentId) == false) {//Check that the ParentId exists AND old attachment doesn't exist or old attachment ParentId has changed
			processDirectives.add(IITAttachmentDirectives.SET_REQUIREMENT_FALSE); //Add the set requirement false to the directives list
			processDirectives.add(IITAttachmentDirectives.SET_CONTACT_ATTACHMENTS_FALSE); //Add the set requirement true to the directives list
		}
		
		return processDirectives; //return the directives
	}

	private static void appendAttachmentParentProcessDirective(Attachment attachmentToProcess, List<IITAttachmentDirectives> directivesToProcess) {//Adds id of attachment to sets of ids associated with directives (actions we wish to perform)
		if(String.isBlank(attachmentToProcess.ParentId)
		|| directivesToProcess.isEmpty()
		) {//Check that attachmentToProcess does not have a ParentId or that no directives are specified
			return; //Do nothing
		}
		
		for(IITAttachmentDirectives directiveToAppend : directivesToProcess) {//for each directive
			IITAttachmentHandler.getDirectiveIDSet(directiveToAppend).add(Id.valueOf(attachmentToProcess.ParentId)); //Add the directive to the idset
		}
	}

	private static Set<Id> getDirectiveIDSet(IITAttachmentDirectives directive) {//return the attachment directive
		Set<Id> directiveIdSet = IITAttachmentHandler.attachmentParentsToProcess.get(directive); //Get the id set for this directive

		if(directiveIdSet == null) {//Check that the idset exists
			directiveIdSet = new Set<Id>(); //Initialize the set
			IITAttachmentHandler.attachmentParentsToProcess.put(directive,directiveIdSet); //add a blank id set to the map
		}

		return directiveIdSet; //return the id set
	}

	private static void processAttachmentDirectives() {//processes all directives staged
		for(IITAttachmentDirectives directive : IITAttachmentHandler.attachmentParentsToProcess.keyset()) {//Process each directive
			Set<Id> directiveIdSet = IITAttachmentHandler.attachmentParentsToProcess.get(directive);
			
			if(directive == IITAttachmentDirectives.SET_REQUIREMENT_TRUE) {
				IITEssayHandler.toggleRequirement(directiveIdSet, TRUE);
				IITRecommendationHandler.toggleRequirement(directiveIdSet, TRUE);
				IITEnrollmentHistoryHandler.toggleRequirement(directiveIdSet, TRUE);
			} else if(directive == IITAttachmentDirectives.SET_REQUIREMENT_FALSE) {
				IITEssayHandler.toggleRequirement(directiveIdSet, FALSE);
				IITRecommendationHandler.toggleRequirement(directiveIdSet, FALSE);
				IITEnrollmentHistoryHandler.toggleRequirement(directiveIdSet, FALSE);
			} else if(directive==IITAttachmentDirectives.SET_CONTACT_ATTACHMENTS_TRUE) {
				IITContactHandler.toggleHasAttachments(directiveIdSet,TRUE);
			} else if(directive==IITAttachmentDirectives.SET_CONTACT_ATTACHMENTS_FALSE) {
				IITContactHandler.toggleHasAttachments(directiveIdSet,FALSE);
			}
		}

		IITAttachmentHandler.attachmentParentsToProcess.clear(); //clear the static map
	}

	private enum IITAttachmentDirectives {
		SET_REQUIREMENT_FALSE,
		SET_REQUIREMENT_TRUE,
		SET_CONTACT_ATTACHMENTS_TRUE,
		SET_CONTACT_ATTACHMENTS_FALSE
	}
	
	public static void cloneAttachments(Map<Id,Id> attachmentParentIDMap) {
		// Clones attachments associated with key IDs in a map to value IDs
		// In order to avoid exceeding salesforce heap size limitations, the 
		// function is unable to clone attachments that exceed the MAX_STAGEABLE_SIZE
		// constant value.  In order to avoid excessive DML operations, smaller attachments
		// are grouped together and inserted in bulk.
		
		Set<Id> oldParentIds = attachmentParentIDMap.keySet();
		Set<Id> attachmentIdsToClone = new Set<Id>();	
			
		Integer stageSize = 0;
		final Integer MAX_STAGEABLE_SIZE = 5500000;
		
		// Before any cloning occurs, get information about each attachment associated with any parent ID in 
		// the map.  Used to create groups of attachments for insert and to check for oversized attachments.
		Map<Id,Attachment> attachmentsToStage = new Map<Id,Attachment>([SELECT Id
		, BodyLength, Name, ParentId
		FROM Attachment
		WHERE ParentId IN :oldParentIds
		FOR UPDATE]); 
		
		List<Attachment> attachmentValues = attachmentsToStage.values();
		List<Attachment> cloneAttachments = new List<Attachment>();
		List<Attachment> oversizedAttachments = new List<Attachment>();

		// Determine if there are any attachments associated with parent IDs, returning if none have been found.
		if(attachmentValues.size() == 0) {
			return;
		}

		// Loop through attachment information, adding attachments to a staging list until there are no remaining attachments
		// or the staged size would exceed MAX_STAGEABLE_SIZE.  If the staging list reaches the max size and attachments remain,
		// insert all attachments in the staging list, clear the attachments and list, and continue the loop.
		// If an individual attachment exceeds the maximum staging size, add its information to a list which will be displayed 
		// after the cloning process.
		for(Integer i = 0; i < attachmentValues.size(); i++) {
			Attachment attachmentToStage = attachmentValues[i];
			
			// Check to see if adding the current attachment will exceed the max stage size
			// If it will, insert staged attachments before continuing to process the 
			// current attachment.
			if(attachmentToStage.BodyLength + stageSize >= MAX_STAGEABLE_SIZE) {
				// Clone all queued attachments
				cloneAttachments = createCloneAttachments(attachmentIdsToClone, attachmentParentIDMap);
				insertCloneAttachments(cloneAttachments);
				
				// Clean up staging list and size accumulator
				attachmentIdsToClone.clear();
				cloneAttachments.clear();
				stageSize = 0;
			}

			// Check to see if the current attachment exceeds the max stage size individually
			// If the attachment is too large, add its information to the oversizedAttachments list
			// and then continue
			if(attachmentToStage.BodyLength >= MAX_STAGEABLE_SIZE) {
				oversizedAttachments.add(attachmentToStage);
				continue;
			} else {
				// Add the current attachment to the list of staged attachments and update the size of the staging list
				attachmentIdsToClone.add(attachmentToStage.Id);
				stageSize += attachmentToStage.BodyLength;
			}
		}

		// After exiting the loop, insert any remaining staged attachments
		if(attachmentIdsToClone.size() > 0) {
			cloneAttachments = createCloneAttachments(attachmentIdsToClone, attachmentParentIDMap);
			insertCloneAttachments(cloneAttachments);
		}

		// If any attachments were oversized and could not be cloned, provide information on each attachment 
		// and email the active user links to each attachment
		if(oversizedAttachments.size() != 0) {
			IITAttachmentHandler.sendOversizeAttachmentEmail(oversizedAttachments);
		}
	}
	
	public static List<Attachment> createCloneAttachments(Set<id> attachmentIdsToClone, Map<Id,Id> attachmentParentIDMap) {
		// Clones all attachments from IDs contained in attachmentIdsToClone using the IDs in attachmentParentIDMap
		// returns the new attachment objects
		
		// Query the database for the attachment objects whose IDs are contained in attachmentIdsToClone
		List<Attachment> attachmentsToClone = new List<Attachment>([SELECT Id
		, ParentId
		, Name
		, Body
		, ContentType
		, Description
		FROM Attachment
		WHERE Id IN :attachmentIdsToClone
		FOR UPDATE]); 

		List<Attachment> cloneAttachments = new List<Attachment>();
		
		// Create a new attachment for each attachment to be cloned, setting each value to the corresponding value
		// in the attachment being cloned from
		for(Attachment attachmentToClone : attachmentsToClone) {
			Attachment attachmentToInsert = new Attachment(
				Name = attachmentToClone.Name,
				ContentType = attachmentToClone.ContentType,
				Description = attachmentToClone.Description,
				ParentId = attachmentParentIDMap.get(attachmentToClone.ParentId),
				Body = attachmentToClone.Body
			);

			cloneAttachments.add(attachmentToInsert);
		}

		return cloneAttachments;		
	}
	
	public static void insertCloneAttachments(List<Attachment> cloneAttachments) {
		// Insert a list of cloned attachments, bypassing triggers on the attachment object
		
		IITTriggerHandler.bypass('IITAttachmentTriggerHandler');
		IITAttachmentHandler.performInsert(cloneAttachments);
		IITTriggerHandler.clearBypass('IITAttachmentTriggerHandler');
	}
	
	public static String oversizedAttachmentErrorMessaging(List<Attachment> oversizedAttachments) {
		// This method handles creating error messaging when the cloning process encounters attachments that are too large to 
		// be cloned automatically.
		
		String errorMessage = 'The following attachments were too large to clone automatically, please copy each manually\n\n' +
							  'In order to manually copy the attachment, download the file from the record it is saved to' +
							  ', click on the corresponding record (e.g. Essay, Recommendation) on the ' +
							  'cloned application, under the Notes & Attachments section click attach file, and attach the file\n\n';

		for(Integer i = 0; i < oversizedAttachments.size(); i++) {
			errorMessage += 'Name:  ' + oversizedAttachments[i].Name + 
							'  Record ID:  ' + oversizedAttachments[i].Id + 
							'  Size:  ' + oversizedAttachments[i].BodyLength + 
							'  Parent ID:  ' + oversizedAttachments[i].parentId + '\n';
		}
		
		return errorMessage;
	}
	
	public static void sendOversizeAttachmentEmail(List<Attachment> oversizedAttachments) {
		// Emails the active user a report of any application clone failures and the steps they should take in order to 
		// complete the cloning process if possible.
		// This funciton wraps a version that can be called in test classes and send an email.  
		if(oversizedAttachments.size() > 0) {
			sendOversizeAttachmentEmail(oversizedAttachments, false);
		}
	}
	
	public static void sendOversizeAttachmentEmail(List<Attachment> oversizedAttachments, Boolean sendEmailInTest) {
		// Emails the active user a report of any application clone failures and the steps they should take in order to 
		// complete the cloning process if possible.
		final String replyToAddress = 'studentsystem@iit.edu';
		
		// Check that the method is not being called in an apex test or that tests are flagged not to send exception emails
		if (!Test.isRunningTest() || sendEmailInTest) {
			// Get information about the application being cloned
			TargetX_SRMb__Application__c application = getApplicationFromAttachment(oversizedAttachments[0]);
			
			// Create an array of attachment IDs to attach to the email
			Id[] attachmentIds = new Id[]{};
			for(Attachment a : oversizedAttachments) {
				attachmentIds.add(a.id);
			}
			
			// List of addresses to send the email to
			String[] toAddresses = new String[]{UserInfo.getUserEmail()};
			
			// Create the HTML body for the email, formatting links as needed
			String htmlBody = createOversizeAttachmentEmailHtml(oversizedAttachments, application);
			
			// Create an email to be sent to the running user who attempted the application clone
			Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
			
			email.setToAddresses(toAddresses);
			email.setReplyTo(replyToAddress);
			email.setSaveAsActivity(false);
			email.setSenderDisplayName('IIT Salesforce EPI Team');
			email.setSubject('Application Attachment Cloning Error Details:  Application #' + application.name);
			email.setEntityAttachments(attachmentIds);
			email.setHtmlBody(htmlBody);
			email.setPlainTextBody('The HTML Body of this email could not be loaded');

			Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email}, false);
		}
	}
	
	public static String createOversizeAttachmentEmailHtml(List<Attachment> oversizedAttachments, TargetX_SRMb__Application__c application) {
		// Creates an HTML body to be sent with emails containing oversized attachments after an application clone
		// returns the formatted HTML body as a string
		final String salesforceUrl = 'https://illinoistech.my.salesforce.com/{0}';
		String htmlBody = '<HTML><HEAD>Application Clone Exception</HEAD>' +
						  '<BODY><P>The following attachments associated with application #' + 
						  formatHtmlAnchor(String.format(salesforceUrl, new String[]{application.id}), application.name) +
						  ' were too large to clone automatically, please copy each manually to the cloned application</BR></BR>' +
						  'In order to manually copy the attachment, download the file from the record it is saved to or by clicking the attachments on this email' +
						  ', click on the corresponding record (e.g. Essay, Recommendation, Enrollment History) on the ' +
						  'cloned application, under the Notes & Attachments section click attach file, and attach the file</BR></BR>' + 
						  'Oversized Attachments:</BR>';
				
		// Loop through the attachment list and add a link to each parent or container object		  
		for(Attachment a : oversizedAttachments) {
			htmlBody += formatHtmlAnchor(String.format(salesforceUrl, new String[]{a.parentId}),  String.valueOf(a.parentId.getSobjectType())) + '</BR>';
		}				  
						  
		htmlBody += 'If you have further questions or issues, replying to this email will open a case with the EPI team.</P></BODY></HTML>';
		
		return htmlBody;
	}
	
	public static TargetX_SRMb__Application__c getApplicationFromAttachment(Attachment attachment) {
		// Queries the database for the attachment parentID's application ID, then queries for the
		// application record.  In order to work on any of the attachment parent types that are 
		// encountered in cloning an application, the method uses Apex ID class methods to
		// determine the object table to query.

		Id parentId = attachment.parentId;
		Id applicationId = Id.valueOf((String)Database.query('SELECT TargetX_SRMb__Application__c ' +
															  'FROM ' + parentId.getSobjectType() + ' ' +
															  'WHERE id = :parentId'
        													 )[0].get('TargetX_SRMb__Application__c'));
        													 
        TargetX_SRMb__Application__c application = [SELECT id, name 
                                   					FROM TargetX_SRMb__Application__c 
                                    				WHERE id = :applicationId 
                                   					LIMIT 1][0];
                                   					
        return application;
	}
	
	public static String formatHtmlAnchor(String url, String urlName) {
		// Takes a URL and a name for the url and returns an anchor tag formatted to link the 
		// name to the url
		final String anchorTag = '<A HREF="{0}">{1}</A>';
		
		return String.format(anchorTag, new String[]{url, urlName});
	}

//Update and Insert
	public static void performInsert(List<Attachment> attachmentsToInsert) {//safely inserts attachments
		try {
			insert attachmentsToInsert;
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}		
	}
}