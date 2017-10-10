trigger IITProgramTrigger on IIT_Program__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	new IITProgramTriggerHandler().run();
}