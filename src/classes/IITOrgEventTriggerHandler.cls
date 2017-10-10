public without sharing class IITOrgEventTriggerHandler extends IITTriggerHandler {//Trigger handler to handle single IIT orgEvent trigger in all cases

	private List<TargetX_Eventsb__OrgEvent__c> newOrgEventList; //Strongly typed orgEvent list from Trigger.new
	private Map<Id,TargetX_Eventsb__OrgEvent__c> oldOrgEventMap; //Strongly typed orgEvent map from Trigger.oldMap

	public IITOrgEventTriggerHandler() {
		this.newOrgEventList = (List<TargetX_Eventsb__OrgEvent__c>)Trigger.new; //Strongly type the orgEvent list in Trigger.new to TargetX_Eventsb__OrgEvent__c from SObject
		this.oldOrgEventMap = (Map<Id,TargetX_Eventsb__OrgEvent__c>)Trigger.oldMap; //Strongly type the orgEvent map in Trigger.oldMap to TargetX_Eventsb__OrgEvent__c from SObject
	}

	public override void beforeInsert() {
		IITOrgEventHandler.processTimeOffsetList(newOrgEventList); //Event preprocessing.
	}
}