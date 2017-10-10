@isTest
public without sharing class IITExtraCurricularActivityTest {
	@isTest
	public static void testExtraCurricularActivityHandler() {
		// Create objects and test the handler operating on the extra curricular activity object
		final Integer NUM_CONTACTS = 5;
		final Integer NUM_APPLICATIONS = 5;
		final Integer NUM_ACTIVITIES_PER_APP = 2;
		
		// Create program objects and insert into database for later use
		List<IIT_Program__c> programList = DataFactoryPrograms.createAndInsertPrograms();
		
		// Create contact objects and insert into database for later use
		List<Contact> contacts = DataFactoryContact.createAndInsertContacts(NUM_CONTACTS);
		
		// Create applications associated with contacts and insert into database
		List<TargetX_SRMb__Application__c> applications = DataFactoryApplication.createAndInsertApplicationsWithContact(contacts, NUM_APPLICATIONS);
		
		// Create extra curricular activities associated with applications and insert into database
		List<TargetX_SRMb__Extra_Curricular_Activity__c> activities = DataFactoryExtraCurricularActivity.createAndInsertExtraCurricularActivitiesWithApplication(applications, NUM_ACTIVITIES_PER_APP);
		
		// Link applications in order to test the cloning of extra curricular activities
		DataFactoryApplication.linkApplicationsForClone(applications);
		
		IITExtraCurricularActivityHandler.copyExtraCurricularsForApplication(applications, new Map<id, id>());
		
		IITExtraCurricularActivityHandler.performUpdate(activities);
	}
}