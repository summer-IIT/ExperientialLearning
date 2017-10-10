global class IITCleanPhones implements Database.Batchable<sObject>{
/*Purge all duplicate phone records and keep the oldest one.
*/
    global Database.QueryLocator start(Database.BatchableContext BC){//Runs when the Batch Job starts
        return null;
   }
    
    global void execute(Database.BatchableContext BC, List<sobject> scope) {//Actually executes the batch job
    }
    
    global void finish(Database.BatchableContext BC) {//Fires when the batch job finishes.
    }
}