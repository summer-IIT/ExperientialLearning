@isTest
public without sharing class IITPhoneHandlerTests {
	@isTest
	public static void conductPhoneContactTesting() {//Conducts testing on contact triggers
		Integer numberOfContactsToTest = 10; //Specify the number of contacts to test.
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
	//Phone Mappings
		List<IITPhoneMapping__c> phoneMappings = IITPhoneHandlerTests.dataFactoryPhoneMappings(); //Get the phone mappings we have defined
		System.assert(phoneMappings.size() > 0); //Validate that we retrieved at least one record

		saveResults = Database.insert(phoneMappings, false); //save programs first so we can use them
		IITTestHandler.checkSaveResults(saveResults); //Validate the results

	//Contacts
		List<Contact> contactsToTest = IITTestHandler.dataFactoryContacts(numberOfContactsToTest);
		System.assert(contactsToTest.size() == numberOfContactsToTest); //Validate that we retrieved numberOfContactsToTest records
		
		saveResults = Database.Insert(contactsToTest, false);
		System.assert(saveResults.size() == numberOfContactsToTest);//Validate that numberOfContactsToTest operations were performed
		IITTestHandler.checkSaveResults(saveResults); //Validate the save results

		//Update modifications
		for(Integer i = 0; i < numberOfContactsToTest; i++) {			
			//Change contact phone data
			if(Math.mod(i,3) < 2) {
				contactsToTest[i].Phone = (Math.mod(i,2) == 0 ? null : '5555559999');
				contactsToTest[i].OtherPhone = (Math.mod(i,2) == 0 ? null : '5555559998');			}
		}
		
		saveResults = Database.Update(contactsToTest, false);
		IITTestHandler.checkSaveResults(saveResults); //Validate the save results
		
		//run delete triggers
		Database.DeleteResult[] deleteResults = Database.Delete(contactsToTest, false);
		IITTestHandler.checkDeleteResults(deleteResults);
	}

	public static List<IITPhoneMapping__c> dataFactoryPhoneMappings() {//generates phone mappings for use in testing.
		List<IITPhoneMapping__c> phoneMappings = new List<IITPhoneMapping__c>();
		IITPhoneMapping__c phoneMapping = new IITPhoneMapping__c(Name = 'Primary Phone'
		, Phone_Number_API_Name__c = 'Phone'
		, Activity_Date_API_Name__c = 'IIT_Phone_Activity_Date__c'
		);
		phoneMappings.add(phoneMapping);
		
		phoneMapping = new IITPhoneMapping__c(Name = 'Secondary Phone'
		, Phone_Number_API_Name__c = 'OtherPhone'
		, Activity_Date_API_Name__c = 'IIT_Other_Phone_Activity_Date__c'
		);
        
		phoneMapping = new IITPhoneMapping__c(Name = 'Error Phone 1'
		, Phone_Number_API_Name__c = 'NoPhone'
		, Activity_Date_API_Name__c = 'IIT_Other_Phone_Activity_Date__c'
		);
        
		phoneMapping = new IITPhoneMapping__c(Name = 'Error Phone 2'
		, Phone_Number_API_Name__c = 'MobilePhone'
		, Activity_Date_API_Name__c = 'IIT_Throw_An_Error__c'
		);
		phoneMappings.add(phoneMapping);
		return phoneMappings;
	}
}