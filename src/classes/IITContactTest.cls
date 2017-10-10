@isTest
public without sharing class IITContactTest {
	@isTest
	public static void testContactTriggers() {
		// test originally from IITTestHandler with minor modifications made
		final Integer NUM_CONTACTS = 10;
		
		List<Contact> contacts = DataFactoryContact.createContactsWithProgramStageYearTermList(NUM_CONTACTS);
		
		// create and insert test programs
		List<IIT_Program__c> programs = IITContactTest.createAndInsertPrograms();
		
		// create and insert mappings objects
		IITContactTest.createAndInsertObjectMappings();
		
		// insert contact test records
		Database.SaveResult[] saveContactsResult = Database.insert(contacts, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveContactsResult);
		
		// TODO: code related to database update here
		IITContactTest.changeContactRecruitmentPathData(contacts, programs);
		
		saveContactsResult = Database.update(contacts, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveContactsResult);

		Database.DeleteResult[] deleteContactsResult = Database.delete(contacts, false);
		IITDatabaseTestTools.checkSuccessfulDeleteResultList(deleteContactsResult);
	}
	
	public static List<IIT_Program__c> createAndInsertPrograms() {
		List<IIT_Program__c> programs = DataFactoryPrograms.createPrograms();
		Database.SaveResult[] saveProgramResult = Database.insert(programs, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveProgramResult);
		
		return programs;
	}
	
	public static void createAndInsertObjectMappings() {
		// creates mapping objects and inserts them into the database so that various contact triggers can find data
		Database.SaveResult saveMappingResult;
		saveMappingResult = Database.insert(DataFactoryAddressMapping.createAddressMapping(), false);
		IITDatabaseTestTools.checkForSuccessfulSaveResult(saveMappingResult);
		saveMappingResult = Database.insert(DataFactoryPhoneMapping.createPrimaryPhoneMapping(), false);
		IITDatabaseTestTools.checkForSuccessfulSaveResult(saveMappingResult);
		saveMappingResult = Database.insert(DataFactoryPhoneMapping.createSecondaryPhoneMapping(), false);
		IITDatabaseTestTools.checkForSuccessfulSaveResult(saveMappingResult);
		saveMappingResult = Database.insert(DataFactoryEmailMapping.createEmailMapping(), false);
		IITDatabaseTestTools.checkForSuccessfulSaveResult(saveMappingResult);
	}
	
	public static void changeContactRecruitmentPathData(List<Contact> contacts, List<IIT_Program__c> programList) {
		//Update modification		
		List<String> contactStages = DataFactoryContactStages.createContactStages();
		
		for(Integer i = 0; i < contacts.size(); i++) {
			//Change recruitment path data
			if( Math.mod(i, programList.size() * 2) == 0 ) {
				contacts[i].TargetX_SRMb__Degree__c = (Math.mod(i,3) == 0 ? null : 'Bachelor of Science');
				contacts[i].TargetX_SRMb__Anticipated_Major__c = (Math.mod(i,3) == 0 ? null : 'Applied Analytics');
				contacts[i].TargetX_SRMb__Stage_Date__c = (Math.mod(i,2) == 0 ? system.today() : null);
				contacts[i].TargetX_SRMb__Status__c = (Math.mod(i,contactStages.size() + 1) == 0 ? null : contactStages[Math.mod(i,contactStages.size() + 1) - 1]);
				contacts[i].TargetX_SRMb__Anticipated_Start_Year__c = (Math.mod(i,3) == 0 ? null : 2015);
				contacts[i].TargetX_SRMb__Anticipated_Start_Term__c = (Math.mod(i,3) == 0 ? null : 'Fall');
			}
			
			//Change contact data
			if(Math.mod(i, 3) < 2) {
				contacts[i].Phone = (Math.mod(i,2) == 0 ? null : '5555559999');
				contacts[i].OtherPhone = (Math.mod(i,2) == 0 ? null : '5555559998');
				contacts[i].Email = (Math.mod(i,2) == 0 ? null : 'IITTest' + String.valueof(i + 1) + '@iit.fake');
				contacts[i].MailingStreet = (Math.mod(i,2) == 0 ? null : 'Street' + String.valueof(i + 1));
				contacts[i].MailingCity = (Math.mod(i,2) == 0 ? null : 'Kalamazoo' + String.valueof(i + 1));
				contacts[i].MailingState = (Math.mod(i,2) == 0 ? null : 'IL' + String.valueof(i + 1));
				contacts[i].MailingPostalCode = (Math.mod(i,2) == 0 ? null : '60' + String.valueof(i + 1));
				contacts[i].MailingCountry = (Math.mod(i,2) == 0 ? null : 'Naboo' + String.valueof(i + 1));
			}
		}
	}
}