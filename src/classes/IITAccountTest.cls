@isTest
public without sharing class IITAccountTest {
	@isTest
	public static void testAccountObject() {
		// test originally from IITTestHandler with small modifications
		final integer NUM_ACCOUNTS = 5;
		
		List<Account> accounts = DataFactoryAccount.createAccountsList(NUM_ACCOUNTS);
		
		Database.SaveResult[] saveAccountResults = Database.insert(accounts, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveAccountResults);
		
		saveAccountResults = Database.update(accounts, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveAccountResults);
		
		Database.DeleteResult[] deleteAccountResults = Database.delete(accounts, false);
		IITDatabaseTestTools.checkSuccessfulDeleteResultList(deleteAccountResults);
		
		Database.UndeleteResult[] undeleteResults = Database.undelete(accounts, false);
	}
}