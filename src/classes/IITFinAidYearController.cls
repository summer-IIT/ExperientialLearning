public with sharing class IITFinAidYearController {

    Public id Current_Contact_Id;
    Public id Program_Code;
 
    public IITFinAidYearController(ApexPages.StandardController controller) {
        Id applicationId = controller.getRecord().id;
        Current_Contact_Id = ([SELECT TargetX_SRMb__Contact__c FROM TargetX_SRMb__Application__c WHERE id = :applicationId LIMIT 1]).TargetX_SRMb__Contact__c;
        Program_Code = ([SELECT IIT_Program__c FROM TargetX_SRMb__Application__c where id = :applicationID LIMIT 1]).IIT_Program__c;
    }
 
	public List<TargetX_SRMb__Financial_Aid__c> getcontactFinAid(){
		map<string, IIT_App_Tracker_Settings__c> appTrackerSettingsMap = IIT_App_Tracker_Settings__c.getAll();
        string finAidYearDesc = appTrackerSettingsMap.get('Default').IIT_Fin_Aid_Year_Description__c;
       
		List<TargetX_SRMb__Financial_Aid__c> finAidList = New List<TargetX_SRMb__Financial_Aid__c>();
		for(Contact currentContact:[select id,name,(select name,id, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, TargetX_SRMb__Contact__c, TargetX_SRMb__Accept_Date__c, TargetX_SRMb__Amount_Per_Year__c, TargetX_SRMb__Amount__c, TargetX_SRMb__Award_Criteria__c, TargetX_SRMb__Award_Date__c, TargetX_SRMb__Award_Level__c, TargetX_SRMb__Financial_Aid_Key__c, TargetX_SRMb__Last_Data_Input_Source__c, TargetX_SRMb__SRM_ETL_ID__c, TargetX_SRMb__Sub_Type__c, TargetX_SRMb__Type__c, IIT_Percentage__c, IIT_Credit_Hours__c, IIT_Stipend_Amount__c, IIT_Aid_Year_Description__c, IIT_Description__c, IIT_Term_Description__c, IIT_Banner_PIDM__c, IIT_Funding_Modified_Date__c, IIT_Program__c, IIT_PhD_Continuation_Indicator__c, IIT_Is_Test_Record__c, IIT_Application__c, IIT_PhD_Funding__c, IIT_Amount_For_Merge__c, IIT_Award_Status__c, IIT_Total_Stuart_Scholarship__c, IIT_Award_Amount_Per_Class__c, IIT_Stuart_Number_of_Classes__c, IIT_Feed_to_Banner__c, IIT_Program_Code__c from TargetX_SRMb__Financial_Aid__r where IIT_Aid_Year_Description__c = :finAidYearDesc AND IIT_Program_Code__c =:Program_Code AND IIT_Award_Status__c != 'Canceled' AND (IIT_Stipend_Amount__c !=0 or TargetX_SRMb__Amount__c != 0 or IIT_Credit_Hours__c !=0) ORDER BY TargetX_SRMb__Type__c DESC, IIT_Term_Description__c ASC) from contact where id=:Current_Contact_Id]){
			for(TargetX_SRMb__Financial_Aid__c contactFinAid:currentContact.TargetX_SRMb__Financial_Aid__r)
				finAidList.add(contactFinAid);
		}
		return finAidList;
    }
    
}