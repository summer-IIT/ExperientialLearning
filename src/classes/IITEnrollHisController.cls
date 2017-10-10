public with sharing class IITEnrollHisController {

    Public id Current_Contact_Id;
 
    public IITEnrollHisController(ApexPages.StandardController controller) {
        Id applicationId = controller.getRecord().id;
        Current_Contact_Id = ([SELECT TargetX_SRMb__Contact__c FROM TargetX_SRMb__Application__c WHERE id = :applicationId LIMIT 1]).TargetX_SRMb__Contact__c;
    }
 
     public List<TargetX_SRMb__Enrollment_History__c> getEnrollHis(){
       List<TargetX_SRMb__Enrollment_History__c> enrollHisList = New List<TargetX_SRMb__Enrollment_History__c>();
       for(Contact currentContact:[select id,name,(SELECT id,name,IsDeleted,RecordTypeId,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastActivityDate,TargetX_SRMb__Contact__c,TargetX_SRMb__Account__c,TargetX_SRMb__Application__c,TargetX_SRMb__Ceeb_Code__c,TargetX_SRMb__Currently_Enrolled__c,TargetX_SRMb__Degree_Candidate__c,TargetX_SRMb__Degree_Earned__c,TargetX_SRMb__Description__c,TargetX_SRMb__Early_Grad__c,TargetX_SRMb__End_Date__c,TargetX_SRMb__Enrollment_History_Key__c,TargetX_SRMb__GED_Date__c,TargetX_SRMb__GPA_Official_Scale__c,TargetX_SRMb__GPA_Scale__c,TargetX_SRMb__Last_Data_Input_Source__c,TargetX_SRMb__Official_Class_Rank__c,TargetX_SRMb__Official_Class_Size__c,TargetX_SRMb__Official_Final_Transcripts_Received__c,TargetX_SRMb__Official_GPA_Scale__c,TargetX_SRMb__Official_GPA__c,TargetX_SRMb__Official_Graduation_Year__c,TargetX_SRMb__Official_Recalculated_GPA__c,TargetX_SRMb__Official_Transcripts_Received__c,TargetX_SRMb__Recalculated_GPA__c,TargetX_SRMb__Reference_ID__c,TargetX_SRMb__SRM_ETL_ID__c,TargetX_SRMb__School_Level__c,TargetX_SRMb__Self_Reported_Class_Rank__c,TargetX_SRMb__Self_Reported_Class_Size__c,TargetX_SRMb__Self_Reported_GPA_Scale__c,TargetX_SRMb__Self_Reported_GPA__c,TargetX_SRMb__Self_Reported_Grad_Year__c,TargetX_SRMb__Start_Date__c,TargetX_SRMb__Type__c,TargetX_SRMb__eh_ceeb_code__c,TargetX_SRMb__exportSequence__c,TargetX_SRMb__Complete__c,TargetX_SRMb__IsRequired__c,TargetX_SRMb__RequirementID__c,Graduated__c,Account_ID__c,IIT_Unidentified_School_Name__c,IIT_Insufficiency_ID_Desc__c,IIT_Insufficiency_ID__c,IIT_Is_Test_Record__c,IIT_TE_Term_1__c,IIT_TE_Term_2__c,IIT_TE_Term_3__c,IIT_TE_Term_4__c,IIT_TE_Term_5__c,IIT_TE_Term_6__c,IIT_TE_Term_7__c,IIT_TE_Term_8__c,IIT_TE_Overall__c,IIT_TE_Notes__c,IIT_Previously_Failed_a_Course__c,IIT_Official_Credit_Hours__c     from TargetX_SRMb__Enrollment_History__r) from contact where id=:Current_Contact_Id]){
           for(TargetX_SRMb__Enrollment_History__c contactEnrollHist:currentContact.TargetX_SRMb__Enrollment_History__r)
               enrollHisList.add(contactEnrollHist);
       }
       return enrollHisList;
    }
    
}