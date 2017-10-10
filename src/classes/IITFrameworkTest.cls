@isTest
public without sharing class IITFrameworkTest{
	@isTest
	public static void testDynamicApex() {
		//Get all of the fields for Contacts, cache this later
		Map<String,Schema.SobjectField> contactFields = Schema.SobjectType.Contact.fields.getMap(); 
		IITDynamicApexHandler.checkDynamicField(contactFields.get('Email'));
		IITDynamicApexHandler.checkDynamicField(contactFields.get('zzNeverValidzz'));
		
		// Select the ID for the standard user profile then create a test user with the selected ID
		// and other user fields populated 
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
			
		// Test the dynamic apex handler as the created test user
		System.runAs(userTest) {
			IITDynamicApexHandler.checkDynamicField(contactFields.get('MergedRecordId'));
		}
	}
	
	@isTest
	public static void testExceptionHandler() {
		IITExceptionHandler.sendEmailInTest = true;
		try{
			throw new IITGenericException('IIT Test Handler Exception.');
		} catch(Exception exceptionCaught) {
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
		}
		IITExceptionHandler.sendEmailInTest = false;
	}
	
	@isTest
	public static void testBatchReplace() {
		// Test the IITBatchReplace class
		List<Account> accountsToTest = DataFactoryAccount.createAccountsList(5);
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
}