public class IITAdvisorAssignmentBatch implements Database.Batchable<SObject> {
    
    public static string startTermYear;
    public static string summerTerm;
    public static set<string> startTerms;
    public static Map<string, IITUndergraduateAdvisorAssignment__c> advisorMappings;
    public static Map<string, integer> advisorRoundRobinCounts;
    
    public static Map<string, IITUndergraduateAdvisorAssignment__c> getAdvisorMappings() {
        
        if (advisorMappings == null) {
            advisorMappings = IITUndergraduateAdvisorAssignment__c.getAll();
        }
        return advisorMappings;
        
    }

    public static Map<string, integer> getAdvisorRoundRobinCounts() {

        startTermYear = getAdvisorMappings().get('Default').IIT_Start_Term_and_Year__c;

        if (advisorRoundRobinCounts == null) {
            advisorRoundRobinCounts = new Map<string, integer>();
            List<IITUndergraduateAdvisorAssignment__c> advisorMappingsRoundRobin = [Select Id
                                                                                    , Name
                                                                                    , IIT_Advisor_Assign_By__c
                                                                                    , IIT_Advisor_Round_Robin_1__c
                                                                                    , IIT_Advisor_Round_Robin_2__c
                                                                                    , IIT_Advisor_Round_Robin_3__c
                                                                                    From IITUndergraduateAdvisorAssignment__c
                                                                                    Where IIT_Advisor_Assign_By__c Like 'RoundRobin%'
                                                                                    ];
            for (IITUndergraduateAdvisorAssignment__c a : advisorMappingsRoundRobin) {
                if (a.IIT_Advisor_Assign_By__c == 'RoundRobin2') {
                    string roundRobinAdvisor = a.IIT_Advisor_Round_Robin_1__c.substringBefore(' / ');
                    integer advisorCount = database.countQuery('select count() from TargetX_SRMb__Application__c where TargetX_SRMb__Level__c = \'Undergraduate\' and TargetX_SRMb__Start_Term_and_Year__c = :startTermYear and IIT_Primary_Academic_Advisor__c = :roundRobinAdvisor');
                    advisorRoundRobinCounts.put(roundRobinAdvisor, advisorCount);

                    roundRobinAdvisor = a.IIT_Advisor_Round_Robin_2__c.substringBefore(' / ');
                    advisorCount = database.countQuery('select count() from TargetX_SRMb__Application__c where TargetX_SRMb__Level__c = \'Undergraduate\' and TargetX_SRMb__Start_Term_and_Year__c = :startTermYear and IIT_Primary_Academic_Advisor__c = :roundRobinAdvisor');
                    advisorRoundRobinCounts.put(roundRobinAdvisor, advisorCount);
                } else if (a.IIT_Advisor_Assign_By__c == 'RoundRobin3') {
                    string roundRobinAdvisor = a.IIT_Advisor_Round_Robin_1__c.substringBefore(' / ');
                    integer advisorCount = database.countQuery('select count() from TargetX_SRMb__Application__c where TargetX_SRMb__Level__c = \'Undergraduate\' and TargetX_SRMb__Start_Term_and_Year__c = :startTermYear and IIT_Primary_Academic_Advisor__c = :roundRobinAdvisor');
                    advisorRoundRobinCounts.put(roundRobinAdvisor, advisorCount);

                    roundRobinAdvisor = a.IIT_Advisor_Round_Robin_2__c.substringBefore(' / ');
                    advisorCount = database.countQuery('select count() from TargetX_SRMb__Application__c where TargetX_SRMb__Level__c = \'Undergraduate\' and TargetX_SRMb__Start_Term_and_Year__c = :startTermYear and IIT_Primary_Academic_Advisor__c = :roundRobinAdvisor');
                    advisorRoundRobinCounts.put(roundRobinAdvisor, advisorCount);

                    roundRobinAdvisor = a.IIT_Advisor_Round_Robin_3__c.substringBefore(' / ');
                    advisorCount = database.countQuery('select count() from TargetX_SRMb__Application__c where TargetX_SRMb__Level__c = \'Undergraduate\' and TargetX_SRMb__Start_Term_and_Year__c = :startTermYear and IIT_Primary_Academic_Advisor__c = :roundRobinAdvisor');
                    advisorRoundRobinCounts.put(roundRobinAdvisor, advisorCount);
                }
            }
        }
        return advisorRoundRobinCounts;

    }
    
