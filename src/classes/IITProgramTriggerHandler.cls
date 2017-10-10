public without sharing class IITProgramTriggerHandler extends IITTriggerHandler {//Trigger handler to handle single IIT program trigger in all cases

	private List<IIT_Program__c> newProgramList; //Strongly typed program list from Trigger.new
	private Map<Id,IIT_Program__c> oldProgramMap; //Strongly typed program map from Trigger.oldMap

	public IITProgramTriggerHandler() {
		this.newProgramList = (List<IIT_Program__c>)Trigger.new; //Strongly type the program list in Trigger.new to IIT_Program__c from SObject
		this.oldProgramMap = (Map<Id,IIT_Program__c>)Trigger.oldMap; //Strongly type the program map in Trigger.oldMap to IIT_Program__c from SObject
	}

	public override void afterInsert() {
		IITProgramHandler.refreshProgramCache(); //Refresh the programs available.
	}

	public override void afterUpdate() {
		IITProgramHandler.refreshProgramCache(); //Refresh the programs available.
	}

	public override void afterDelete() {
		IITProgramHandler.refreshProgramCache(); //Refresh the programs available.
	}

	public override void afterUndelete() {
		IITProgramHandler.refreshProgramCache(); //Refresh the programs available.
	}
}