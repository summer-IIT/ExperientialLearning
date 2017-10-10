@isTest
public without sharing class DataFactoryEssay {
	public static TargetX_SRMb__Essay__c createEssay() {
		// create a single Essay object
		String essayType = DataFactoryEssayTypes.createEssayType();
		
		TargetX_SRMb__Essay__c essay = new TargetX_SRMb__Essay__c(
			Name = 'Test Essay',
			TargetX_SRMb__Type__c = essayType,
			TargetX_SRMb__IsRequired__c = true
		);
		
		return essay;
	}
	
	public static List<TargetX_SRMb__Essay__c> createEssaysList(Integer numberOfEssays) {
		// create a list of Essay objects with numberOfEssays items
		List<String> essayTypes = DataFactoryEssayTypes.createEssayTypesList();
		List<TargetX_SRMb__Essay__c> essays = new List<TargetX_SRMb__Essay__c>();
		
		for(Integer i = 0; i < numberOfEssays; i++) {
			TargetX_SRMb__Essay__c essay = new TargetX_SRMb__Essay__c(
				Name = 'Test Essay ' + String.valueof(i),
				TargetX_SRMb__Type__c = essayTypes[Math.mod(i, essayTypes.size())],
				TargetX_SRMb__IsRequired__c = (Math.mod(i, 2) == 0)
			);
			
			essays.add(essay);
		}
		
		return essays;
	}
	
	public static void addApplicationToEssay(TargetX_SRMb__Application__c application, TargetX_SRMb__Essay__c essay) {
		// add an application ID and contact details to an essay object
		
		// check to make sure that the application contains an ID as well as a contact ID
		System.assert(application.id != null && application.TargetX_SRMb__Contact__c != null);
		
		essay.TargetX_SRMb__Application__c = application.id;
		essay.TargetX_SRMb__Contact__c = application.TargetX_SRMb__Contact__c;
	}
	
	public static void addApplicationsListToEssaysList(List<TargetX_SRMb__Application__c> applications, List<TargetX_SRMb__Essay__c> essays) {
		// add applications and contact details from a list to a list of essay objects
		
		// check to make sure that the applications all contain ID and contact IDs and that the lists of objects are the same size
		for(TargetX_SRMb__Application__c a : applications) {
			System.assert(a.id != null && a.TargetX_SRMb__Contact__c != null);
		}
		System.assert(applications.size() == essays.size());
		
		for(Integer i = 0; i < applications.size(); i++) {
			essays[i].TargetX_SRMb__Application__c = applications[i].id;
			essays[i].TargetX_SRMb__Contact__c = applications[i].TargetX_SRMb__Contact__c;
		}
	}
	
	public static List<TargetX_SRMb__Essay__c> createAndInsertEssaysWithApplicationAndContact(List<TargetX_SRMb__Application__c> applications, Integer numberOfEssaysPerApplication) {
		// creates a number of essays for each application in a list of applications and adds the application id and contact id to each essay, then inserts the essays into the database
		List<TargetX_SRMb__Essay__c> totalEssays = new List<TargetX_SRMb__Essay__c>();
		
		for(Integer i = 0; i < numberOfEssaysPerApplication; i++) {
			List<TargetX_SRMb__Essay__c> essays = DataFactoryEssay.createEssaysList(applications.size());
			DataFactoryEssay.addApplicationsListToEssaysList(applications, essays);
			
			totalEssays.addAll(essays);
		}
		
		Database.SaveResult[] saveEssaysResult = Database.insert(totalEssays, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(saveEssaysResult);
		
		return totalEssays;
	}
}