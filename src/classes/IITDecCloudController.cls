public with sharing class IITDecCloudController {

    Public id Current_Contact_Id;
    Public id Current_App_Id;
   
    public IITDecCloudController(ApexPages.StandardController controller) {
        Current_App_Id = controller.getRecord().id;
        Current_Contact_Id = ([SELECT TargetX_SRMb__Contact__c
                               FROM TargetX_SRMb__Application__c
                               WHERE id = :Current_App_Id LIMIT 1]).TargetX_SRMb__Contact__c;
    }

    //Get Contact Test Scores for Decision Cloud
    public List<TargetX_SRMb__Test__c> getcontactTests(){
        List<TargetX_SRMb__Test__c> testList = [select name,
                                                id,
                                                TargetX_SRMb__ACT_Composite_Score__c,
                                                TargetX_SRMb__ACT_English_Writing_Score__c,
                                                TargetX_SRMb__ACT_English_Score__c,
                                                TargetX_SRMb__ACT_Math_Score__c,
                                                TargetX_SRMb__ACT_Reading_Score__c,
                                                TargetX_SRMb__ACT_Science_Score__c,
                                                TargetX_SRMb__GMAT_Analytical_Percentage__c,
                                                TargetX_SRMb__GMAT_Analytical_Score__c,
                                                TargetX_SRMb__GMAT_Integrated_Reasoning_Percentage__c,
                                                TargetX_SRMb__GMAT_Integrated_Reasoning_Score__c,
                                                TargetX_SRMb__GMAT_Quantitative_Percentage__c,
                                                TargetX_SRMb__GMAT_Quantitative_Score__c,
                                                TargetX_SRMb__GMAT_Total_Percentage__c,
                                                TargetX_SRMb__GMAT_Total_Score__c,
                                                TargetX_SRMb__GMAT_Verbal_Percentage__c,
                                                TargetX_SRMb__GMAT_Verbal_Score__c,
                                                TargetX_SRMb__GRE_General_Analytical_Percentage__c,
                                                TargetX_SRMb__GRE_General_Analytical_Score__c,
                                                IIT_GRE_General_Composite_Score__c,
                                                TargetX_SRMb__GRE_General_Quantitative_Percentage__c,
                                                TargetX_SRMb__GRE_General_Quantitative_Score__c,
                                                TargetX_SRMb__GRE_General_Verbal_Percentage__c,
                                                TargetX_SRMb__GRE_General_Verbal_Score__c,
                                                TargetX_SRMb__GRE_Subject_Subject__c,
                                                TargetX_SRMb__GRE_Subject_Subscore__c,
                                                TargetX_SRMb__GRE_Subject_Total_Score__c,
                                                IIT_IELTS_Listening_Band_Score__c,
                                                IIT_IELTS_Overall_Band_Score__c,
                                                IIT_IELTS_Reading_Band_Score__c,
                                                IIT_IELTS_Speaking_Band_Score__c,
                                                IIT_IELTS_Writing_Band_Score__c,
                                                TargetX_SRMb__MCAT_Biological_Science__c,
                                                TargetX_SRMb__MCAT_Physical_Science__c,
                                                TargetX_SRMb__MCAT_Verbal_Reasoning__c,
                                                TargetX_SRMb__MCAT_Writing__c,
                                                TargetX_SRMb__RSAT_I_Total__c,
                                                TargetX_SRMb__RSAT_I_EBRW__c,
                                                TargetX_SRMb__RSAT_I_Math_Section__c,
                                                IIT_SAT_I_Composite_V_M__c,
                                                IIT_SAT_I_Composite_V_M_W__c,
                                                TargetX_SRMb__SAT_II_Subject__c,
                                                TargetX_SRMb__SAT_II_Subject_Score__c,
                                                TargetX_SRMb__SAT_I_Math_Score__c,
                                                TargetX_SRMb__SAT_I_Verbal_Score__c,
                                                TargetX_SRMb__SAT_I_Writing_Score__c,
                                                TargetX_SRMb__Score_Validated__c,
                                                TargetX_SRMb__Test__c,
                                                TargetX_SRMb__Test_Date__c,
                                                TargetX_SRMb__TOEFL_Listening_Comprehension__c,
                                                TargetX_SRMb__TOEFL_Reading_Comprehension__c,
                                                TargetX_SRMb__TOEFL_Speaking_Comprehension__c,
                                                TargetX_SRMb__TOEFL_Total_Score__c,
                                                TargetX_SRMb__TOEFL_Writing_Comprehension__c,
                                                IIT_TOEFL_Proficiency__c
                                                from TargetX_SRMb__Test__c
                                                where TargetX_SRMb__Contact__c  = :Current_Contact_Id];
       return testList;
    }

      //ID ARCH retrieve all ARID type app reviews for a given application 
      public List<TargetX_Reader__Application_Review__c> getAppReviews(){
       List<TargetX_Reader__Application_Review__c> appReviewList = [
           SELECT Id
           , Name
           , TargetX_Reader__Application_Review_Type__c
           , IIT_Academic_Strength__c
           , IIT_Additional_Interview__c
           , IIT_Architecture_Ranking__c
           , IIT_Level_of_Preparation_for_Studies__c
           , IIT_Number_of_Studios__c
           , IIT_Quality_of_Letters_of_Recommendation__c
           , IIT_Quality_of_Personal_Statement__c
           , IIT_Quality_of_Portfolio__c
           , IIT_Recommend_English_for_Design_Course__c
           , IIT_Recommend_Fellowship_Consideration__c
           , IIT_Recommend_Foundation_Course__c
           , IIT_Relevant_Work_or_Life_Experience__c
           , IIT_Average_Score__c
           , IIT_Decision_Maker__c
           , IIT_Experience_in_Arch_Art_Design__c
           , TargetX_Reader__Date_Completed__c
           , IIT_Summary_Notes__c
           , IIT_Decision_Maker_Name__c
           , IIT_Faculty_Assessor_1__c
           , IIT_Faculty_Assessor_2__c  
            FROM TargetX_Reader__Application_Review__c
           WHERE TargetX_Reader__Application_Review_Type__c = 'a1Pj0000001HkQz'
           AND TargetX_Reader__Application__c = :Current_App_Id];
       return appReviewList;
    }
    
    public List<TargetX_SRMb__Application__c> getApplications(){
        List<TargetX_SRMb__Application__c> appList = [SELECT Id,
                                                     TargetX_SRMb__Level__c,
                                                     TargetX_SRMb__Start_Term_and_Year__c,
                                                     TargetX_SRMb__Student_Type__c,
                                                     TargetX_SRMb__Possible_Academic_Major__c
                                                     FROM TargetX_SRMb__Application__c
                                                     WHERE TargetX_SRMb__Contact__c = :Current_Contact_Id
                                                    ];
        return appList;
    }
    
    public List<TargetX_SRMb__Enrollment_History__c> getContactEnrollHist(){
        List<TargetX_SRMb__Enrollment_History__c> ehList = [SELECT Id,
                                                            TargetX_SRMb__Account__r.TargetX_SRMb__ceeb_code__c,
                                                            TargetX_SRMb__Account__r.Name,
                                                            TargetX_SRMb__Official_Recalculated_GPA__c,
                                                            TargetX_SRMb__Official_Class_Rank__c,
                                                            TargetX_SRMb__Official_Class_Size__c,
                                                            TargetX_SRMb__Start_Date__c,
                                                            TargetX_SRMb__End_Date__c
                                                            FROM TargetX_SRMb__Enrollment_History__c
                                                            WHERE TargetX_SRMb__Contact__c = :Current_Contact_Id
                                                           ];
        return ehList;
    }
    
}