    public Database.QueryLocator start(Database.BatchableContext context) {
        
        startTermYear = getAdvisorMappings().get('Default').IIT_Start_Term_and_Year__c;
        summerTerm = getAdvisorMappings().get('Default').IIT_Summer_Term__c;
        startTerms = new set<string>();
        startTerms.add(startTermYear);
        if (summerTerm != null) {
            startTerms.add(summerTerm);
        }
        
        return Database.getQueryLocator([Select Id
                                         	, TargetX_SRMb__Possible_Academic_Major__c
                                         	, TargetX_SRMb__Student_Type__c
                                         	, TargetX_SRMb__Start_Term__c
                                         	, TargetX_SRMb__Contact__r.LastName
											From TargetX_SRMb__Application__c
											Where TargetX_SRMb__Level__c = 'Undergraduate'
                                         	And TargetX_SRMb__Start_Term_and_Year__c In :startTerms
                                         	And TargetX_SRMb__Student_Type__c In ('First Year','Transfer','Visiting','Exchange','Non Degree','Joint Program','Shimer','Vandercook')
                                         	And TargetX_SRMb__Application_Type__c Not In ('Research Opportunity','Undergraduate Summer Program')
											And (
                                            	TargetX_SRMb__Accept_Enrollment_Deposit__c = TRUE
                                                Or
                                                IIT_Enrollment_Deposit_Waived__c = TRUE
                                            )
                                         	And (
                                                IIT_Primary_Academic_Advisor__c = NULL
                                            	Or
                                                IIT_Update_UG_Advisor__c = TRUE
                                            )
										]);
        
    }
        
