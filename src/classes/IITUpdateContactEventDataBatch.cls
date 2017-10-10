public class IITUpdateContactEventDataBatch implements Database.Batchable<SObject> {
    
    Private static decimal startYear;
    Private static date lastModifiedDate;
    Private static Set<string> OrgEventTypes;
    Private static Map<String, IITContactEvent__c> contactEventMappings;
    
    private static Map<String, IITContactEvent__c> getContactEventMappings() {
        if(contactEventMappings == null) {
            contactEventMappings = IITContactEvent__c.getAll();
        }
        return contactEventMappings;
    }
    
    private static void getStartYear() {
        startYear = getContactEventMappings().get('Default').IIT_Anticipated_Start_Year__c;
    }
    
    private static void getLastModifiedDate() {
        if(getContactEventMappings().get('Default').IIT_Last_Modified_Days__c != null) {
            lastModifiedDate = system.today().addDays(-getContactEventMappings().get('Default').IIT_Last_Modified_Days__c.intValue());
        } else {
            lastModifiedDate = null;
        }
        
    }
    
    private static void getOrgEventTypes() {
        OrgEventTypes = getContactEventMappings().keyset();
        OrgEventTypes.remove('Default');
    }
    
    public Database.QueryLocator start(Database.BatchableContext context) {
        getStartYear();
        getLastModifiedDate();
        
        if(lastModifiedDate == null) {
            return Database.getQueryLocator([select Id
                                             from Contact
                                             where RecordTypeId = '012j0000000xaqj'
                                             and TargetX_SRMb__Anticipated_Start_Year__c >= :startYear
                                            ]);
        } else {
            return Database.getQueryLocator([select Id
                                             from Contact
                                             where RecordTypeId = '012j0000000xaqj'
                                             and TargetX_SRMb__Anticipated_Start_Year__c >= :startYear
                                             and Id IN (select TargetX_Eventsb__Contact__c
                                                        from TargetX_Eventsb__ContactScheduleItem__c
                                                        where LastModifiedDate >= :lastModifiedDate)
                                            ]);
        }
        
    }
        
    public void execute(Database.BatchableContext context, List<Contact> scope) {
        getOrgEventTypes();
        
        Contact[] updateVisitCount = new Contact[] {};
        for (AggregateResult ar : [select TargetX_Eventsb__Contact__c cID,
                                   count(Id) csiCount
                                   from TargetX_Eventsb__ContactScheduleItem__c
                                   where TargetX_Eventsb__Contact__c in :scope
                                   and IIT_Organization_Event_Type__c in :OrgEventTypes
                                   and TargetX_Eventsb__Attended__c = true
                                   group by TargetX_Eventsb__Contact__c]) {
            updateVisitCount.add(new Contact(
                Id = (Id) ar.get('cID'),
                IIT_Total_Number_of_Campus_Visits__c = (Decimal) ar.get('csiCount')
            ));
        }
        update updateVisitCount;
        
        Contact[] updateLastVisitDate = new Contact[] {};
        for (AggregateResult ar : [select TargetX_Eventsb__Contact__c cID,
                                   max(IIT_Event_Start_Date__c) csiEventDate
                                   from TargetX_Eventsb__ContactScheduleItem__c
                                   where TargetX_Eventsb__Contact__c in :scope
                                   and IIT_Organization_Event_Type__c in :OrgEventTypes
                                   and TargetX_Eventsb__Attended__c = true
                                   group by TargetX_Eventsb__Contact__c]) {
            updateLastVisitDate.add(new Contact(
                Id = (Id) ar.get('cID'),
                IIT_Most_Recent_Campus_Visit__c = (Date) ar.get('csiEventDate')
            ));
        }
        update updateLastVisitDate;
    }

    public void finish(Database.BatchableContext context) {
        
        // Get the AsyncApexJob that represents the Batch job using the Id from the BatchableContext  
        AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
                            TotalJobItems, CreatedBy.Email, CreatedBy.Name, ExtendedStatus  
                            from AsyncApexJob where Id = :context.getJobId()
                         ];
   
        // Email the Batch Job's submitter that the Job is finished.
        String[] toAddresses = new String[] {a.CreatedBy.Email};
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(toAddresses);
        email.setSenderDisplayName(a.CreatedBy.Name);
        email.setSubject('Update Contact Event Data Batch Process ' + a.Status);
        email.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems + ' batches with ' + a.NumberOfErrors + ' failures.\r\nExtendedStatus: ' + a.ExtendedStatus);  
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email },false);
        
    }
}