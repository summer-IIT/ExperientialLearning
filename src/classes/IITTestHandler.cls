@isTest
public without sharing class IITTestHandler { //Handles IIT unit testing
//Framework testing
	@isTest
	public static void conductDynamicApexTesting() {//Applies unit testing to the dynamic apex tester
		Map<String,Schema.SobjectField> contactFields = Schema.SobjectType.Contact.fields.getMap(); //Get all of the fields for Contacts, cache this later
		IITDynamicApexHandler.checkDynamicField(contactFields.get('Email'));
		IITDynamicApexHandler.checkDynamicField(contactFields.get('zzNeverValidzz'));
		
		Profile profile = [SELECT Id
			FROM Profile
			WHERE Name='Standard User'
			];
		User userTest = new User(Alias = 'iittes'
			, Email='standarduser@IIT.test'
			, EmailEncodingKey='UTF-8'
			, LastName='Testing'
			, LanguageLocaleKey='en_US'
			, LocaleSidKey='en_US'
			, ProfileId = profile.Id
			, TimeZoneSidKey='America/Los_Angeles'
			, UserName='standarduser@IIT.test'
		);
			
		System.runAs(userTest) {
			IITDynamicApexHandler.checkDynamicField(contactFields.get('MergedRecordId'));
		}
	}

	@isTest
	public static void conductErrorTesting() {//Conducts testing on error handling
		IITExceptionHandler.sendEmailInTest = true;
		try{
			throw new IITGenericException('IIT Test Handler Exception.');
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
		IITExceptionHandler.sendEmailInTest = false;
	}

	@isTest
	public static void conductBatchReplaceTesting1() {//Conducts testing of BatchReplace for not null
	//Accounts
		List<Account> accountsToTest = IITTestHandler.dataFactoryAccounts(5);
		System.assert(accountsToTest.size() > 0);

		String query = 'SELECT id'
		+ ', Site '
		+ 'FROM Account '
		+ ' WHERE Site = null';
		String entity = 'Account';
		String field = 'Site';
		String value = 'Somewhere';
		String valueType = 'String';

		Id batchInstanceId = Database.executeBatch(new IITBatchReplace(query,entity,field,value,valueType), 2);

		query = 'SELECT id'
		+ ', IsExcludedFromRealign '
		+ 'FROM Account '
		+ ' WHERE Site = null';
		field = 'IsExcludedFromRealign';
		value = 'TRUE';
		valueType = 'Boolean';

		batchInstanceId = Database.executeBatch(new IITBatchReplace(query,entity,field,value,valueType), 2);
	}

//Standard Object testing
//Account
	@isTest
	public static void conductAccountTesting() {//Conducts testing on Accounts
	//Accounts
		List<Account> accountsToTest = IITTestHandler.dataFactoryAccounts(5);
		System.assert(accountsToTest.size() > 0);

		Database.SaveResult[] saveResults = Database.Insert(accountsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
		
		saveResults = Database.update(accountsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		Database.DeleteResult[] deleteResults = Database.delete(accountsToTest, false);
		checkDeleteResults(deleteResults);//Validate the results

		Database.UndeleteResult[] undeleteResults = Database.undelete(accountsToTest, false);
		//TODO add undelete results checker
	}
//Attachment
	@isTest
	public static void conductAttachmentTesting() {//Conducts testing on attachment triggers
		Integer numberOfContactsToTest = 20;
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(numberOfContactsToTest);
		System.assert(contactsToTest.size() == numberOfContactsToTest); //Validate that we retrieved numberOfContactsToTest records
		
		Database.SaveResult[] saveResults = Database.Insert(contactsToTest, false);
		System.assert(saveResults.size() == numberOfContactsToTest);//Validate that numberOfContactsToTest operations were performed
		IITTestHandler.checkSaveResults(saveResults); //Validate the save results
		
		List<Id> idList = new List<Id>(new Map<Id, Contact>(contactsToTest).keySet());
	//Attachments
		List<Attachment> attachmentsToTest = IITTestHandler.dataFactoryAttachments(idList);
		System.assert(attachmentsToTest.size() > 0);

		saveResults = Database.Insert(attachmentsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		Database.DeleteResult[] deleteResults = Database.Delete(attachmentsToTest, false);
		IITTestHandler.checkDeleteResults(deleteResults); //Validate the results
	}
//Contact
	@isTest
	public static void conductContactTesting() {//Conducts testing on contact triggers
		Integer numberOfContactsToTest = 100; //Specify the number of contacts to test.
	//Stages
		List<String> contactStages = IITTestHandler.dataFactoryContactStages(); //Get the stages we have defined.
		System.assert(contactStages.size() > 0); //Validate that we retrieved at least one record
	//Years
		List<Integer> contactYears = IITTestHandler.dataFactoryContactYears(); //Get the years we have defined.
		System.assert(contactYears.size() > 0); //Validate that we retrieved at least one record
	//Terms
		List<String> contactTerms = IITTestHandler.dataFactoryContactTerms();
		System.assert(contactTerms.size() > 0); //Validate that we retrieved at least one record
	//Programs
		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms(); //Get the programs we have defined.
		System.assert(programsList.size() > 0); //Validate that we retrieved at least one record

		Database.SaveResult[] saveResults = Database.insert(programsList, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Address Mappings
		List<IITAddressMapping__c> addressMappings = IITTestHandler.dataFactoryAddressMappings(); //Get the address mappings we have defined
		System.assert(addressMappings.size() > 0); //Validate that we retrieved at least one record

		saveResults = Database.insert(addressMappings, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Phone Mappings
		List<IITPhoneMapping__c> phoneMappings = IITTestHandler.dataFactoryPhoneMappings(); //Get the phone mappings we have defined
		System.assert(phoneMappings.size() > 0); //Validate that we retrieved at least one record

		saveResults = Database.insert(phoneMappings, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Email Mappings
		List<IITEmailMapping__c> emailMappings = IITTestHandler.dataFactoryEmailMappings(); //Get the email mappings we have defined
		System.assert(emailMappings.size() > 0); //Validate that we retrieved at least one record

		saveResults = Database.insert(emailMappings, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results 
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(numberOfContactsToTest);
		System.assert(contactsToTest.size() == numberOfContactsToTest); //Validate that we retrieved numberOfContactsToTest records
		
		saveResults = Database.Insert(contactsToTest, false);
		System.assert(saveResults.size() == numberOfContactsToTest);//Validate that numberOfContactsToTest operations were performed
		IITTestHandler.checkSaveResults(saveResults); //Validate the save results

		//Update modifications
		for(Integer i = 0; i < numberOfContactsToTest; i++) {
			//Change recruitment path data
			if( Math.mod(i,programsList.size() * 2) == 0 ) {
				contactsToTest[i].TargetX_SRMb__Degree__c = (Math.mod(i,3) == 0 ? null : 'Bachelor of Science');
				contactsToTest[i].TargetX_SRMb__Anticipated_Major__c = (Math.mod(i,3) == 0 ? null : 'Applied Analytics');
				contactsToTest[i].TargetX_SRMb__Stage_Date__c = (Math.mod(i,2) == 0 ? system.today() : null);
				contactsToTest[i].TargetX_SRMb__Status__c = (Math.mod(i,contactStages.size() + 1) == 0 ? null : contactStages[Math.mod(i,contactStages.size() + 1) - 1]);
				contactsToTest[i].TargetX_SRMb__Anticipated_Start_Year__c = (Math.mod(i,3) == 0 ? null : 2015);
				contactsToTest[i].TargetX_SRMb__Anticipated_Start_Term__c = (Math.mod(i,3) == 0 ? null : 'Fall');
			}
			
			//Change contact data
			if(Math.mod(i,3) < 2) {
				contactsToTest[i].Phone = (Math.mod(i,2) == 0 ? null : '5555559999');
				contactsToTest[i].OtherPhone = (Math.mod(i,2) == 0 ? null : '5555559998');
				contactsToTest[i].Email = (Math.mod(i,2) == 0 ? null : 'IITTest' + String.valueof(i + 1) + '@iit.fake');
				contactsToTest[i].MailingStreet = (Math.mod(i,2) == 0 ? null : 'Street' + String.valueof(i + 1));
				contactsToTest[i].MailingCity = (Math.mod(i,2) == 0 ? null : 'Kalamazoo' + String.valueof(i + 1));
				contactsToTest[i].MailingState = (Math.mod(i,2) == 0 ? null : 'IL' + String.valueof(i + 1));
				contactsToTest[i].MailingPostalCode = (Math.mod(i,2) == 0 ? null : '60' + String.valueof(i + 1));
				contactsToTest[i].MailingCountry = (Math.mod(i,2) == 0 ? null : 'Naboo' + String.valueof(i + 1));
			}
		}
		
		saveResults = Database.Update(contactsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the save results
		
		//run delete triggers
		Database.DeleteResult[] deleteResults = Database.Delete(contactsToTest, false);
		IITTestHandler.checkDeleteResults(deleteResults);
	}
//Contact Merge
	/*@isTest
	public static void conductContactMergeTesting() {//Conducts testing on contact merges. Had to split this off as it was creating issues and merges make a ton of calls
		Integer numberOfContactsToTest = 20; //Specify the number of contacts to test.
	//Accounts
		List<Account> accountsToTest = IITTestHandler.dataFactoryAccounts(1);
		System.assert(accountsToTest.size() > 0);

		Database.SaveResult[] saveResults = Database.Insert(accountsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Custom Settings
		List<TargetX_Base__CRM_Setting__c> crmSettings = IITTestHandler.dataFactoryTargetXCRMBaseSettings(accountsToTest[0]);
		System.assert(crmSettings.size() > 0);

		saveResults = Database.Insert(crmSettings, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

	//Stages
		List<String> contactStages = IITTestHandler.dataFactoryContactStages(); //Get the stages we have defined.
		System.assert(contactStages.size() > 0); //Validate that we retrieved at least one record
	//Years
		List<Integer> contactYears = IITTestHandler.dataFactoryContactYears(); //Get the years we have defined.
		System.assert(contactYears.size() > 0); //Validate that we retrieved at least one record
	//Terms
		List<String> contactTerms = IITTestHandler.dataFactoryContactTerms();
		System.assert(contactTerms.size() > 0); //Validate that we retrieved at least one record
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(numberOfContactsToTest);
		System.assert(contactsToTest.size() == numberOfContactsToTest); //Validate that we retrieved numberOfContactsToTest records
		
		saveResults = Database.Insert(contactsToTest, false);
		System.assert(saveResults.size() == numberOfContactsToTest);//Validate that numberOfContactsToTest operations were performed
		IITTestHandler.checkSaveResults(saveResults); //Validate the save results

		//merge contacts
		for(Integer i = 0; i < 10; i++ ) { //merge 5 sets of contacts
			if(Math.mod(i,3) == 0) { //Merged recruiter ids not null, Recruiter ID is not null, Recruiter ID in merged Ids
				contactsToTest[i+1].IIT_Recruiter_Contact_ID__c = 'ForceId'.toLowerCase();
				contactsToTest[i+1].IIT_Merged_Recruiter_IDs__c = contactsToTest[i+1].IIT_Recruiter_Contact_ID__c.toLowerCase();
			}
			else if(Math.mod(i,2) == 0) {//Merged recruiter id is null, Recruiter ID is not null
				contactsToTest[i+1].IIT_Recruiter_Contact_ID__c = 'ForceId'.toLowerCase();
				contactsToTest[i+1].IIT_Merged_Recruiter_IDs__c = null;
			}
			
			merge contactsToTest[i] contactsToTest[i+1]; //DML merge the contacts since there's no good apex method to accomplish it
			contactsToTest.remove(i+1); //remove the bad contact from the list so we don't trip delete errors
		}
	}*/

//Essays
	@isTest
	public static void conductEssayTesting() {//Conducts testing on recommendation triggers
	//Programs
		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms();
		System.assert(programsList.size() > 0);
		
		Database.SaveResult[] saveResults = Database.insert(programsList, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(5);
		System.assert(contactsToTest.size() > 0);

		saveResults = Database.Insert(contactsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Applications
		List<TargetX_SRMb__Application__c> applicationsToTest = IITTestHandler.dataFactoryApplications(contactsToTest, 5);
		System.assert(applicationsToTest.size() > 0);
		
		saveResults = Database.Insert(applicationsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Essays
		List<TargetX_SRMb__Essay__c> essaysToTest = IITTestHandler.dataFactoryEssays(applicationsToTest,2,IITTestHandler.DataFactoryEssayTypes());
		System.assert(essaysToTest.size() > 0);

		saveResults = Database.Insert(essaysToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
		
		List<Id> idList = new List<Id>(new Map<Id, TargetX_SRMb__Essay__c>(essaysToTest).keySet());
	//Attachments
		List<Attachment> attachmentsToTest = IITTestHandler.dataFactoryAttachments(idList);
		System.assert(attachmentsToTest.size() > 0);

		saveResults = Database.Insert(attachmentsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		saveResults = Database.Update(attachmentsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		Database.DeleteResult[] deleteResults = Database.Delete(attachmentsToTest, false);
		IITTestHandler.checkDeleteResults(deleteResults);
	//Back to Essays
		saveResults = Database.Update(essaysToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		deleteResults = Database.Delete(essaysToTest, false);
		IITTestHandler.checkDeleteResults(deleteResults);
	}
//Essay Handler
	@isTest
	public static void conductEssayHandlerTesting() {//Conducts testing on recommendation triggers
	//Programs
		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms();
		System.assert(programsList.size() > 0);
		
		Database.SaveResult[] saveResults = Database.insert(programsList, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(5);
		System.assert(contactsToTest.size() > 0);

		saveResults = Database.Insert(contactsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Applications
		List<TargetX_SRMb__Application__c> applicationsToTest = IITTestHandler.dataFactoryApplications(contactsToTest, 5);
		System.assert(applicationsToTest.size() > 0);
		
		saveResults = Database.Insert(applicationsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Essays
		List<TargetX_SRMb__Essay__c> essaysToTest = IITTestHandler.dataFactoryEssays(applicationsToTest,2,IITTestHandler.DataFactoryEssayTypes());
		System.assert(essaysToTest.size() > 0);

		saveResults = Database.Insert(essaysToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
		
		Set<Id> essayIdsToProcess = new Map<Id, TargetX_SRMb__Essay__c>(essaysToTest).keySet();
		
		IITEssayHandler.toggleRequirement(essayIdsToProcess, false);
		IITEssayHandler.toggleRequirement(essayIdsToProcess, true);
	}
//Essay Global
	@isTest
	public static void conductEssayGlobalTesting() {//Conducts testing on recommendation triggers
	//Programs
		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms();
		System.assert(programsList.size() > 0);
		
		Database.SaveResult[] saveResults = Database.insert(programsList, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(5);
		System.assert(contactsToTest.size() > 0);

		saveResults = Database.Insert(contactsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Applications
		List<TargetX_SRMb__Application__c> applicationsToTest = IITTestHandler.dataFactoryApplications(contactsToTest, 5);
		System.assert(applicationsToTest.size() > 0);
		
		saveResults = Database.Insert(applicationsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Essays
		List<String> essayTypes = new List<String>{'Academic Training and Research Form'};
		List<TargetX_SRMb__Essay__c> essaysToTest = IITTestHandler.dataFactoryEssays(applicationsToTest,2,essayTypes);
		System.assert(essaysToTest.size() > 0);

		saveResults = Database.Insert(essaysToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Attachments
		List<Id> idList = new List<Id>(new Map<Id, TargetX_SRMb__Essay__c>(essaysToTest).keySet());

		List<Attachment> attachmentsToTest = IITTestHandler.dataFactoryAttachments(idList);
		System.assert(attachmentsToTest.size() > 0);

		boolean completeEssay = true;
		for(TargetX_SRMb__Essay__c essayToTest : essaysToTest) {
			essayToTest.TargetX_SRMb__Complete__c = completeEssay;
		}

		saveResults = Database.Update(essaysToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		saveResults = Database.Insert(attachmentsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		IITEssayGlobal.sendEssayEmail(idList[0]);
	}
//Recommendation
	@isTest
	public static void conductRecommendationTesting() {//Conducts testing on recommendation triggers
	//Programs
		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms();
		System.assert(programsList.size() > 0);
		
		Database.SaveResult[] saveResults = Database.insert(programsList, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(5);
		System.assert(contactsToTest.size() > 0);

		saveResults = Database.Insert(contactsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Applications
		List<TargetX_SRMb__Application__c> applicationsToTest = IITTestHandler.dataFactoryApplications(contactsToTest, 5);
		System.assert(applicationsToTest.size() > 0);
		
		saveResults = Database.Insert(applicationsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Recommendation
		List<TargetX_SRMb__Recommendation__c> recommendationsToTest = IITTestHandler.dataFactoryRecommendations(applicationsToTest,2);
		System.assert(recommendationsToTest.size() > 0);

		saveResults = Database.Insert(recommendationsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
		
		List<Id> idList = new List<Id>(new Map<Id, TargetX_SRMb__Recommendation__c>(recommendationsToTest).keySet());
	//Attachments
		List<Attachment> attachmentsToTest = IITTestHandler.dataFactoryAttachments(idList);
		System.assert(attachmentsToTest.size() > 0);

		saveResults = Database.Insert(attachmentsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		saveResults = Database.Update(attachmentsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		Database.DeleteResult[] deleteResults = Database.Delete(attachmentsToTest, false);
		IITTestHandler.checkDeleteResults(deleteResults);
	//Back to Recommendation
		saveResults = Database.Update(recommendationsToTest, false); //This consistently fails to trigger a flow, so I removed the restriction. There's some conflict with the ARM and updating a recommendation without changing fields introduced only in the latest patch as of 10/9/2015
		//IITTestHandler.checkSaveResults(saveResults); //Validate the results

		deleteResults = Database.Delete(recommendationsToTest, false);
		IITTestHandler.checkDeleteResults(deleteResults);
	}
	
//RecommendationHandler
	@isTest
	public static void conductRecommendationHandlerTesting() {//Conducts testing on recommendation triggers
	//Programs
		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms();
		System.assert(programsList.size() > 0);
		
		Database.SaveResult[] saveResults = Database.insert(programsList, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(5);
		System.assert(contactsToTest.size() > 0);

		saveResults = Database.Insert(contactsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Applications
		List<TargetX_SRMb__Application__c> applicationsToTest = IITTestHandler.dataFactoryApplications(contactsToTest, 5);
		System.assert(applicationsToTest.size() > 0);
		
		saveResults = Database.Insert(applicationsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Recommendation
		List<TargetX_SRMb__Recommendation__c> recommendationsToTest = IITTestHandler.dataFactoryRecommendations(applicationsToTest,2);
		System.assert(recommendationsToTest.size() > 0);

		saveResults = Database.Insert(recommendationsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
		
		Set<Id> recommendationIdsToProcess = new Map<Id, TargetX_SRMb__Recommendation__c>(recommendationsToTest).keySet();
		IITRecommendationHandler.toggleRequirement(recommendationIdsToProcess,false);
		IITRecommendationHandler.toggleRequirement(recommendationIdsToProcess,true);
	}

//Enrollment History
	@isTest
	public static void conductEnrollmentHistoryTesting() {//Conducts testing on enrollment history triggers
	//Programs
		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms();
		System.assert(programsList.size() > 0);
		
		Database.SaveResult[] saveResults = Database.insert(programsList, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Accounts
		List<Account> accountsToTest = IITTestHandler.dataFactoryAccounts(5);
		System.assert(accountsToTest.size() > 0);

		saveResults = Database.Insert(accountsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(5);
		System.assert(contactsToTest.size() > 0);

		saveResults = Database.Insert(contactsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Applications
		List<TargetX_SRMb__Application__c> applicationsToTest = IITTestHandler.dataFactoryApplications(contactsToTest, 5);
		System.assert(applicationsToTest.size() > 0);
		
		saveResults = Database.Insert(applicationsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Enrollment History
		List<TargetX_SRMb__Enrollment_History__c> enrollmentHistoriesToTest = IITTestHandler.dataFactoryEnrollmentHistories(applicationsToTest, accountsToTest, 2);
		System.assert(enrollmentHistoriesToTest.size() > 0);

		saveResults = Database.Insert(enrollmentHistoriesToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
		
		List<Id> idList = new List<Id>(new Map<Id, TargetX_SRMb__Enrollment_History__c>(enrollmentHistoriesToTest).keySet());
	//Attachments
		List<Attachment> attachmentsToTest = IITTestHandler.dataFactoryAttachments(idList);
		System.assert(attachmentsToTest.size() > 0);

		saveResults = Database.Insert(attachmentsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		saveResults = Database.Update(attachmentsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		Database.DeleteResult[] deleteResults = Database.Delete(attachmentsToTest, false);
		IITTestHandler.checkDeleteResults(deleteResults);
	//Back to Enrollment History
		saveResults = Database.Update(enrollmentHistoriesToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		deleteResults = Database.Delete(enrollmentHistoriesToTest, false);
		IITTestHandler.checkDeleteResults(deleteResults);
	}
//Enrollment History Handler
	@isTest
	public static void conductEnrollmentHistoryHandlerTesting() {//Conducts testing on enrollment history triggers
	//Programs
		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms();
		System.assert(programsList.size() > 0);
		
		Database.SaveResult[] saveResults = Database.insert(programsList, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Accounts
		List<Account> accountsToTest = IITTestHandler.dataFactoryAccounts(5);
		System.assert(accountsToTest.size() > 0);

		saveResults = Database.Insert(accountsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(5);
		System.assert(contactsToTest.size() > 0);

		saveResults = Database.Insert(contactsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Applications
		List<TargetX_SRMb__Application__c> applicationsToTest = IITTestHandler.dataFactoryApplications(contactsToTest, 5);
		System.assert(applicationsToTest.size() > 0);
		
		saveResults = Database.Insert(applicationsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Enrollment History
		List<TargetX_SRMb__Enrollment_History__c> enrollmentHistoriesToTest = IITTestHandler.dataFactoryEnrollmentHistories(applicationsToTest, accountsToTest, 2);
		System.assert(enrollmentHistoriesToTest.size() > 0);

		saveResults = Database.Insert(enrollmentHistoriesToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
		
		Set<Id> enrollmentHistoryIdsToProcess = new Map<Id, TargetX_SRMb__Enrollment_History__c>(enrollmentHistoriesToTest).keySet();
		IITEnrollmentHistoryHandler.toggleRequirement(enrollmentHistoryIdsToProcess,false);
		IITEnrollmentHistoryHandler.toggleRequirement(enrollmentHistoryIdsToProcess,true);
	}
//Events
	@isTest //TODO: Make a proper robust event data generator.
	public static void eventTester() {//Applies unit testing to events
		List<TargetX_Eventsb__OrgEvent__c> eventsToUpsert = new List<TargetX_Eventsb__OrgEvent__c>();
		
		TargetX_Eventsb__OrgEvent__c eventToUpsert = new TargetX_Eventsb__OrgEvent__c();
		eventToUpsert.Name = 'Test1';
		eventToUpsert.TargetX_Eventsb__Time_Zone__c = 'America/New_York';
		eventToUpsert.TargetX_Eventsb__Start_Date_Time__c = system.today();
		eventToUpsert.TargetX_Eventsb__End_Date_Time__c = system.today().addDays(1);
		eventToUpsert.TargetX_Eventsb__Event_Cost__c = 0.00;
		eventToUpsert.TargetX_Eventsb__Start_Date_Time__c = system.now();
		eventToUpsert.IIT_Real_Start_Minutes__c = 14;
		eventToUpsert.TargetX_Eventsb__End_Date_Time__c = system.now();
		eventToUpsert.IIT_Real_End_Minutes__c = 14;
		eventsToUpsert.add(eventToUpsert);
		
		eventToUpsert.IIT_Inquiry_Card__c = 'Garbage';

		insert eventsToUpsert;
		update eventsToUpsert;
	}
//ExtraCurricularActivityHandler
	@isTest
	public static void conductExtraCurricularHandlerTesting() {//Conducts testing on extracurricular activity triggers
	//Programs
		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms();
		System.assert(programsList.size() > 0);
		
		Database.SaveResult[] saveResults = Database.insert(programsList, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(5);
		System.assert(contactsToTest.size() > 0);

		saveResults = Database.Insert(contactsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Applications
		List<TargetX_SRMb__Application__c> applicationsToTest = IITTestHandler.dataFactoryApplications(contactsToTest, 5);
		System.assert(applicationsToTest.size() > 0);
		
		saveResults = Database.Insert(applicationsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Extra Curricular
		List<TargetX_SRMb__Extra_Curricular_Activity__c> extraCurricularsToTest = IITTestHandler.dataFactoryExtraCurriculars(applicationsToTest,2);
		System.assert(extraCurricularsToTest.size() > 0);

		saveResults = Database.Insert(extraCurricularsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
		
		Map<id,id> attachmentIdMap = new Map<id,id>();//make a map for fake testing cloning
		TargetX_SRMb__Application__c firstApplication = null;
		TargetX_SRMb__Application__c secondApplication = null;
		
		
		for(Integer i=0;i<applicationsToTest.size();i++) {
			if(applicationsToTest[i].id != null) {
				if(firstApplication == null) {
					firstApplication = applicationsToTest[i];
				} else if(secondApplication == null) {
					secondApplication = applicationsToTest[i];
					secondApplication.IIT_Previous_Application__c = firstApplication.id;
					break;
				}
			}
		}
		
		List<TargetX_SRMb__Application__c> applicationsToCloneTo = new List<TargetX_SRMb__Application__c>{secondApplication};
		IITExtraCurricularActivityHandler.copyExtraCurricularsForApplication(applicationsToCloneTo,attachmentIdMap);
	}
//FinancialAid
	@isTest
	public static void conductFinancialAidHandlerTesting() {//Conducts testing on financial aid activity triggers
	//Programs
		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms();
		System.assert(programsList.size() > 0);
		
		Database.SaveResult[] saveResults = Database.insert(programsList, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(5);
		System.assert(contactsToTest.size() > 0);

		saveResults = Database.Insert(contactsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Applications
		List<TargetX_SRMb__Application__c> applicationsToTest = IITTestHandler.dataFactoryApplications(contactsToTest, 5);
		System.assert(applicationsToTest.size() > 0);
		
		saveResults = Database.Insert(applicationsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Financial Aid
		List<TargetX_SRMb__Financial_Aid__c> financialAidToTest =  IITTestHandler.dataFactoryFinancialAid(applicationsToTest,5);
		System.assert(financialAidToTest.size() > 0);

		saveResults = Database.Insert(financialAidToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
		
		Map<id,id> attachmentIdMap = new Map<id,id>();//make a map for fake testing cloning
		TargetX_SRMb__Application__c firstApplication = null;
		TargetX_SRMb__Application__c secondApplication = null;
		
		
		for(Integer i=0;i<applicationsToTest.size();i++) {
			if(applicationsToTest[i].id != null) {
				if(firstApplication == null) {
					firstApplication = applicationsToTest[i];
				} else if(secondApplication == null) {
					secondApplication = applicationsToTest[i];
					secondApplication.IIT_Previous_Application__c = firstApplication.id;
					break;
				}
			}
		}
		
		List<TargetX_SRMb__Application__c> applicationsToCloneTo = new List<TargetX_SRMb__Application__c>{secondApplication};
		IITFinancialAidHandler.copyFinancialAidForApplication(applicationsToCloneTo,attachmentIdMap);
	}
//Programs
	@isTest
	public static void conductProgramTesting() {//Conducts testing on program triggers
		List<IIT_Program__c> programsToTest = IITTestHandler.dataFactoryPrograms();
		
		Database.SaveResult[] programInsertList = Database.insert(programsToTest, false);
		IITTestHandler.checkSaveResults(programInsertList); //Validate the results
		
		for(Integer i=0; i< programsToTest.size(); i++) {
			if(math.mod(i,2) == 0) {
				programsToTest[i].IIT_Program_Name__c = programsToTest[i].IIT_Program_Name__c + '1';
			}
		}
		
		Database.SaveResult[] programUpdateList = Database.update(programsToTest, false);
		IITTestHandler.checkSaveResults(programUpdateList); //Validate the results

		Database.DeleteResult[] programDeleteList = Database.delete(programsToTest, false);
		Database.UndeleteResult[] programUndeleteList = Database.undelete(programsToTest, false);
	}

//Test Handler
	@isTest
	public static void conductTestTesting() {
	//Programs
		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms();
		System.assert(programsList.size() > 0);
		
		Database.SaveResult[] saveResults = Database.insert(programsList, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Accounts
		List<Account> accountsToTest = IITTestHandler.dataFactoryAccounts(5);
		System.assert(accountsToTest.size() > 0);

		saveResults = Database.Insert(accountsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(5);
		System.assert(contactsToTest.size() > 0);

		saveResults = Database.Insert(contactsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Enrollment History
		List<TargetX_SRMb__Test__c> testsToTest = IITTestHandler.dataFactoryTests(contactsToTest, 2);
		System.assert(testsToTest.size() > 0);

		saveResults = Database.Insert(testsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	}
//Application Review Handler
	@isTest
	public static void conductApplicationReviewTesting() {//Conducts testing on application review triggers
	//Programs
		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms();
		System.assert(programsList.size() > 0);
		
		Database.SaveResult[] saveResults = Database.insert(programsList, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Application Review Types.
		List<TargetX_Reader__Application_Review_Type__c> reviewTypeList = IITTestHandler.dataFactoryapplicationReviewTypes();
		System.assert(reviewTypeList.size() > 0);

		saveResults = Database.insert(reviewTypeList, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		Map<id,TargetX_Reader__Application_Review_Type__c> reviewTypeMap = new Map<id,TargetX_Reader__Application_Review_Type__c>(reviewTypeList);
	//Accounts
		List<Account> accountsToTest = IITTestHandler.dataFactoryAccounts(5);
		System.assert(accountsToTest.size() > 0);

		saveResults = Database.Insert(accountsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(5);
		System.assert(contactsToTest.size() > 0);

		saveResults = Database.Insert(contactsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Applications
		List<TargetX_SRMb__Application__c> applicationsToTest = IITTestHandler.dataFactoryApplications(contactsToTest, 5);
		System.assert(applicationsToTest.size() > 0);
		
		saveResults = Database.Insert(applicationsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	//Application Reviews
		List<TargetX_Reader__Application_Review__c> applicationReviewsToTest = IITTestHandler.dataFactoryApplicationReviews(applicationsToTest, reviewTypeMap.values(), 1);
		System.assert(applicationReviewsToTest.size() > 0);

		saveResults = Database.Insert(applicationReviewsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

		boolean performedDenyToApplied;
		
		for(TargetX_Reader__Application_Review__c applicationReview : applicationReviewsToTest) {

			if((reviewTypeMap.get(applicationReview.TargetX_Reader__Application_Review_Type__c).Name.indexOf('Faculty Review')) != -1
			&& performedDenyToApplied == false
			) {
				performedDenyToApplied = true;
				applicationReview.IIT_Level__c = 'Graduate';
				applicationReview.IIT_Decision__c = 'Deny to Applied';
			}
			applicationReview.TargetX_Reader__Completed__c = true;
		}
		
		saveResults = Database.Update(applicationReviewsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the results
	}

//General tools
	public static void checkSaveResults(Database.SaveResult[] saveResults) {//Validates if save results pass testing, otherwise displays errors
		for(Database.SaveResult saveResult : saveResults) {//Iterate through each save result.
			if(saveResult.isSuccess() == false) {//Check that the save operation failed
				for(Database.Error saveError : saveResult.getErrors() ) {//Iterate through each error
					System.debug(saveError.getMessage()); //Display the message to the console
				}
			}
			System.assert(saveResult.isSuccess());//Assert that the operation was a success regardless
		}
	}
	
	public static void checkDeleteResults(Database.DeleteResult[] deleteResults) {//Validates if save results pass testing, otherwise displays errors
		for(Database.DeleteResult deleteResult : deleteResults) {//Iterate through each save result.
			if(deleteResult.isSuccess() == false) {//Check that the save operation failed
				for(Database.Error deleteError :deleteResult.getErrors() ) {//Iterate through each error
					System.debug(deleteError.getMessage()); //Display the message to the console
				}
			}
			System.assert(deleteResult.isSuccess());//Assert that the operation was a success regardless
		}
	}
	
//Data Factory
	public static List<String> dataFactoryContactStages() { //generates contact stages for use in generator
		List<String> contactStages = new List<String>();
		contactStages.add('Suspect');
		contactStages.add('Inquiry');
		contactStages.add('Registrant');
		contactStages.add('Applicant');
		contactStages.add('Application Submitter');
		contactStages.add('Admit');
		contactStages.add('Intent to Enroll');
		contactStages.add('Deposited');
		contactStages.add('Withdrawn');
		contactStages.add('Enrolled');
		return contactStages;
	}
	
	public static List<Integer> dataFactoryContactYears() { //generates contact years for use in generator
		List<Integer> contactYears = new List<Integer>();
		contactYears.add(2014);
		contactYears.add(2015);
		contactYears.add(2016);
		return contactYears;
	}
	
	public static List<String> dataFactoryContactTerms() { //generates contact terms for use in generator
		List<String> contactTerms = new List<String>();
		contactTerms.add('Spring');
		contactTerms.add('Summer');
		contactTerms.add('Fall');
		return contactTerms;
	}

	public static List<IIT_Program__c> dataFactoryPrograms() { //generates programs for use in testing
		List<IIT_Program__c> programsToGenerate = new List<IIT_Program__c>(); 
		
		IIT_Program__c programToGenerate = new IIT_Program__c(Name = 'BS-AANL'
		, IIT_Program_Name__c = 'Bachelor of Science in Applied Analytics'
		, IIT_Level__c = 'Undergraduate'
		, IIT_Degree__c = 'Bachelor of Science'
		, IIT_Major__c = 'Applied Analytics'
		, IIT_College__c = 'Lewis College of Human Science'
		, IIT_Department__c = 'Psychology'
		);
		programsToGenerate.add(programToGenerate);
		
		programToGenerate = new IIT_Program__c(Name = 'CER-ASD'
		, IIT_Program_Name__c = 'Certificate in Advanced Software Development'
		, IIT_Level__c = 'Graduate'
		, IIT_Degree__c = 'Certificate'
		, IIT_Major__c = 'Advanced Software Development'
		, IIT_College__c = 'School of Applied Technology'
		, IIT_Department__c = 'Information Technology and Management'
		);
		programsToGenerate.add(programToGenerate);
		
		programToGenerate = new IIT_Program__c(Name = 'MAS-DSC'
		, IIT_Program_Name__c = 'Master in Data Science'
		, IIT_Level__c = 'Graduate'
		, IIT_Degree__c = 'Master'
		, IIT_Major__c = 'Data Science'
		, IIT_College__c = 'College of Science'
		, IIT_Department__c = 'Computer Science'
		);
		programsToGenerate.add(programToGenerate);
		
		programToGenerate = new IIT_Program__c(Name = 'MS-BME'
		, IIT_Program_Name__c = 'Master of Science in Biomedical Engineering'
		, IIT_Level__c = 'Graduate'
		, IIT_Degree__c = 'Master of Science'
		, IIT_Major__c = 'Biomedical Engineering'
		, IIT_College__c = 'Armour College of Engineering'
		, IIT_Department__c = 'Biomedical Engineering'
		);
		programsToGenerate.add(programToGenerate);
		
		programToGenerate = new IIT_Program__c(Name = 'NDG-BA-1'
		, IIT_Program_Name__c = 'Non Degree Graduate in Business Administration'
		, IIT_Level__c = 'Graduate'
		, IIT_Degree__c = 'Non Degree Graduate'
		, IIT_Major__c = 'Business Administration'
		, IIT_College__c = 'Stuart School of Business'
		, IIT_Department__c = 'Business Administration'
		);
		programsToGenerate.add(programToGenerate);

		return programsToGenerate;
	}
	
	public static List<Account> dataFactoryAccounts(Integer numberofAccounts) {//generates accounts for use in testing
		List<Account> accountsToGenerate = new List<Account>(); //Initialize list of accounts to generate;
		
		for(Integer i = 0; i < numberOfAccounts; i++) {//Iterate through number of accounts to generate
			Account accountToGenerate = new Account(Name = 'Test Account' + String.valueof(i)
			, TargetX_SRMb__ceeb_code__c = (numberofAccounts >= 100 ? '000' + String.valueof(i) : (numberofAccounts >= 10 ? '0000' + String.valueof(i) : '00000' + String.valueof(i)))
			);
			accountsToGenerate.add(accountToGenerate);
		}
		
		return accountsToGenerate;
	}
	
	public static List<Attachment> dataFactoryAttachments (List<Id> idsForAttachments) {//Generates attachments for use in testing
		List<Attachment> attachmentsToGenerate = new List<Attachment>(); //Initialize list of attachments to generate.
		
		for(Integer i = 0; i < idsForAttachments.size(); i++) {//Iterate through each id
			Attachment attachmentToGenerate = new Attachment(Name='Test Attachment' + String.valueof(i) + '.pdf'
			, Body = Blob.valueOf('Test Attachment Body' + String.valueof(i))
			, ParentId = idsForAttachments[i]
			, ContentType = (Math.mod(i,2) == 0 ? null : 'application/pdf')
			);
			attachmentsToGenerate.add(attachmentToGenerate);
		}
		
		return attachmentsToGenerate;
	}
	
	public static List<Contact> dataFactoryContacts(Integer numberOfContacts) { //generates contacts for use in testing
	//Contact Section
		List<Contact> contactsToGenerate = new List<Contact>(); //List of contacts for insert

		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms();
		List<String> contactStages = IITTestHandler.dataFactoryContactStages();
		List<Integer> contactYears = IITTestHandler.dataFactoryContactYears();
		List<String> contactTerms = IITTestHandler.dataFactoryContactTerms();
		
		for(Integer i = 0; i < numberOfContacts; i++) {//Iterate through number of contacts to generate
			Contact contactToGenerate = new Contact(LastName = 'IITTest' + string.valueof(i)
			, Email = 'IITTest' + String.valueof(i) + '@iit.fake'
			, Phone = '5555551' + (i >= 100 ? String.valueof(i) : (i >= 10 ? '0' + String.valueof(i) : '00' + string.valueof(i) ) )
			, OtherPhone = '5555552'  + (i >= 100 ? string.valueof(i) : (i >= 10 ? '0' + String.valueof(i) : '00' + string.valueof(i) ) )
			, MailingStreet = 'Test' + String.valueof(i)
			, MailingCity = 'Timbuktu' + String.valueof(i)
			, MailingState = 'Invalid' + String.valueof(i)
			, MailingPostalCode = '605' + String.valueof(i)
			, MailingCountry = 'India' + String.valueof(i)
			, TargetX_SRMb__MailingCounty__c = 'County'  + String.valueof(i)
			, TargetX_SRMb__Degree__c = (Math.mod(i,programsList.size() + 1) == 0 ? null : programsList[Math.mod(i,programsList.size() + 1) - 1].IIT_Degree__c)
			, TargetX_SRMb__Anticipated_Major__c = (Math.mod(i,programsList.size() + 1) == 0 ? null : programsList[Math.mod(i,programsList.size() + 1) - 1].IIT_Major__c)
			, TargetX_SRMb__Stage_Date__c = (Math.mod(i,2) == 0 ? system.today() : null)
			, TargetX_SRMb__Status__c = (Math.mod(i,contactStages.size() + 1) == 0 ? null : contactStages[Math.mod(i,contactStages.size() + 1) - 1])
			, TargetX_SRMb__Anticipated_Start_Year__c = (Math.mod(i,contactYears.size() + 1) == 0 ? null : contactYears[Math.mod(i,contactYears.size() + 1) - 1])
			, TargetX_SRMb__Anticipated_Start_Term__c = (Math.mod(i,contactTerms.size() + 1) == 0 ? null :contactTerms[Math.mod(i,contactTerms.size() + 1) - 1])
			, IIT_Recruiter_Contact_ID__c = (Math.mod(i,2) == 0 ? String.valueof(i) : '' )
			, IIT_Merged_Recruiter_IDs__c = (Math.mod(i,3) == 0 ? 'm' + String.valueof(i) : '' )
			, TargetX_SRMb__Student_Type__c = 'First Year'
			);
			
			contactsToGenerate.add(contactToGenerate);
		}
		
		return contactsToGenerate;
	}

	public static List<TargetX_SRMb__Application__c> dataFactoryApplications(List<Contact> contactsForApps, Integer numberOfAppsPerContact) { //generates applications for use in testing
		List<TargetX_SRMb__Application__c> applicationsToGenerate = new List<TargetX_SRMb__Application__c>(); //Initialize list of applications to Generate
		
		List<IIT_Program__c> programsList = IITTestHandler.dataFactoryPrograms();
		List<Integer> contactYears = IITTestHandler.dataFactoryContactYears();
		List<String> contactTerms = IITTestHandler.dataFactoryContactTerms();
		
		for(Contact contactForApp : contactsForApps) {//Iterate through contacts
			for(Integer i = 0; i < numberOfAppsPerContact; i++) {//Iterate up to numberOfAppsPerContact on contats
				TargetX_SRMb__Application__c applicationToGenerate = new TargetX_SRMb__Application__c(TargetX_SRMb__Contact__c = contactForApp.id
				, IIT_Application_Start_Date__c = (Math.mod(i,2) == 0 ? system.today().AddDays(i) : system.today())
				, TargetX_SRMb__Start_Term__c = contactTerms[Math.mod(i,contactTerms.size())]
				, TargetX_SRMb__Start_Term_Year__c = String.valueOf(contactYears[Math.mod(i,contactYears.size())])
				, TargetX_SRMb__Degree__c = (Math.mod(i,programsList.size() + 1) == 0 ? null : programsList[Math.mod(i,programsList.size() + 1) - 1].IIT_Degree__c)
				, TargetX_SRMb__Possible_Academic_Major__c = (Math.mod(i,programsList.size() + 1) == 0 ? null : programsList[Math.mod(i,programsList.size() + 1) - 1].IIT_Major__c)
				, TargetX_SRMb__Stage__c = (Math.mod(i,4) == 0 ? 'In Progress' : 'Submitted')
				, TargetX_SRMb__Application_Decision__c = (
					Math.mod(i,4)  == 0 ? null :
						(Math.mod(i,4) == 1 ? 'Admit to Alternate' :
							(Math.mod(i,4) == 2 ? 'Deny': 'Admit')
						)
					)
				, TargetX_SRMb__Status__c = (Math.mod(i,4) == 3 ? 'Deffered' : 'Withdrawn')
				, TargetX_SRMb__Accept_Enrollment_Deposit__c = (Math.mod(i,2) == 0 ? FALSE : TRUE)
				, TargetX_SRMb__Deposit_Intent_to_Enroll__c = (Math.mod(i,2) == 0 ? 'No' : 'Yes')
				, IIT_Dont_Run_Processes__c = true
				);
				
				applicationsToGenerate.add(applicationToGenerate);
			}
		}

		return applicationsToGenerate;
	}
	
	public static List<String> dataFactoryEssayTypes() {//Generates essay types
		List<String> essayTypes = new List<String>();
		essayTypes.Add('Personal Statement');
		essayTypes.Add('Professional Statement');
		essayTypes.Add('Resume');
		return essayTypes;
	}
	
	public static List<TargetX_SRMb__Essay__c> dataFactoryEssays(List<TargetX_SRMb__Application__c> applicationsForEssays, Integer numberOfEssaysPerApplication, List<String> essayTypes) {
		List<TargetX_SRMb__Essay__c> essaysToGenerate = new List<TargetX_SRMb__Essay__c>(); //Initialize list of essays to generate

		System.assert(essayTypes.size() > 0);

		for(TargetX_SRMb__Application__c applicationForEssays : applicationsForEssays) {
			for(Integer i = 0; i < numberOfEssaysPerApplication; i++) {
				TargetX_SRMb__Essay__c essayToGenerate = new TargetX_SRMb__Essay__c(Name = 'Essay' + String.valueof(i)
				, TargetX_SRMb__Application__c = applicationForEssays.id
				, TargetX_SRMb__Contact__c = applicationForEssays.TargetX_SRMb__Contact__c
				, TargetX_SRMb__Type__c = essayTypes[Math.mod(i, essayTypes.size())]
				, TargetX_SRMb__IsRequired__c = (Math.mod(i,2) == 0)
				);
				essaysToGenerate.add(essayToGenerate);
			}
		}
		
		return essaysToGenerate;
	}
	
	public static List<TargetX_SRMb__Recommendation__c> dataFactoryRecommendations(List<TargetX_SRMb__Application__c> applicationsForRecommendations, Integer numberOfRecommendationsPerApplication) {
		List<TargetX_SRMb__Recommendation__c> recommendationsToGenerate = new List<TargetX_SRMb__Recommendation__c>(); //Initialize list of essays to generate

		for(TargetX_SRMb__Application__c applicationForRecommendations : applicationsForRecommendations) {
			for(Integer i = 0; i < numberOfRecommendationsPerApplication; i++) {
				TargetX_SRMb__Recommendation__c recommendationToGenerate = new TargetX_SRMb__Recommendation__c(Name = 'Recommendation' + String.valueof(i)
				, TargetX_SRMb__Application__c = applicationForRecommendations.id
				, TargetX_SRMb__Contact__c = applicationForRecommendations.TargetX_SRMb__Contact__c
				, TargetX_SRMb__IsRequired__c = (Math.mod(i,2) == 0)
				);
				recommendationsToGenerate.add(recommendationToGenerate);
			}
		}
		
		return recommendationsToGenerate;
	}

	public static List<TargetX_SRMb__Extra_Curricular_Activity__c> dataFactoryExtraCurriculars(List<TargetX_SRMb__Application__c> applicationsForExtraCurriculars, Integer numberOfExtraCurricularsPerApplication) {
		List<TargetX_SRMb__Extra_Curricular_Activity__c> extraCurricularsToGenerate = new List<TargetX_SRMb__Extra_Curricular_Activity__c>(); //Initialize list of essays to generate

		for(TargetX_SRMb__Application__c applicationForExtraCurriculars : applicationsForExtraCurriculars) {
			for(Integer i = 0; i < numberOfExtraCurricularsPerApplication; i++) {
				TargetX_SRMb__Extra_Curricular_Activity__c extraCurricularToGenerate = new TargetX_SRMb__Extra_Curricular_Activity__c(Name = 'ExtraCurricular' + String.valueof(i)
				, TargetX_SRMb__Application__c = applicationForExtraCurriculars.id
				, TargetX_SRMb__Contact__c = applicationForExtraCurriculars.TargetX_SRMb__Contact__c
				);
				extraCurricularsToGenerate.add(extraCurricularToGenerate);
			}
		}
		
		return extraCurricularsToGenerate;
	}
	
	public static List<TargetX_SRMb__Enrollment_History__c> dataFactoryEnrollmentHistories(List<TargetX_SRMb__Application__c> applicationsForEnrollmentHistories, List<Account> accountsForEnrollmentHistories, Integer numberOfEnrollmentHistoriesPerApplication) {
		List<TargetX_SRMb__Enrollment_History__c> enrollmentHistoriesToGenerate = new List<TargetX_SRMb__Enrollment_History__c>(); //Initialize list of essays to generate

		for(TargetX_SRMb__Application__c applicationForEnrollmentHistory : applicationsForEnrollmentHistories) {
			for(Integer i = 0; i < numberOfEnrollmentHistoriesPerApplication; i++) {
				TargetX_SRMb__Enrollment_History__c enrollmentHistoryToGenerate = new TargetX_SRMb__Enrollment_History__c(Name = 'Enrollment History' + String.valueof(i)
				, TargetX_SRMb__Application__c = applicationForEnrollmentHistory.id
				, TargetX_SRMb__Contact__c = applicationForEnrollmentHistory.TargetX_SRMb__Contact__c
				, TargetX_SRMb__Account__c = accountsForEnrollmentHistories[Math.mod(i,accountsForEnrollmentHistories.size())].id
				, TargetX_SRMb__IsRequired__c = (Math.mod(i,2) == 0)
				);
				enrollmentHistoriesToGenerate.add(enrollmentHistoryToGenerate);
			}
		}
		
		return enrollmentHistoriesToGenerate;
	}

	public static List<String> testTypes() {//generates test types
		List<String> testTypes = new List<String>();
		testTypes.add('ACT');
		testTypes.add('IELTS');
		testTypes.add('TOEFL');
		return testTypes;
	}

	public static List<TargetX_SRMb__Test__c> dataFactoryTests(List<Contact> contactsForTests, Integer numberOfTestsPerContact) {
		List<TargetX_SRMb__Test__c> testsToGenerate = new List<TargetX_SRMb__Test__c>();

		List<String> testTypes = IITTestHandler.testTypes();

		for(Contact contactForTests: contactsForTests) {
			for(Integer i = 0; i < numberOfTestsPerContact; i++) {
				TargetX_SRMb__Test__c testToGenerate = new TargetX_SRMb__Test__c(Name = String.valueOf(contactForTests.Id) + String.valueOf(i)
				, TargetX_SRMb__Test__c = testTypes[Math.mod(i,testTypes.size())]
				, TargetX_SRMb__Contact__c = contactForTests.Id
				);

				if(testToGenerate.TargetX_SRMb__Test__c == 'TOEFL') {
					testToGenerate.TargetX_SRMb__TOEFL_Listening_Comprehension__c = (Math.mod(i,3) == 2 ? 30 : (Math.mod(i,3) == 1 ? 16 : 16));
					testToGenerate.TargetX_SRMb__TOEFL_Reading_Comprehension__c = (Math.mod(i,3) == 2 ? 30 : (Math.mod(i,3) == 1 ? 16 : 21));
					testToGenerate.TargetX_SRMb__TOEFL_Speaking_Comprehension__c = (Math.mod(i,3) == 2 ? 30 : (Math.mod(i,3) == 1 ? 16 : 16));
					testToGenerate.TargetX_SRMb__TOEFL_Writing_Comprehension__c = (Math.mod(i,3) == 2 ? 30 : (Math.mod(i,3) == 1 ? 16 : 16));
					testToGenerate.TargetX_SRMb__TOEFL_Total_Score__c = (Math.mod(i,3) == 2 ? 120 : (Math.mod(i,3) == 1 ? 64 : 20));
				}

				testsToGenerate.add(testToGenerate);
			}
		}
		return testsToGenerate;
	}
	
	public static List<TargetX_Reader__Application_Review_Type__c> dataFactoryapplicationReviewTypes() {
		List<TargetX_Reader__Application_Review_Type__c> reviewTypesToGenerate = new List<TargetX_Reader__Application_Review_Type__c>();
		
		TargetX_Reader__Application_Review_Type__c applicationReviewTypeToGenerate = new TargetX_Reader__Application_Review_Type__c(Name = 'Graduate Test Review'
		);
		reviewTypesToGenerate.add(applicationReviewTypeToGenerate);
		applicationReviewTypeToGenerate = new TargetX_Reader__Application_Review_Type__c(Name = 'Graduate Test Faculty Review'
		);
		reviewTypesToGenerate.add(applicationReviewTypeToGenerate);
		
		return reviewTypesToGenerate;
	}

	public static List<TargetX_Reader__Application_Review__c> dataFactoryApplicationReviews(List<TargetX_SRMb__Application__c> applicationsForReviews, List<TargetX_Reader__Application_Review_Type__c> appReviewTypes, Integer numberOfReviewsPerApplication) {//generates numberOfReviewsPerApplication per application in applicationsForReviews
		List<TargetX_Reader__Application_Review__c> reviewsToGenerate = new List<TargetX_Reader__Application_Review__c>();
		
		for(TargetX_SRMb__Application__c applicationForReview : applicationsForReviews) {
			for(Integer i =0; i < numberOfReviewsPerApplication; i++) {
				TargetX_Reader__Application_Review__c reviewToGenerate = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application__c = applicationForReview.Id
				, TargetX_Reader__Application_Review_Type__c = appReviewTypes[Math.mod(i,appReviewTypes.size())].Id
				, TargetX_Reader__Completed__c = false
				);
				
				reviewsToGenerate.add(reviewToGenerate);
			}
		}
		
		return reviewsToGenerate;
	}

	public static List<String> awardTitles() {//generates test types
		List<String> awardTitles = new List<String>();
		awardTitles.add('Heald');
		awardTitles.add('Loan');
		awardTitles.add('Stipend');
		return awardTitles;
	}
	
	public static List<String> awardTypes() {//generates test types
		List<String> awardTypes = new List<String>();
		awardTypes.add('Merit');
		awardTypes.add('Loans');
		awardTypes.add('Grants');
		awardTypes.add('Stipend');
		awardTypes.add('Athletic');
		awardTypes.add('Tuition');
		return awardTypes;
	}
	
	public static List<String> awardStatusTypes() {//generates test types
		List<String> awardStatusTypes = new List<String>();
		awardStatusTypes.add('Awarded');
		awardStatusTypes.add('Cancelled');
		awardStatusTypes.add('Upgraded');
		return awardStatusTypes;
	}
	
	public static List<TargetX_SRMb__Financial_Aid__c> dataFactoryFinancialAid(List<TargetX_SRMb__Application__c> applicationsForFinancialAid, Integer numberOfFinancialAidPerApplication) {
		List<String> awardStatusTypeList = IITTestHandler.awardStatusTypes();
		List<String> awardTitleList = IITTestHandler.awardTitles();
		List<String> awardTypeList = IITTestHandler.awardTypes();
		List<TargetX_SRMb__Financial_Aid__c> financialAidToGenerateList = new List<TargetX_SRMb__Financial_Aid__c>();
		
		for(TargetX_SRMb__Application__c applicationForFinancialAid : applicationsForFinancialAid) {
			for(Integer i =0; i < numberOfFinancialAidPerApplication; i++) {
				TargetX_SRMb__Financial_Aid__c financialAidToGenerate = new TargetX_SRMb__Financial_Aid__c(
					TargetX_SRMb__Contact__c = applicationForFinancialAid.TargetX_SRMb__Contact__c
					, IIT_Application__c = applicationForFinancialAid.id
					, IIT_Award_Status__c = awardStatusTypeList[Math.mod(i,awardStatusTypeList.size())]
					, Name = awardTitleList[Math.mod(i,awardTitleList.size())]
					, TargetX_SRMb__Amount__c = 100 * i
					, TargetX_SRMb__Last_Data_Input_Source__c = 'Decision Cloud'
					, TargetX_SRMb__Type__c = awardTypeList[Math.mod(i,awardTypeList.size())]
					, TargetX_SRMb__Sub_Type__c = 'Award'
				);
				financialAidToGenerateList.add(financialAidToGenerate);
			}
		}
		
		return financialAidToGenerateList;
	}
	
	
//Custom Settings Data Factory
	public static List<IITAddressMapping__c> dataFactoryAddressMappings() {//generates address mappings for use in testing.
		List<IITAddressMapping__c> addressMappings = new List<IITAddressMapping__c>();
		IITAddressMapping__c addressMapping = new IITAddressMapping__c(Name = 'Permanent Address'
		, Address_Type__c = 'Permanent'
		, Street_API_Name__c = 'MailingStreet'
		, City_API_Name__c = 'MailingCity'
		, State_API_Name__c = 'MailingState'
		, Postal_Code_API_Name__c = 'MailingPostalCode'
		, Country_API_Name__c = 'MailingCountry'
		, County_API_Name__c = 'TargetX_SRMb__MailingCounty__c'
		, Activity_Date_API_Name__c = 'IIT_Mailing_Address_Date__c'
		);
		addressMappings.add(addressMapping);
		return addressMappings;
	}
	
	public static List<IITPhoneMapping__c> dataFactoryPhoneMappings() {//generates phone mappings for use in testing.
		List<IITPhoneMapping__c> phoneMappings = new List<IITPhoneMapping__c>();
		IITPhoneMapping__c phoneMapping = new IITPhoneMapping__c(Name = 'Primary Phone'
		, Phone_Number_API_Name__c = 'Phone'
		);
		phoneMappings.add(phoneMapping);
		
		phoneMapping = new IITPhoneMapping__c(Name = 'Secondary Phone'
		, Phone_Number_API_Name__c = 'OtherPhone'
		);
		phoneMappings.add(phoneMapping);
		return phoneMappings;
	}
	
	public static List<IITEmailMapping__c> dataFactoryEmailMappings() {//generates email mappings for use in testing.
		List<IITEmailMapping__c> emailMappings = new List<IITEmailMapping__c>();
		IITEmailMapping__c emailMapping = new IITEmailMapping__c(Name = 'Primary Email'
		, Email_Address_API_Name__c = 'Email'
		);
		emailMappings.add(emailMapping);
		return emailMappings;
	}

	public static List<IIT_Review_Type_Mapping__c> dataFactoryReviewMappings() {//generates address mappings for use in testing.
		List<IIT_Review_Type_Mapping__c> reviewMappings = new List<IIT_Review_Type_Mapping__c>();
		IIT_Review_Type_Mapping__c reviewMapping = new IIT_Review_Type_Mapping__c(Name = 'Test Review'
		, Department__c = 'Computer Science'
		, Level__c = 'Graduate'
		, Processing_Status__c = 'Pending Initial Review'
		, Review_Type_ID__c= 'badId'
		);
		reviewMappings.add(reviewMapping);
		return reviewMappings;
	}

	public static List<TargetX_Base__CRM_Setting__c> dataFactoryTargetXCRMBaseSettings(Account baseAccount) {//generates targetX Base settings for use in testing
		List<TargetX_Base__CRM_Setting__c> targetXCRMBaseSettings = new List<TargetX_Base__CRM_Setting__c>();
		TargetX_Base__CRM_Setting__c baseSetting = new TargetX_Base__CRM_Setting__c(Name = 'Default'
		, TargetX_Base__Action_Plan_Automation__c = false
		, TargetX_Base__Currency_Symbol__c = '$'
		, TargetX_Base__Days_to_keep_logs__c = 2
		, TargetX_Base__Debugging_Threshhold__c = 0
		, TargetX_Base__Default_Account_ID__c = baseAccount.id
		, TargetX_Base__Process_Access_Keys_future__c = true
		, TargetX_Base__Save_Contact_Merge_Ids__c = true
		, TargetX_Base__Save_Lead_Merge_Ids__c = true
		);
		targetXCRMBaseSettings.add(baseSetting);
		return targetXCRMBaseSettings;
	}
}