public without sharing class IITApplicationReviewTriggerHandler extends IITTriggerHandler {//Trigger handler to handle single IIT application trigger in all cases

	private List<TargetX_Reader__Application_Review__c> newApplicationReviewList; //Strongly typed application review list from Trigger.new
	private Map<Id,TargetX_Reader__Application_Review__c> oldApplicationReviewMap; //Strongly typed application review map from Trigger.oldMap

	public IITApplicationReviewTriggerHandler() {
		this.newApplicationReviewList = (List<TargetX_Reader__Application_Review__c>)Trigger.new; //Strongly type the application review list in Trigger.new to TargetX_SRMb__Application__c from SObject
		this.oldApplicationReviewMap = (Map<Id,TargetX_Reader__Application_Review__c>)Trigger.oldMap; //Strongly type the application review map in Trigger.oldMap to TargetX_SRMb__Application__c from SObject
	}

	public override void beforeInsert() {
		IITApplicationReviewHandler.processApplicationReviewList(newApplicationReviewList, oldApplicationReviewMap, IITTriggerContext.BEFORE_INSERT); //Call before insert application review-specific processing
	}

	public override void beforeUpdate() {
		IITApplicationReviewHandler.processApplicationReviewList(newApplicationReviewList, oldApplicationReviewMap, IITTriggerContext.BEFORE_UPDATE); //Call before update application review-specific processing
	}

	public override void afterInsert() {
		IITApplicationReviewHandler.processApplicationReviewList(newApplicationReviewList, oldApplicationReviewMap, IITTriggerContext.AFTER_INSERT); //Call after insert application review-specific processing
	}

	public override void afterUpdate() {
		IITApplicationReviewHandler.processApplicationReviewList(newApplicationReviewList, oldApplicationReviewMap, IITTriggerContext.AFTER_UPDATE); //Call after update application review-specific processing
	}

}