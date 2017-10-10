global class IITAdvisorAssignmentBatchScheduler implements schedulable {
    
    global void execute(SchedulableContext sc) {
        
        IITAdvisorAssignmentBatch b = new IITAdvisorAssignmentBatch();
        database.executebatch(b,2000);
        
    }

}