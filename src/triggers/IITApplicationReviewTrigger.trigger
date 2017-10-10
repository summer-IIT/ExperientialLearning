trigger IITApplicationReviewTrigger on TargetX_Reader__Application_Review__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	new IITApplicationreviewTriggerHandler().run();
}