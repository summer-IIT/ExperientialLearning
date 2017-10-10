@isTest
public class IITAdvisorAssignmentTest {
    
    @isTest(SeeAllData = 'true')
    public static void conductIITAdvisorAssignmentTest() {
        
        IITUndergraduateAdvisorAssignment__c advisorAssignmentSetting = [Select Id, IIT_Start_Term_and_Year__c From IITUndergraduateAdvisorAssignment__c Where Name = 'Default' Limit 1];
        advisorAssignmentSetting.IIT_Start_Term_and_Year__c = 'Fall 2017';
        update advisorAssignmentSetting;
        
        List<TargetX_SRMb__Application__c> appList = [Select Id
                                                      , IIT_Primary_Academic_Advisor__c
                                                      , IIT_Secondary_Academic_Advisor__c
                                                      From TargetX_SRMb__Application__c
                                                      Where TargetX_SRMb__Level__c = 'Undergraduate'
                                                      and TargetX_SRMb__Start_Term_and_Year__c IN ('Fall 2017','Summer 2017')
                                                      and TargetX_SRMb__Student_Type__c IN ('First Year','Transfer','Visiting','Exchange','Non Degree','Joint Program','Shimer','Vandercook')
                                                      and TargetX_SRMb__Possible_Academic_Major__c IN ('Aerospace Engineering','Mechanical Engineering','Architectural Engineering','Biomedical Engineering','Computer Engineering','Civil Engineering')
                                                      and TargetX_SRMb__Application_Type__c not in ('Research Opportunity','Undergraduate Summer Program')
                                                      and TargetX_SRMb__Accept_Enrollment_Deposit__c = TRUE
                                                      LIMIT 250
                                                     ];
        List<TargetX_SRMb__Application__c> appsToUpdate = new List<TargetX_SRMb__Application__c>();
        for(TargetX_SRMb__Application__c app : appList) {
            app.IIT_Primary_Academic_Advisor__c = null;
            app.IIT_Secondary_Academic_Advisor__c = null;
            appsToUpdate.add(app);
        }
        update appsToUpdate;
        
        Database.executeBatch(new IITAdvisorAssignmentBatch(),2000);
        
        String jobId = System.schedule('ScheduleApexClassTest', '0 0 0 15 3 ? 2022', new IITAdvisorAssignmentBatchScheduler());
        
    }

}