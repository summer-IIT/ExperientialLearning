@isTest
public without sharing class IITEventTest {
	@isTest
	public static void testEvent() {
		List<TargetX_Eventsb__OrgEvent__c> eventsToUpsert = new List<TargetX_Eventsb__OrgEvent__c>();
		
		TargetX_Eventsb__OrgEvent__c eventToUpsert = new TargetX_Eventsb__OrgEvent__c();
		eventToUpsert.Name = 'Test1';
		eventToUpsert.TargetX_Eventsb__Time_Zone__c = 'America/New_York';
		eventToUpsert.TargetX_Eventsb__Start_Date_Time__c = system.today();
		eventToUpsert.TargetX_Eventsb__End_Date_Time__c = system.today().addDays(1);
		eventToUpsert.TargetX_Eventsb__Event_Cost__c = 0.00;
		eventToUpsert.TargetX_Eventsb__Start_Date_Time__c = system.now();
		eventToUpsert.IIT_Real_Start_Minutes__c = 14;
		eventToUpsert.TargetX_Eventsb__End_Date_Time__c = system.now();
		eventToUpsert.IIT_Real_End_Minutes__c = 14;
		eventsToUpsert.add(eventToUpsert);
		
		eventToUpsert.IIT_Inquiry_Card__c = 'Garbage';

		insert eventsToUpsert;
		update eventsToUpsert;
	}
}