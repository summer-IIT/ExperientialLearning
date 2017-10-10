global class IITUpdateContactEventDataBatchScheduler implements schedulable {
    
    global void execute(SchedulableContext sc) {
        
        IITUpdateContactEventDataBatch b = new IITUpdateContactEventDataBatch();
        database.executebatch(b);
        
    }

}