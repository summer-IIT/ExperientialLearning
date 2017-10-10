trigger IITAttachmentTrigger on Attachment (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	new IITAttachmentTriggerHandler().run();
}