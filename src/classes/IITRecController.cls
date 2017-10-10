public with sharing class IITRecController {

    Public id Current_C_Id;
 
    public IITRecController(ApexPages.StandardController controller) {
        Id applicationId = controller.getRecord().id;
        Current_C_Id = ([SELECT TargetX_SRMb__Contact__c FROM TargetX_SRMb__Application__c WHERE id = :applicationId LIMIT 1]).TargetX_SRMb__Contact__c;
    }
 
     public List<TargetX_SRMb__Recommendation__c> getContactRec(){
       List<TargetX_SRMb__Recommendation__c> recList = New List<TargetX_SRMb__Recommendation__c>();
       for(Contact currentContact:[select id,name,(select name,id,IsDeleted,CreatedDate,CreatedById,LastModifiedDate,LastModifiedById,SystemModstamp,LastActivityDate,LastViewedDate,LastReferencedDate,TargetX_SRMb__Contact__c,TargetX_SRMb__Academic_Achievement__c,TargetX_SRMb__Application__c,TargetX_SRMb__Comments__c,TargetX_SRMb__Concern_For_Others__c,TargetX_SRMb__Creative_Original_Thought__c,TargetX_SRMb__Disciplined_Work_Habits__c,TargetX_SRMb__Email__c,TargetX_SRMb__File_URL__c,TargetX_SRMb__First_Name__c,TargetX_SRMb__Initiative_Independence__c,TargetX_SRMb__Integrity__c,TargetX_SRMb__Intellectual_Promise__c,TargetX_SRMb__Last_Data_Input_Source__c,TargetX_SRMb__Last_Name__c,TargetX_SRMb__Leadership__c,TargetX_SRMb__Maturity__c,TargetX_SRMb__Middle_Name__c,TargetX_SRMb__Motivation__c,TargetX_SRMb__Overall__c,TargetX_SRMb__Phone__c,TargetX_SRMb__Productive_Class_Discussion__c,TargetX_SRMb__Quality_of_Writing__c,TargetX_SRMb__Reaction_to_Setbacks__c,TargetX_SRMb__Recommendation_Key__c,TargetX_SRMb__Relationship__c,TargetX_SRMb__Respect_Accorded_by_Faculty__c,TargetX_SRMb__SRM_ETL_ID__c,TargetX_SRMb__Salutation__c,TargetX_SRMb__Self_Confidence__c,TargetX_SRMb__Staff__c,TargetX_SRMb__Status__c,TargetX_SRMb__Suffix__c,TargetX_SRMb__Title__c,TargetX_SRMb__exportSequence__c,TargetX_SRMb__Complete__c,TargetX_SRMb__IsRequired__c,TargetX_SRMb__RequirementID__c,TargetX_SRMb__Type__c,TargetX_App__Email_Template_Id__c,TargetX_App__Link_Security_Hash__c,TargetX_App__Recommendation_Process__c,IIT_Insufficiency_ID_Desc__c,IIT_Insufficiency_ID__c,IIT_Is_Test_Record__c from TargetX_SRMb__Recommendation__r) from contact where id=:Current_C_Id]){
           for(TargetX_SRMb__Recommendation__c contactRec:currentContact.TargetX_SRMb__Recommendation__r)
               recList.add(contactRec);
       }
       return recList;
    }
    
}