public with sharing class IITEssayController {

    Public id Current_Cont_Id;
 
    public IITEssayController(ApexPages.StandardController controller) {
        Id applicationId = controller.getRecord().id;
        Current_Cont_Id = ([SELECT TargetX_SRMb__Contact__c FROM TargetX_SRMb__Application__c WHERE id = :applicationId LIMIT 1]).TargetX_SRMb__Contact__c;
    }
 
     public List<TargetX_SRMb__Essay__c> getConEssay(){
       List<TargetX_SRMb__Essay__c> essayList = New List<TargetX_SRMb__Essay__c>();
       for(Contact currentContact:[select id,name,(select name,id,IsDeleted,RecordTypeId,TargetX_SRMb__Contact__c,TargetX_SRMb__Application__c,TargetX_SRMb__Essay_File_URL__c,TargetX_SRMb__Essay_Key__c,TargetX_SRMb__Personal_Essay_Type__c,TargetX_SRMb__SRM_ETL_ID__c,TargetX_SRMb__Complete__c,TargetX_SRMb__IsRequired__c,TargetX_SRMb__RequirementID__c,TargetX_SRMb__Type__c,IIT_Insufficiency_ID_Desc__c,IIT_Insufficiency_ID__c from TargetX_SRMb__Essays__r) from contact where id=:Current_Cont_Id]){
           for(TargetX_SRMb__Essay__c contactEssay:currentContact.TargetX_SRMb__Essays__r)
               essayList.add(contactEssay);
       }
       return essayList;
    }
    
}