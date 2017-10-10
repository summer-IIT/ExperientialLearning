@isTest
public without sharing class AddressPlusAccountZipLookupTest {
	/* In order to add further coverage to this test class, some additional data must be added to the 
	database in order for SOQL statements to populate variables that lead to conditional portions of the
	addressPlusAccountZipLookup class.  */
	// TODO:  Create DataFactoryAddressPlus in order to add the needed data for proper testing of expected results
	@isTest
	public static void testSingleAccount() {
		Account account = DataFactoryAccount.createAccount();
		
		Database.SaveResult saveResult = Database.insert(account, false);
		IITDatabaseTestTools.checkForSuccessfulSaveResult(saveResult);
	}
	
	@isTest
	public static void testSingleAccountWithBillingCode() {
		Account account = DataFactoryAccount.createAccount();
		
		account.BillingPostalCode = '60613';
		Database.SaveResult saveResult = Database.insert(account, false);
		IITDatabaseTestTools.checkForSuccessfulSaveResult(saveResult);
	}
}