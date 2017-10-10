trigger IITTestScoreTrigger on TargetX_SRMb__Test__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	new IITTestScoreTriggerHandler().run();
}