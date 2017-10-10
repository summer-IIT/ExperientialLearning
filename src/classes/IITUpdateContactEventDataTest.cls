@isTest
public class IITUpdateContactEventDataTest {
	
    public static testMethod void IITUpdateContactEventDataTest() {
        
        Profile p = [Select Id from Profile where name = 'System Administrator'];
        
        User objU = new User(
        Alias = 'test'
        , Email = 'bwoods5+testuser@iit.edu'
        , EmailEncodingKey = 'UTF-8'
        , FirstName = 'Bryan'
        , LastName = 'Test'
        , LanguageLocaleKey = 'en_US'
        , LocaleSidKey = 'en_US'
        , ProfileId = p.Id
        , TimeZoneSidKey = 'America/Los_Angeles'
        , Username = 'bwoods5+testuser@iit.edu'
        , TargetX_Eventsb__Can_Own_Events__c = true
        , IsActive = true
		);
        insert objU;
        
        System.runAs(objU) {
            List<IITContactEvent__c> objs = new List<IITContactEvent__c>();
        
            objs.add(new IITContactEvent__c(
            	Name = 'Default'
            	, IIT_Anticipated_Start_Year__c = 2016
            	, IIT_Last_Modified_Days__c = 7
            ));
        
            objs.add(new IITContactEvent__c(
            	Name = 'Daily Visit'
            ));
                 
            objs.add(new IITContactEvent__c(
            	Name = 'Discover IIT Day'
            ));
            insert objs;
        
            Account objAcc = new Account(
            	Name = 'Test HS'
            	, TargetX_SRMb__ceeb_code__c = '111111'
            	, RecordTypeId = '012j0000000zCdB'
            );
            insert objAcc;
        
        	Contact objCon = new Contact(
        		FirstName = 'Fname'
        		, LastName = 'Lname'
        		, AccountId = objAcc.Id
        		, Email = 'bwoods5+test@iit.edu'
        		, TargetX_SRMb__Anticipated_Start_Term__c = 'Fall'
        		, TargetX_SRMb__Anticipated_Start_Year__c = 2017
        		, RecordTypeId = '012j0000000xaqj'
        	);
        	insert objCon;
        
        	TargetX_Eventsb__OrgEvent__c objOE = new TargetX_Eventsb__OrgEvent__c(
        		Name = 'Discover Day Test'
        		, TargetX_Eventsb__Category__c = 'Undergraduate Admissions'
        		, TargetX_Eventsb__type__c = 'Discover IIT Day'
        		, TargetX_Eventsb__Start_Date_Time__c = datetime.newInstance(2016,8,1,8,00,0)
        		, TargetX_Eventsb__End_Date_Time__c = datetime.newInstance(2016,8,1,15,00,0)
        		, TargetX_Eventsb__Time_Zone__c = 'America/Chicago'
        		, OwnerId = objU.Id
        	);
			insert objOE;
        
        	TargetX_Eventsb__ContactScheduleItem__c objCSI = new TargetX_Eventsb__ContactScheduleItem__c(
        		TargetX_Eventsb__Contact__c = objCon.Id
        	, TargetX_Eventsb__OrgEvent__c = objOE.Id
       		, TargetX_Eventsb__Attended__c = true
        	);
        	insert objCSI;
        }
        
		Database.executeBatch(new IITUpdateContactEventDataBatch(), 200);
        
        String jobId = System.schedule('ScheduleApexClassTest', '0 0 0 15 3 ? 2022', new IITUpdateContactEventDataBatchScheduler());
        
    }
    
}