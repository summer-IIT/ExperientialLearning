public without sharing class IITContactJobProcessList implements Queueable { //Processes any job update for contact lists

    private List<Contact> contactsToProcess {set; get;} //List of contacts to manipulate
    private Map<id, Contact> contactsMapForReconciliation {set; get;} //List of contacts to manipulate
    private IITTriggerContext triggerContext {set; get;} //Determines the event for processing handling
    
    public IITContactJobProcessList(List<Contact> contactsToProcess_i, Map<id,Contact> contactsMapForReconciliation_i, IITTriggerContext triggerContext_i) { //class constructor
        this.contactsToProcess = contactsToProcess_i;
        this.contactsMapForReconciliation = contactsMapForReconciliation_i;
        this.triggerContext = triggerContext_i;
    }

    public void execute(QueueableContext context) {//Enqueued job to process attachments map
        if(triggerContext == IITTriggerContext.AFTER_INSERT
        || triggerContext == IITTriggerContext.AFTER_UPDATE
        ) { //Check for update or insert
            IITContactHandler.processContactList(contactsToProcess, contactsMapForReconciliation, triggerContext);
        }
    }
}