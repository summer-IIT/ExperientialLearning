public without sharing class IITApplicationTriggerHandler extends IITTriggerHandler {//Trigger handler to handle single IIT application trigger in all cases

	private List<TargetX_SRMb__Application__c> newApplicationList; //Strongly typed application list from Trigger.new
	private Map<Id,TargetX_SRMb__Application__c> oldApplicationMap; //Strongly typed application map from Trigger.oldMap

	public IITApplicationTriggerHandler() {
		this.newApplicationList = (List<TargetX_SRMb__Application__c>)Trigger.new; //Strongly type the application list in Trigger.new to TargetX_SRMb__Application__c from SObject
		this.oldApplicationMap = (Map<Id,TargetX_SRMb__Application__c>)Trigger.oldMap; //Strongly type the application map in Trigger.oldMap to TargetX_SRMb__Application__c from SObject
	}

	public override void beforeInsert() {
		IITProgramHandler.processProgramsForApplications(newApplicationList, oldApplicationMap); //Iterates through applications and validates their programs
		IITApplicationHandler.processApplicationList(newApplicationList, oldApplicationMap, IITTriggerContext.BEFORE_INSERT); //Call before insert application-specific processing
	}

	public override void beforeUpdate() {
		IITProgramHandler.processProgramsForApplications(newApplicationList, oldApplicationMap); //Iterates through applications and validates their programs
		IITApplicationHandler.processApplicationList(newApplicationList, oldApplicationMap, IITTriggerContext.BEFORE_UPDATE); //Call before update application-specific processing
	}

	public override void afterInsert() {
		IITApplicationHandler.processApplicationList(newApplicationList, oldApplicationMap, IITTriggerContext.AFTER_INSERT); //Call after insert application-specific processing
	}

	public override void afterUpdate() {
		IITApplicationHandler.processApplicationList(newApplicationList, oldApplicationMap, IITTriggerContext.AFTER_UPDATE); //Call after update application-specific processing
	}

}