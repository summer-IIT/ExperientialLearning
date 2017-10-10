@isTest
public without sharing class DataFactoryExtraCurricularActivity {
	public static TargetX_SRMb__Extra_Curricular_Activity__c createExtraCurricularActivity() {
		// creates a single extra curricular activity object
		TargetX_SRMb__Extra_Curricular_Activity__c activity = new TargetX_SRMb__Extra_Curricular_Activity__c(
			Name = 'Test Extra Curricular Activity'
		);
		
		return activity;
	}
	
	public static List<TargetX_SRMb__Extra_Curricular_Activity__c> createExtraCurricularActivitiesList(Integer numberOfActivities) {
		// creates a list of extra curricular activity objects
		List<TargetX_SRMb__Extra_Curricular_Activity__c> activities = new List<TargetX_SRMb__Extra_Curricular_Activity__c>();
		
		for(Integer i = 0; i < numberOfActivities; i++) {
			TargetX_SRMb__Extra_Curricular_Activity__c activity = new TargetX_SRMb__Extra_Curricular_Activity__c(
				Name = 'Test Extra Curricular Activity ' + String.valueof(i)
			);
			
			activities.add(activity);
		}
		
		return activities;
	}
	
	public static void addApplicationToExtraCurricularActivity(TargetX_SRMb__Application__c application, TargetX_SRMb__Extra_Curricular_Activity__c activity) {
		// adds an application and contact id to an existing extra curricular activity
		
		// check that the application has an id as well as a contact
		system.assert(application.id != null && application.TargetX_SRMb__Contact__c != null);
		
		activity.TargetX_SRMb__Application__c = application.id;
		activity.TargetX_SRMb__Contact__c = application.TargetX_SRMb__Contact__c;
	}
	
	public static void addApplicationListToExtraCurricularActivitiesList(List<TargetX_SRMb__Application__c> applications, List<TargetX_SRMb__Extra_Curricular_Activity__c> activities) {
		// adds application and contact ids from a list of applications to each extra curricular activity in a list
		
		// check that each application has an id and contact and that the size of each list is the same
		for(TargetX_SRMb__Application__c a : applications) {
			system.assert(a.id != null && a.TargetX_SRMb__Contact__c != null);
		}
		system.assert(applications.size() == activities.size());
		
		for(Integer i = 0; i < applications.size(); i++) {
			activities[i].TargetX_SRMb__Application__c = applications[i].id;
			activities[i].TargetX_SRMb__Contact__c = applications[i].TargetX_SRMb__Contact__c;
		}
	}
	
	public static List<TargetX_SRMb__Extra_Curricular_Activity__c> createAndInsertExtraCurricularActivitiesWithApplication(List<TargetX_SRMb__Application__c> applications, Integer numberOfActivitiesPerApp) {
		// convenience method that combines various test methods in order to create a list of extra curricular activity objects, associate applications with each, and insert into the database
		List<TargetX_SRMb__Extra_Curricular_Activity__c> totalActivities = new List<TargetX_SRMb__Extra_Curricular_Activity__c>();
		
		for(Integer i = 0; i < numberOfActivitiesPerApp; i++); {
			List<TargetX_SRMb__Extra_Curricular_Activity__c> activities = DataFactoryExtraCurricularActivity.createExtraCurricularActivitiesList(applications.size());
			DataFactoryExtraCurricularActivity.addApplicationListToExtraCurricularActivitiesList(applications, activities);
			
			totalActivities.addAll(activities);
		}
		
		Database.SaveResult[] results = Database.insert(totalActivities, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(results);
		
		return totalActivities;
	}
}