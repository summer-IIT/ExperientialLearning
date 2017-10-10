trigger IITOrgEventTrigger on TargetX_Eventsb__OrgEvent__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	new IITOrgEventTriggerHandler().run();
}