    public void execute(Database.BatchableContext context, List<TargetX_SRMb__Application__c> scope) {
        
        TargetX_SRMb__Application__c[] updatePrimaryAdvisor = new TargetX_SRMb__Application__c[] {};
        for (TargetX_SRMb__Application__c app : scope) {
            
            string appMajor = null;
            if (app.TargetX_SRMb__Start_Term__c == 'Summer') {
                appMajor = 'Summer';
            } else if (app.TargetX_SRMb__Possible_Academic_Major__c == 'Consumer Research, Analytics and Communication') {
                appMajor = 'Consumer Research';
            } else {
                appMajor = app.TargetX_SRMb__Possible_Academic_Major__c;
            }
            string advisorAssignBy = getAdvisorMappings().get(appMajor).IIT_Advisor_Assign_By__c;
            string studentType = app.TargetX_SRMb__Student_Type__c;
            string lastName = app.TargetX_SRMb__Contact__r.LastName.substring(0,1);
            string alphaAM = 'A:B:C:D:E:F:G:H:I:J:K:L:M';
            string alphaNZ = 'N:O:P:Q:R:S:T:U:V:W:X:Y:Z';
            
            if (advisorAssignBy == 'All') {
                updatePrimaryAdvisor.add(new TargetX_SRMb__Application__c(
                	Id = app.Id,
                	IIT_Primary_Academic_Advisor__c = getAdvisorMappings().get(appMajor).IIT_Advisor_Primary__c.substringBefore(' / '),
                	IIT_Secondary_Academic_Advisor__c = NULL,
                	IIT_Update_UG_Advisor__c = FALSE
				));
            } else if (advisorAssignBy == 'PrimarySecondary') {
                updatePrimaryAdvisor.add(new TargetX_SRMb__Application__c(
                	Id = app.Id,
                	IIT_Primary_Academic_Advisor__c = getAdvisorMappings().get(appMajor).IIT_Advisor_Primary__c.substringBefore(' / '),
                    IIT_Secondary_Academic_Advisor__c = getAdvisorMappings().get(appMajor).IIT_Advisor_Secondary__c.substringBefore(' / '),
                	IIT_Update_UG_Advisor__c = FALSE
				));
            } else if (advisorAssignBy == 'StudentType') {
                if (studentType == 'First Year') {
                    updatePrimaryAdvisor.add(new TargetX_SRMb__Application__c(
                		Id = app.Id,
                		IIT_Primary_Academic_Advisor__c = getAdvisorMappings().get(appMajor).IIT_Advisor_First_Year__c.substringBefore(' / '),
						IIT_Secondary_Academic_Advisor__c = NULL,
                		IIT_Update_UG_Advisor__c = FALSE
					));
                } else if (studentType == 'Transfer' || studentType == 'Joint Program') {
                    updatePrimaryAdvisor.add(new TargetX_SRMb__Application__c(
                		Id = app.Id,
                		IIT_Primary_Academic_Advisor__c = getAdvisorMappings().get(appMajor).IIT_Advisor_Transfer__c.substringBefore(' / '),
                		IIT_Secondary_Academic_Advisor__c = NULL,
                		IIT_Update_UG_Advisor__c = FALSE
					));
                } else if (studentType == 'Exchange' || studentType == 'Visiting' || studentType == 'Non Degree') {
                    updatePrimaryAdvisor.add(new TargetX_SRMb__Application__c(
                		Id = app.Id,
                		IIT_Primary_Academic_Advisor__c = getAdvisorMappings().get(appMajor).IIT_Advisor_Exchange_Visiting__c.substringBefore(' / '),
                		IIT_Secondary_Academic_Advisor__c = NULL,
                		IIT_Update_UG_Advisor__c = FALSE
					));
                }
            } else if (advisorAssignBy == 'Alpha') {
                if (alphaAM.containsIgnoreCase(lastName)) {
                    updatePrimaryAdvisor.add(new TargetX_SRMb__Application__c(
                		Id = app.Id,
                		IIT_Primary_Academic_Advisor__c = getAdvisorMappings().get(appMajor).IIT_Advisor_Alpha_1__c.substringBefore(' / '),
                		IIT_Secondary_Academic_Advisor__c = NULL,
                		IIT_Update_UG_Advisor__c = FALSE
					));
                } else if (alphaNZ.containsIgnoreCase(lastName)) {
                    updatePrimaryAdvisor.add(new TargetX_SRMb__Application__c(
                		Id = app.Id,
                		IIT_Primary_Academic_Advisor__c = getAdvisorMappings().get(appMajor).IIT_Advisor_Alpha_2__c.substringBefore(' / '),
                		IIT_Secondary_Academic_Advisor__c = NULL,
                		IIT_Update_UG_Advisor__c = FALSE
					));
                }
            } else if (advisorAssignBy == 'RoundRobin3') {
                string roundRobin1 = getAdvisorMappings().get(appMajor).IIT_Advisor_Round_Robin_1__c.substringBefore(' / ');
                string roundRobin2 = getAdvisorMappings().get(appMajor).IIT_Advisor_Round_Robin_2__c.substringBefore(' / ');
                string roundRobin3 = getAdvisorMappings().get(appMajor).IIT_Advisor_Round_Robin_3__c.substringBefore(' / ');
                integer roundRobin1Count = getAdvisorRoundRobinCounts().get(roundRobin1);
                integer roundRobin2Count = getAdvisorRoundRobinCounts().get(roundRobin2);
                integer roundRobin3Count = getAdvisorRoundRobinCounts().get(roundRobin3);
                    
                if (roundRobin1Count == roundRobin2Count && roundRobin2Count == roundRobin3Count) {
                    updatePrimaryAdvisor.add(new TargetX_SRMb__Application__c(
                		Id = app.Id,
                		IIT_Primary_Academic_Advisor__c = roundRobin1,
                		IIT_Secondary_Academic_Advisor__c = NULL,
                		IIT_Update_UG_Advisor__c = FALSE
					));
                    advisorRoundRobinCounts.put(roundRobin1, roundRobin1Count + 1);
                } else if (roundRobin1Count > roundRobin2Count && roundRobin2Count == roundRobin3Count) {
                    updatePrimaryAdvisor.add(new TargetX_SRMb__Application__c(
                		Id = app.Id,
                		IIT_Primary_Academic_Advisor__c = roundRobin2,
                		IIT_Secondary_Academic_Advisor__c = NULL,
                		IIT_Update_UG_Advisor__c = FALSE
					));
                    advisorRoundRobinCounts.put(roundRobin2, roundRobin2Count + 1);
                } else if (roundRobin1Count == roundRobin2Count && roundRobin2Count > roundRobin3Count) {
                    updatePrimaryAdvisor.add(new TargetX_SRMb__Application__c(
                		Id = app.Id,
                		IIT_Primary_Academic_Advisor__c = roundRobin3,
                		IIT_Secondary_Academic_Advisor__c = NULL,
                		IIT_Update_UG_Advisor__c = FALSE
					));
                    advisorRoundRobinCounts.put(roundRobin3, roundRobin3Count + 1);
                }
            } else if (advisorAssignBy == 'RoundRobin2') {
                string roundRobin1 = getAdvisorMappings().get(appMajor).IIT_Advisor_Round_Robin_1__c.substringBefore(' / ');
                string roundRobin2 = getAdvisorMappings().get(appMajor).IIT_Advisor_Round_Robin_2__c.substringBefore(' / ');
                integer roundRobin1Count = getAdvisorRoundRobinCounts().get(roundRobin1);
                integer roundRobin2Count = getAdvisorRoundRobinCounts().get(roundRobin2);
                    
                if (roundRobin1Count == roundRobin2Count) {
                    updatePrimaryAdvisor.add(new TargetX_SRMb__Application__c(
                		Id = app.Id,
                		IIT_Primary_Academic_Advisor__c = roundRobin1,
                		IIT_Secondary_Academic_Advisor__c = NULL,
                		IIT_Update_UG_Advisor__c = FALSE
					));
                    advisorRoundRobinCounts.put(roundRobin1, roundRobin1Count + 1);
                } else if (roundRobin1Count > roundRobin2Count) {
                    updatePrimaryAdvisor.add(new TargetX_SRMb__Application__c(
                		Id = app.Id,
                		IIT_Primary_Academic_Advisor__c = roundRobin2,
                		IIT_Secondary_Academic_Advisor__c = NULL,
                		IIT_Update_UG_Advisor__c = FALSE
					));
                    advisorRoundRobinCounts.put(roundRobin2, roundRobin2Count + 1);
                }
            }
        }
		update updatePrimaryAdvisor;
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
        email.setSubject('Advisor Assignment Batch Process ' + a.Status);
        email.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems + ' batches with ' + a.NumberOfErrors + ' failures.\r\nExtendedStatus: ' + a.ExtendedStatus);  
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email },false);
        
    }

}