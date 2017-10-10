public without sharing class IITContactTriggerHandler extends IITTriggerHandler {//Trigger handler to handle single IIT contact trigger in all cases

	@TestVisible
	private List<Contact> newContactList; //Strongly typed contact list from Trigger.new
	@TestVisible
	private Map<Id,Contact> oldContactMap; //Strongly typed contact map from Trigger.oldMap

	public IITContactTriggerHandler() {
		this.newContactList = (List<Contact>)Trigger.new; //Strongly type the contact list in Trigger.new to Contact from SObject
		this.oldContactMap = (Map<Id,Contact>)Trigger.oldMap; //Strongly type the contact map in Trigger.oldMap to Contact from SObject
	}

	public override void beforeInsert() {
		IITContactHandler.processContactList(this.newContactList, this.oldContactMap, context); //Synchronously process before insert
	}

	public override void beforeUpdate() {
		IITContactHandler.processContactList(this.newContactList, this.oldContactMap, context); //Synchronously process before insert
	}

	public override void afterInsert() {
		IITContactHandler.processContactTrigger(this.newContactList, null, context);
	}

	public override void afterUpdate() {
		IITContactHandler.processContactTrigger(this.newContactList, this.oldContactMap, context);
	}

	public override void afterDelete() {
		IITStagingContactHandler.processContactDeletion( this.oldContactMap ); //Call Staging Contact Functionality
	}
}