public class IITInsufficiencyController {
    
    Public id applicationId;
    
    public IITInsufficiencyController(ApexPages.StandardController controller) {
        applicationId = controller.getRecord().id;
    }
 
    public List<TargetX_SRMb__Essay__c> getAppEssay(){
        List<TargetX_SRMb__Essay__c> essayList = New List<TargetX_SRMb__Essay__c>();
        for(TargetX_SRMb__Essay__c appEssay:[select name,id,IsDeleted,RecordTypeId,TargetX_SRMb__Contact__c,TargetX_SRMb__Application__c,TargetX_SRMb__Essay_File_URL__c,TargetX_SRMb__Essay_Key__c,TargetX_SRMb__Personal_Essay_Type__c,TargetX_SRMb__SRM_ETL_ID__c,TargetX_SRMb__Complete__c,TargetX_SRMb__IsRequired__c,TargetX_SRMb__RequirementID__c,TargetX_SRMb__Type__c,IIT_Insufficiency_ID_Desc__c,IIT_Insufficiency_ID__c,IIT_Additional_Insufficiency_Notes__c from TargetX_SRMb__Essay__c where TargetX_SRMb__Application__c = :applicationId and IIT_Insufficiency_ID_Desc__c != null]){
            essayList.add(appEssay);
        }
        return essayList;
    }
    
    public List<TargetX_SRMb__Recommendation__c> getAppRec(){
        List<TargetX_SRMb__Recommendation__c> recList = New List<TargetX_SRMb__Recommendation__c>();
        for(TargetX_SRMb__Recommendation__c appRec:[select name,id,IsDeleted,TargetX_SRMb__Contact__c,TargetX_SRMb__Application__c,TargetX_SRMb__Email__c,TargetX_SRMb__File_URL__c,TargetX_SRMb__First_Name__c,TargetX_SRMb__Last_Name__c,TargetX_SRMb__Recommendation_Key__c,TargetX_SRMb__Relationship__c,TargetX_SRMb__SRM_ETL_ID__c,TargetX_SRMb__Salutation__c,TargetX_SRMb__Complete__c,TargetX_SRMb__IsRequired__c,TargetX_SRMb__RequirementID__c,TargetX_SRMb__Type__c,TargetX_App__Link_Security_Hash__c,TargetX_App__Recommendation_Process__c,IIT_Insufficiency_ID_Desc__c,IIT_Insufficiency_ID__c,IIT_Is_Test_Record__c,IIT_Additional_Insufficiency_Notes__c from TargetX_SRMb__Recommendation__c where TargetX_SRMb__Application__c = :applicationId and IIT_Insufficiency_ID_Desc__c != null]){
            recList.add(appRec);
        }
        return recList;
    }
    
    public List<TargetX_SRMb__Recommendation__c> getAppIncomRec(){
        List<TargetX_SRMb__Recommendation__c> recIncomList = New List<TargetX_SRMb__Recommendation__c>();
        for(TargetX_SRMb__Recommendation__c appIncomRec:[select name,id,IsDeleted,TargetX_SRMb__Contact__c,TargetX_SRMb__Application__c,TargetX_SRMb__Email__c,TargetX_SRMb__File_URL__c,TargetX_SRMb__First_Name__c,TargetX_SRMb__Last_Name__c,TargetX_SRMb__Recommendation_Key__c,TargetX_SRMb__Relationship__c,TargetX_SRMb__SRM_ETL_ID__c,TargetX_SRMb__Salutation__c,TargetX_SRMb__Complete__c,TargetX_SRMb__IsRequired__c,TargetX_SRMb__RequirementID__c,TargetX_SRMb__Type__c,TargetX_App__Link_Security_Hash__c,TargetX_App__Recommendation_Process__c,IIT_Insufficiency_ID_Desc__c,IIT_Insufficiency_ID__c,IIT_Is_Test_Record__c from TargetX_SRMb__Recommendation__c where TargetX_SRMb__Application__c = :applicationId and TargetX_SRMb__Status__c != 'Complete' and IIT_Insufficiency_ID_Desc__c = null]){
            recIncomList.add(appIncomRec);
        }
        return recIncomList;
    }

    public List<TargetX_SRMb__Enrollment_History__c> getEnrollHis(){
        List<TargetX_SRMb__Enrollment_History__c> enrollHisList = New List<TargetX_SRMb__Enrollment_History__c>();
        for(TargetX_SRMb__Enrollment_History__c appEnrollHist:[SELECT id,name,IsDeleted,RecordTypeId,TargetX_SRMb__Contact__c,TargetX_SRMb__Account__c,TargetX_SRMb__Application__c,TargetX_SRMb__Description__c,TargetX_SRMb__Enrollment_History_Key__c,TargetX_SRMb__Last_Data_Input_Source__c,TargetX_SRMb__Reference_ID__c,TargetX_SRMb__SRM_ETL_ID__c,TargetX_SRMb__School_Level__c,TargetX_SRMb__Type__c,TargetX_SRMb__Complete__c,TargetX_SRMb__IsRequired__c,TargetX_SRMb__RequirementID__c,Graduated__c,Account_ID__c,IIT_Unidentified_School_Name__c,IIT_Insufficiency_ID_Desc__c,IIT_Insufficiency_ID__c,IIT_Is_Test_Record__c,IIT_Additional_Insufficiency_Notes__c,TargetX_SRMb__Degree_Earned__c from TargetX_SRMb__Enrollment_History__c where TargetX_SRMb__Application__c = :applicationId and IIT_Insufficiency_ID_Desc__c != null]){
            enrollHisList.add(appEnrollHist);
        }
        return enrollHisList;
    }
    
    public List<TargetX_SRMb__Enrollment_History__c> getFinalEnrollHist(){
        List<TargetX_SRMb__Enrollment_History__c> enrollHistFinalList = New List<TargetX_SRMb__Enrollment_History__c>();
        for(TargetX_SRMb__Enrollment_History__c appEnroll:[SELECT id,name,IsDeleted,RecordTypeId,TargetX_SRMb__Contact__c,TargetX_SRMb__Account__c,TargetX_SRMb__Application__c,TargetX_SRMb__Description__c,TargetX_SRMb__Enrollment_History_Key__c,TargetX_SRMb__Last_Data_Input_Source__c,TargetX_SRMb__Reference_ID__c,TargetX_SRMb__SRM_ETL_ID__c,TargetX_SRMb__School_Level__c,TargetX_SRMb__Type__c,TargetX_SRMb__Complete__c,TargetX_SRMb__IsRequired__c,TargetX_SRMb__RequirementID__c,Graduated__c,Account_ID__c,IIT_Unidentified_School_Name__c,IIT_Insufficiency_ID_Desc__c,IIT_Insufficiency_ID__c,IIT_Is_Test_Record__c from TargetX_SRMb__Enrollment_History__c where TargetX_SRMb__Application__c = :applicationId and TargetX_SRMb__Official_Final_Transcripts_Received__c = false and TargetX_SRMb__Degree_Earned__c like 'Bachelor%']){
            enrollHistFinalList.add(appEnroll);
        }
        return enrollHistFinalList;
    }
    
   
}