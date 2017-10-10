public with sharing class IITAppTrackerAccountController {
	
    Public id Current_Account_Id;
    Public integer Current_Academic_Year_Integer;
    Public string Current_Academic_Year_String;
    Public date Current_Date;
    Public boolean accessError;
    Public string accessKey;
    Public string Current_Account_Key;
    
    public IITAppTrackerAccountController(ApexPages.StandardController controller) {
        
        Current_Account_Id = controller.getRecord().id;
        
        String query = 'Select TargetX_SRMb__ceeb_code__c from Account Where Id = :Current_Account_Id';
        
        Account obj = database.query(query);
        Current_Account_Key = obj.TargetX_SRMb__ceeb_code__c;
        
        accessKey = System.currentPageReference().getParameters().get('k');
        
        if (Current_Account_Key == accessKey) {
            accessError = false;
        } else {
            accessError = true;
        }
        if (System.Today().Month()>=8) {
            Current_Academic_Year_Integer = System.Today().Year()+1;
            Current_Academic_Year_String = String.valueOf(System.Today().Year()+1);
        } else {
            Current_Academic_Year_Integer = System.Today().Year();
            Current_Academic_Year_String = String.valueOf(System.Today().Year());
        }
        Current_Date = System.Today();
        
    }
    
    public List<TargetX_SRMb__Application__c> getcontactApps(){
        List<TargetX_SRMb__Application__c> appList = [Select Id
                                                      , TargetX_SRMb__Contact__r.Name
                                                      , TargetX_SRMb__Start_Term_and_Year__c
                                                      , TargetX_SRMb__Possible_Academic_Major__c
                                                      , TargetX_SRMb__Status__c
                                                      , TargetX_SRMb__Application_Decision__c
                                                      , IIT_Deposit_Date__c
                                                      From TargetX_SRMb__Application__c
                                                      Where TargetX_SRMb__Contact__r.AccountId = :Current_Account_Id
                                                      And TargetX_SRMb__Contact__r.RecordTypeId = '012j0000000xaqj'
                                                      And TargetX_SRMb__Start_Term_Year__c = :Current_Academic_Year_String
                                                      And TargetX_App__Is_Test_Record__c = false
                                                      And TargetX_SRMb__Contact__r.IIT_Is_Test_Record__c = false
                                                      ORDER BY TargetX_SRMb__Contact__r.LastName,TargetX_SRMb__Contact__r.FirstName
                                                     ];
        return appList;
    }
    
    public List<Contact> getaccountContacts(){
        List<Contact> accountContacts = [Select Id
                                         , Name
                                         , TargetX_SRMb__Anticipated_Start_Term_Year__c
                                         , TargetX_SRMb__Anticipated_Major__c
                                         , TargetX_SRMb__Status__c
                                         From Contact
                                         Where AccountId = :Current_Account_Id
                                         And RecordTypeId='012j0000000xaqj'
                                         And TargetX_SRMb__Status__c in ('Inquiry','Registrant')
                                         And TargetX_SRMb__Anticipated_Start_Year__c >= :Current_Academic_Year_Integer
                                         And IIT_Is_Test_Record__c = false
                                         ORDER BY LastName,FirstName
                                        ];
        return accountContacts;
    }
    
    public List<TargetX_Eventsb__OrgEvent__c> getaccountEvents(){
		List<TargetX_Eventsb__OrgEvent__c> accountEvents = [Select Id
                                                            , Name
                                                            , TargetX_Eventsb__Start_Time_TZ_Adjusted__c
                                                            , IIT_Real_Start_Minutes__c
                                                            From TargetX_Eventsb__OrgEvent__c
                                                            Where TargetX_Eventsb__School__c = :Current_Account_Id
                                                            And TargetX_Eventsb__Start_Date_Time__c >= :Current_Date
                                                           ];
        return accountEvents;
    }
    
    public boolean getaccessError() {
        return accessError;
    }
    
}