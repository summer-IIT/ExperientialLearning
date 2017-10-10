public without sharing class IITAttachmentTriggerHandler extends IITTriggerHandler {//Trigger handler to handle single IIT attachment trigger in all cases

	private List<Attachment> newAttachmentList; //Strongly typed attachment list from Trigger.new
	private Map<Id,Attachment> oldAttachmentMap; //Strongly typed attachment map from Trigger.oldMap

	public IITAttachmentTriggerHandler() {
		this.newAttachmentList = (List<Attachment>)Trigger.new; //Strongly type the attachment list in Trigger.new to Attachment from SObject
		this.oldAttachmentMap = (Map<Id,Attachment>)Trigger.oldMap; //Strongly type the attachment map in Trigger.oldMap to Attachment from SObject
	}

	public override void beforeInsert() {
		IITAttachmentHandler.processAttachmentTrigger(newAttachmentList, oldAttachmentMap, IITTriggerContext.BEFORE_INSERT); //Call attachment processing functionality
	}

	public override void afterInsert() {
		IITAttachmentHandler.processAttachmentTrigger(newAttachmentList, oldAttachmentMap, IITTriggerContext.AFTER_INSERT); //Call attachment processing functionality
	}

	public override void afterDelete() {
		IITAttachmentHandler.processAttachmentTrigger(newAttachmentList, oldAttachmentMap, IITTriggerContext.AFTER_DELETE); //Call attachment processing functionality
	}

}