public without sharing class IITLeadTriggerHandler extends IITTriggerHandler {//Trigger handler to handle single IIT lead trigger in all cases

	private List<Lead> newLeadList; //Strongly typed lead list from Trigger.new
	private Map<Id,Lead> oldLeadMap; //Strongly typed lead map from Trigger.oldMap

	public IITLeadTriggerHandler() {
		this.newLeadList = (List<Lead>)Trigger.new; //Strongly type the lead list in Trigger.new to Lead from SObject
		this.oldLeadMap = (Map<Id,Lead>)Trigger.oldMap; //Strongly type the lead map in Trigger.oldMap to Lead from SObject
	}

	public override void beforeInsert() {
		addressPlusLeadZipLookup.zipLookup(this.newLeadList, new Map<Id, Lead>()) ;
	}

	public override void beforeUpdate() {
		addressPlusLeadZipLookup.zipLookup(this.newLeadList, this.oldLeadMap) ;
	}
}