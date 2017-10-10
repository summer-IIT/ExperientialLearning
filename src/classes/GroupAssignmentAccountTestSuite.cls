@isTest
private class GroupAssignmentAccountTestSuite {

    static testMethod void testGroupAssignment() {
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        
        User u = new User(Alias = 'standt', Email=uniqueName + '@test' + orgId + '.org', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName=uniqueName + '@test' + orgId + '.org');
            
        insert u;
        
        System.runAs (u) {
	        //  Make settings
	        TargetX_Group__Group_Assignment_Setting__c cSett = new TargetX_Group__Group_Assignment_Setting__c(
	            TargetX_Group__Object__c = 'Account', 
	            Name = 'Account',
	            TargetX_Group__Active__c = true,
	            TargetX_Group__Formula_Field__c = 'BillingState',
	            TargetX_Group__Owner_Field__c = 'OwnerId',
	            TargetX_Group__Use_Future__c = false
	        );
	        insert cSett;
	        
	        TargetX_Group__Assignment_Group__c grp = new TargetX_Group__Assignment_Group__c(
	            Name = 'IL',
	            TargetX_Group__Target_Object__c = 'Account',
	            TargetX_Group__Active__c = true
	        );
	        
	        insert grp;
	        
	        
	        TargetX_Group__Assignment_Group_Member__c mem = new TargetX_Group__Assignment_Group_Member__c(
	            TargetX_Group__Assignment_Group__c = grp.Id,
	            TargetX_Group__User__c = u.Id
	        );
	        
	        insert mem;
	
	        Account newAcc = new Account(
	            Name = 'Test Account'
	        );
	
	        insert newAcc;
	        
	        Id runningUserId = userInfo.getUserId();
	        
	        Account accToCheck = [select ownerid from account where id =: newAcc.Id];
	        system.assertEquals(accToCheck.OwnerId, runningUserId);
	        
	        newAcc.BillingState = 'IL';
	        update newAcc;
	        
	        accToCheck = [select ownerid from account where id =: newAcc.Id];
	        system.assertEquals(accToCheck.OwnerId, u.Id);
        }   
    }
}