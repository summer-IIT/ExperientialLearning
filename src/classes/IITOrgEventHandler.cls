public without sharing class IITOrgEventHandler {	
//Shared Functionality	
    public static void processTimeOffsetList(List<TargetX_Eventsb__OrgEvent__c> eventsToProcess) {//Process an event insert action
		for(TargetX_Eventsb__OrgEvent__c eventToProcess : eventsToProcess) {//Iterate through the events
			IITOrgEventHandler.processTimeOffsets(eventToProcess); //Processes the time offsets for events
		}
	}
	
	public static void processTimeOffsets(TargetX_Eventsb__OrgEvent__c eventToProcess) {//Overrides minutes for start and end times.
		if(eventToProcess.IIT_Real_Start_Minutes__c != null
		&& eventToProcess.TargetX_Eventsb__Start_Date_Time__c != null
		&& eventToProcess.TargetX_Eventsb__Start_Date_Time__c.minute() != eventToProcess.IIT_Real_Start_Minutes__c
		) { //Check for start time minutes override populated, start time populated, and start time minutes not equal to start time minutes override.
			eventToProcess.TargetX_Eventsb__Start_Date_Time__c = eventToProcess.TargetX_Eventsb__Start_Date_Time__c.addMinutes(-eventToProcess.TargetX_Eventsb__Start_Date_Time__c.minute()).addMinutes( Integer.valueOf(eventToProcess.IIT_Real_Start_Minutes__c)); //Set the start minutes to the override
		}
		
		if(eventToProcess.IIT_Real_End_Minutes__c != null
		&& eventToProcess.TargetX_Eventsb__End_Date_Time__c != null
		&& eventToProcess.TargetX_Eventsb__End_Date_Time__c.minute() != eventToProcess.IIT_Real_End_Minutes__c
		) { //Check for end time minutes override populated, end time populated, and end time minutes not equal to end time minutes override.
			eventToProcess.TargetX_Eventsb__End_Date_Time__c = eventToProcess.TargetX_Eventsb__End_Date_Time__c.addMinutes(-eventToProcess.TargetX_Eventsb__End_Date_Time__c.minute()).addMinutes( Integer.valueOf(eventToProcess.IIT_Real_End_Minutes__c)); //Set the start end minutes to the override
		}
	}
}