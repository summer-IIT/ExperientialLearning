trigger IITAccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
	new IITAccountTriggerHandler().run();
}