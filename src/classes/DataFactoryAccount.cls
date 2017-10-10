@isTest
public without sharing class DataFactoryAccount {
	public static Account createAccount() {
		Account account = createAccountsList(1)[0];
		
		return account;
	}
	
    public static List<Account> createAccountsList(Integer numberOfAccounts) {
        // Generates numberOfAccounts accounts for use in testing
        List<Account> accounts = new List<Account>(); //Initialize list of accounts to generate;

        // Ceeb code generation does not properly handle generating 999999 (6 digits) accounts
        System.assert(String.valueof(numberOfAccounts).length() < 7);

        for(Integer i = 0; i < numberOfAccounts; i++) {//Iterate through number of accounts to generate
            
            /* Creates a valid 6 digit CEEB code for use in the account object
            First, pad the left side of the ceeb code with zeroes equal to the difference between 
            the number of total digits and the number of digits in our outer loop index
            then append the current outer loop index to the string */
            Integer NUM_CEEB_CODE_DIGITS = 6;
            String ceeb_code = '';
            for(Integer j = 0; j < NUM_CEEB_CODE_DIGITS - String.valueof(i).length(); j++) {
                ceeb_code += '0';
            }
            ceeb_code += String.valueof(i);

            Account accountToGenerate = new Account(Name = 'Test Account' + String.valueof(i)
            , TargetX_SRMb__ceeb_code__c = ceeb_code
            );
            accounts.add(accountToGenerate);
        }

        return accounts;
    }
    
    public static List<Account> createAndInsertAccounts(Integer numberOfAccounts) {
    	// convenience method that wraps various test methods
    	// creates a list of accounts and inserts them into the database
    	List<Account> accounts = DataFactoryAccount.createAccountsList(numberOfAccounts);
    	Database.SaveResult[] results = Database.insert(accounts);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(results);
		
		return accounts;
    }
}