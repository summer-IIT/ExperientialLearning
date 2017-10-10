@isTest
public without sharing class DataFactoryFinancialAid {
	public static TargetX_SRMb__Financial_Aid__c createFinancialAid() {
		// create a single financial aid object
		String awardTitle = DataFactoryAwardTitles.createAwardTitle();
		String awardType = DataFactoryAwardTypes.createAwardType();
		String awardStatusType = DataFactoryAwardStatusTypes.createAwardStatusType();
		
		TargetX_SRMb__Financial_Aid__c financialAid = new TargetX_SRMb__Financial_Aid__c(
			Name = awardTitle,
			IIT_Award_Status__c = awardStatusType,
			TargetX_SRMb__Amount__c = 100,
			TargetX_SRMb__Last_Data_Input_Source__c = 'Decision Cloud',
			TargetX_SRMb__Type__c = awardType,
			TargetX_SRMb__Sub_Type__c = 'Award'
		);
		
		return financialAid;
	}
	
	public static List<TargetX_SRMb__Financial_Aid__c> createFinancialAidList(Integer numberOfFinancialAid) {
		// create a list of financial aid objects
		List<String> awardTitles = DataFactoryAwardTitles.createAwardTitlesList();
		List<String> awardTypes = DataFactoryAwardTypes.createAwardTypesList();
		List<String> awardStatusTypes = DataFactoryAwardStatusTypes.createAwardStatusTypesList();
		
		List<TargetX_SRMb__Financial_Aid__c> financialAids = new List<TargetX_SRMb__Financial_Aid__c>();
		
		for(Integer i = 0; i < numberOfFinancialAid; i++) {
			TargetX_SRMb__Financial_Aid__c financialAid = new TargetX_SRMb__Financial_Aid__c(
				Name = awardTitles[math.mod(i, awardTitles.size())],
				IIT_Award_Status__c = awardStatusTypes[math.mod(i, awardStatusTypes.size())],
				TargetX_SRMb__Amount__c = 100 * i,
				TargetX_SRMb__Last_Data_Input_Source__c = 'Decision Cloud',
				TargetX_SRMb__Type__c = awardTypes[math.mod(i, awardTypes.size())],
				TargetX_SRMb__Sub_Type__c = 'Award'
			);
			
			financialAids.add(financialAid);
		}
		
		return financialAids;
	}
	
	public static void addApplicationToFinancialAid(TargetX_SRMb__Application__c application, TargetX_SRMb__Financial_Aid__c financialAid) {
		// add an application and contact id to a financial aid object
		
		// check that the application has an id and contact
		system.assert(application.id != null && application.TargetX_SRMb__Contact__c != null);
		
		financialAid.IIT_Application__c = application.id;
		financialAid.TargetX_SRMb__Contact__c = application.TargetX_SRMb__Contact__c;
	}
	
	public static void addApplicationListToFinancialAidList(List<TargetX_SRMb__Application__c> applications, List<TargetX_SRMb__Financial_Aid__c> financialAids) {
		// add application and contact ids from a list of applications to a list of financial aid objects
		
		// check that each application has an id and contact and that the size of each list is the same
		for(TargetX_SRMb__Application__c a : applications) {
			system.assert(a.id != null && a.TargetX_SRMb__Contact__c != null);
		}
		system.assert(applications.size() == financialAids.size());
		
		for(Integer i = 0; i < applications.size(); i++) { 
			financialAids[i].IIT_Application__c = applications[i].id;
			financialAids[i].TargetX_SRMb__Contact__c = applications[i].TargetX_SRMb__Contact__c;
		}
	}
	
	public static List<TargetX_SRMb__Financial_Aid__c> createAndInsertFinancialAidWithApplications(List<TargetX_SRMb__Application__c> applications, Integer aidPerApp) {
		// convenience method that uses various test methods to create a list of financial aid objects and insert them into the database
		List<TargetX_SRMb__Financial_Aid__c> totalFinancialAids = new List<TargetX_SRMb__Financial_Aid__c>();
		
		for(Integer i = 0; i < aidPerApp; i++) {
			List<TargetX_SRMb__Financial_Aid__c> financialAids = DataFactoryFinancialAid.createFinancialAidList(applications.size());
			DataFactoryFinancialAid.addApplicationListToFinancialAidList(applications, financialAids);
			
			totalFinancialAids.addAll(financialAids);
		}
		
		Database.SaveResult[] results = Database.insert(totalFinancialAids, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(results);
		
		return totalFinancialAids;
	}
}