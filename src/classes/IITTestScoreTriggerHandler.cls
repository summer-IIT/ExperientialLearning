public without sharing class IITTestScoreTriggerHandler extends IITTriggerHandler {//Trigger handler to handle single IIT TestScore trigger in all cases

	private List<TargetX_SRMb__Test__c> newTestList; //Strongly typed TestScore list from Trigger.new
	private Map<Id,TargetX_SRMb__Test__c> oldTestMap; //Strongly typed TestScore map from Trigger.oldMap

	public IITTestScoreTriggerHandler() {
		this.newTestList = (List<TargetX_SRMb__Test__c>)Trigger.new; //Strongly type the Test list in Trigger.new to TargetX_SRMb__Test__c from SObject
		this.oldTestMap = (Map<Id,TargetX_SRMb__Test__c>)Trigger.oldMap; //Strongly type the Test map in Trigger.oldMap to TargetX_SRMb__Test__c from SObject
	}

	public override void beforeInsert() {
		IITTestScoreHandler.processTestList(newTestList, oldTestMap, IITTriggerContext.BEFORE_INSERT); //Call before insert TestScore-specific processing
	}

	public override void beforeUpdate() {
		IITTestScoreHandler.processTestList(newTestList, oldTestMap, IITTriggerContext.BEFORE_UPDATE); //Call before update TestScore-specific processing
	}

	public override void afterInsert() {
		IITTestScoreHandler.processTestList(newTestList, oldTestMap, IITTriggerContext.AFTER_INSERT); //Call after insert TestScore-specific processing
	}

	public override void afterUpdate() {
		IITTestScoreHandler.processTestList(newTestList, oldTestMap, IITTriggerContext.AFTER_UPDATE); //Call after update TestScore-specific processing
	}
}