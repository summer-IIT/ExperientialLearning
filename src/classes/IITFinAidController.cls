public with sharing class IITFinAidController {

    Public id Current_Contact_Id;
 
    public IITFinAidController(ApexPages.StandardController controller) {
        Id applicationId = controller.getRecord().id;
        Current_Contact_Id = ([SELECT TargetX_SRMb__Contact__c FROM TargetX_SRMb__Application__c WHERE id = :applicationId LIMIT 1]).TargetX_SRMb__Contact__c;
    }
 
     public List<TargetX_SRMb__Financial_Aid__c> getcontactFinAid(){
       List<TargetX_SRMb__Financial_Aid__c> finAidList = New List<TargetX_SRMb__Financial_Aid__c>();
       for(Contact currentContact:[select id,name,(select name,id,TargetX_SRMb__Accept_Date__c,IIT_Aid_Year_Description__c,TargetX_SRMb__Amount__c,TargetX_SRMb__Amount_Per_Year__c,TargetX_SRMb__Award_Criteria__c,TargetX_SRMb__Award_Date__c,TargetX_SRMb__Award_Level__c,IIT_Credit_Hours__c,IIT_Description__c,IIT_Funding_Modified_Date__c,IIT_Is_Test_Record__c,TargetX_SRMb__Last_Data_Input_Source__c,IIT_Percentage__c,IIT_PhD_Continuation_Indicator__c,IIT_Program__c,IIT_Stipend_Amount__c,TargetX_SRMb__Sub_Type__c,TargetX_SRMb__Type__c,IIT_Term_Description__c from TargetX_SRMb__Financial_Aid__r) from contact where id=:Current_Contact_Id]){
           for(TargetX_SRMb__Financial_Aid__c contactFinAid:currentContact.TargetX_SRMb__Financial_Aid__r)
               finAidList.add(contactFinAid);
       }
       return finAidList;
    }
    
}