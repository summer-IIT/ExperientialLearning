@isTest
public without sharing class DataFactoryEnrollmentHistory {
	public static TargetX_SRMb__Enrollment_History__c createEnrollmentHistory() {
		// create a single enrollment history object
		TargetX_SRMb__Enrollment_History__c enrollmentHistory = new TargetX_SRMb__Enrollment_History__c(
			Name = 'Test Enrollment History',
			TargetX_SRMb__IsRequired__c = true
		);
		
		return enrollmentHistory;
	}
	
	public static List<TargetX_SRMb__Enrollment_History__c> createEnrollmentHistoriesList(Integer numberOfHistories) {
		// create a list of enrollment history objects
		List<TargetX_SRMb__Enrollment_History__c> enrollmentHistories = new List<TargetX_SRMb__Enrollment_History__c>();
		
		for(Integer i = 0; i < numberOfHistories; i++) {
			TargetX_SRMb__Enrollment_History__c enrollmentHistory = new TargetX_SRMb__Enrollment_History__c(
				Name = 'Teste Enrollment History ' + String.valueof(i),
				TargetX_SRMb__IsRequired__c = (Math.mod(i, 2) == 0)
			);
			
			enrollmentHistories.add(enrollmentHistory);
		}
		
		return enrollmentHistories;
	}
	
	public static void addApplicationToEnrollmentHistory(TargetX_SRMb__Application__c application, TargetX_SRMb__Enrollment_History__c enrollmentHistory) {
		// add application and contact data to an enrollment history object
		
		// check that the application has an ID as well as a contact ID
		system.assert(application.id != null && application.TargetX_SRMb__Contact__c != null);
		
		enrollmentHistory.TargetX_SRMb__Application__c = application.id;
		enrollmentHistory.TargetX_SRMb__Contact__c = application.TargetX_SRMb__Contact__c;
	}
	
	public static void addApplicationListToEnrollmentHistoriesList(List<TargetX_SRMb__Application__c> applications, List<TargetX_SRMb__Enrollment_History__c> enrollmentHistories) {
		// add application and contact data from a list of applications to enrollment history objects
		
		// check that the applications all have IDs and that the size of each list of objects is the same
		for(TargetX_SRMb__Application__c a : applications) {
			system.assert(a.id != null && a.TargetX_SRMb__Contact__c != null);
		}
		system.assert(applications.size() == enrollmentHistories.size());
		
		for(Integer i = 0; i < applications.size(); i++) {
			enrollmentHistories[i].TargetX_SRMb__Application__c = applications[i].id;
			enrollmentHistories[i].TargetX_SRMb__Contact__c = applications[i].TargetX_SRMb__Contact__c;
		}
	}
	
	public static void addAccountToEnrollmentHistory(Account account, TargetX_SRMb__Enrollment_History__c enrollmentHistory) {
		// add account data to an enrollment history object
		
		// check that the account has an ID
		system.assert(account.id != null);
		
		enrollmentHistory.TargetX_SRMb__Account__c = account.id;
	}
	
	public static void addAccountsListToEnrollmentHistoriesList(List<Account> accounts, List<TargetX_SRMb__Enrollment_History__c> enrollmentHistories) {
		// add account data from a list of accounts to enrollment history objects
		
		// check that the accounts all have IDs and the size of each list of objects is the same
		for(Account a : accounts) {
			system.assert(a.id != null);
		}
		system.assert(accounts.size() == enrollmentHistories.size());
		
		for(Integer i = 0; i < accounts.size(); i++) {
			enrollmentHistories[i].TargetX_SRMb__Account__c = accounts[i].id;
		}
	}
	
	public static List<TargetX_SRMb__Enrollment_History__c> createAndInsertEnrollmentHistoriesWithAppAndAcc(List<TargetX_SRMb__Application__c> applications, List<Account> accounts, Integer numHistoryPerApp) {
    	// convenience method that wraps various test methods
		// creates a list of enrollment histories and associates each with an account and application
		// then inserts the list into the database and returns it
		List<TargetX_SRMb__Enrollment_History__c> totalEnrollmentHistories = new List<TargetX_SRMb__Enrollment_History__c>();
		
		// create a list of enrollment history objects and associate an application and account with each for numHistoryPerApp times
		for(Integer i = 0; i < numHistoryPerApp; i++) {
			List<TargetX_SRMb__Enrollment_History__c> histories = DataFactoryEnrollmentHistory.createEnrollmentHistoriesList(applications.size());
			DataFactoryEnrollmentHistory.addApplicationListToEnrollmentHistoriesList(applications, histories);
			DataFactoryEnrollmentHistory.addAccountsListToEnrollmentHistoriesList(accounts, histories);
			
			totalEnrollmentHistories.addAll(histories);
		}
		Database.SaveResult[] results = Database.insert(totalEnrollmentHistories);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(results);
		
		return totalEnrollmentHistories;
	}
}