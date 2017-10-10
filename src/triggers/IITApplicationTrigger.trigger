trigger IITApplicationTrigger on TargetX_SRMb__Application__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	new IITApplicationTriggerHandler().run();
}