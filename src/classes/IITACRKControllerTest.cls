@isTest
public class IITACRKControllerTest {
	
    public static testMethod void IITACRKControllerTest() {
        
        //Create and Insert Test Accounts
        List<Account> accountsToInsert = new List<Account>();
        
        Account objAcc = new Account(Name = 'Test HS 0', TargetX_SRMb__ceeb_code__c = '0', IIT_Highschool_Quality__c = 0.958
                                     , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 1', TargetX_SRMb__ceeb_code__c = '1', IIT_Highschool_Quality__c = 0.775
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 2', TargetX_SRMb__ceeb_code__c = '2', IIT_Highschool_Quality__c = 0.643
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 3', TargetX_SRMb__ceeb_code__c = '3', IIT_Highschool_Quality__c = 0.6
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 4', TargetX_SRMb__ceeb_code__c = '4', IIT_Highschool_Quality__c = 0.299
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 5', TargetX_SRMb__ceeb_code__c = '5', IIT_Highschool_Quality__c = 0.9
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 6', TargetX_SRMb__ceeb_code__c = '6', IIT_Highschool_Quality__c = 0.716
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 7', TargetX_SRMb__ceeb_code__c = '7', IIT_Highschool_Quality__c = 0.65
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 8', TargetX_SRMb__ceeb_code__c = '8', IIT_Highschool_Quality__c = 0.92
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 9', TargetX_SRMb__ceeb_code__c = '9', IIT_Highschool_Quality__c = 0.341
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 10', TargetX_SRMb__ceeb_code__c = '10', IIT_Highschool_Quality__c = 0.81
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 11', TargetX_SRMb__ceeb_code__c = '11', IIT_Highschool_Quality__c = 0.25
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 12', TargetX_SRMb__ceeb_code__c = '12', IIT_Highschool_Quality__c = 0.963
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 13', TargetX_SRMb__ceeb_code__c = '13', IIT_Highschool_Quality__c = 0.095
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 14', TargetX_SRMb__ceeb_code__c = '14', IIT_Highschool_Quality__c = 0.778
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 15', TargetX_SRMb__ceeb_code__c = '15', IIT_Highschool_Quality__c = 0.911
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 16', TargetX_SRMb__ceeb_code__c = '16', IIT_Highschool_Quality__c = 0.772
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 17', TargetX_SRMb__ceeb_code__c = '17', IIT_Highschool_Quality__c = 0.935
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 18', TargetX_SRMb__ceeb_code__c = '18', IIT_Highschool_Quality__c = 0.65
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 19', TargetX_SRMb__ceeb_code__c = '19', IIT_Highschool_Quality__c = 0.926
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 20', TargetX_SRMb__ceeb_code__c = '20', IIT_Highschool_Quality__c = 0.872
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 21', TargetX_SRMb__ceeb_code__c = '21', IIT_Highschool_Quality__c = 0.4
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 22', TargetX_SRMb__ceeb_code__c = '22', IIT_Highschool_Quality__c = 0.814
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
        
        objAcc = new Account(Name = 'Test HS 23', TargetX_SRMb__ceeb_code__c = '23', IIT_Highschool_Quality__c = 0.915
                             , IIT_HS_Build_Flag__c = false, IIT_HS_GPA_Scale_Flag__c = '', RecordTypeId = '012j0000000zCdB');
        accountsToInsert.add(objAcc);
                
        insert accountsToInsert;
        
        
        //Create and Insert Test Contacts
        List<Contact> contactsToInsert = new List<Contact>();
        
        Contact objCon = new Contact(AccountId = accountsToInsert[0].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test0@iit.edu'
                                     , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Female', TargetX_SRMb__IPEDS_Hispanic__c = false
                                     , TargetX_SRMb__IPEDS_Ethnicities__c = 'Asian', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[1].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test1@iit.edu'
                             , MailingState = 'WI', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'White', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[2].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test2@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'Asian', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[3].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test3@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = true
                             , TargetX_SRMb__IPEDS_Ethnicities__c = '', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[4].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test4@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Female', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'White', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[5].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test5@iit.edu'
                             , MailingState = 'MN', TargetX_SRMb__Gender__c = 'Female', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'White', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[6].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test6@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'White', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[7].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test7@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = true
                             , TargetX_SRMb__IPEDS_Ethnicities__c = '', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[8].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test8@iit.edu'
                             , MailingState = 'CA', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'Asian', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[9].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test9@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Female', TargetX_SRMb__IPEDS_Hispanic__c = true
                             , TargetX_SRMb__IPEDS_Ethnicities__c = '', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[10].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test10@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = true
                             , TargetX_SRMb__IPEDS_Ethnicities__c = '', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[11].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test11@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = '', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[12].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test12@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Female', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'White', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[13].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test13@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = true
                             , TargetX_SRMb__IPEDS_Ethnicities__c = '', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[14].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test14@iit.edu'
                             , MailingState = 'TN', TargetX_SRMb__Gender__c = 'Female', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'White', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[15].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test15@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Female', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'Asian', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[16].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test16@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Female', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'Asian', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[17].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test17@iit.edu'
                             , MailingState = 'MI', TargetX_SRMb__Gender__c = 'Female', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'White', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[18].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test18@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = true
                             , TargetX_SRMb__IPEDS_Ethnicities__c = '', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[19].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test19@iit.edu'
                             , MailingState = 'CA', TargetX_SRMb__Gender__c = 'Female', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'White', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[16].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test20@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = true
                             , TargetX_SRMb__IPEDS_Ethnicities__c = '', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[20].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test21@iit.edu'
                             , MailingState = 'PA', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'White', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[21].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test22@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'White', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[22].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test23@iit.edu'
                             , MailingState = 'IL', TargetX_SRMb__Gender__c = 'Female', TargetX_SRMb__IPEDS_Hispanic__c = true
                             , TargetX_SRMb__IPEDS_Ethnicities__c = '', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        objCon = new Contact(AccountId = accountsToInsert[23].Id, FirstName = 'Fname', LastName = 'Lname', Email = 'bwoods5+test24@iit.edu'
                             , MailingState = 'IN', TargetX_SRMb__Gender__c = 'Male', TargetX_SRMb__IPEDS_Hispanic__c = false
                             , TargetX_SRMb__IPEDS_Ethnicities__c = 'White', RecordTypeId = '012j0000000xaqj');
        contactsToInsert.add(objCon);
        
        insert contactsToInsert;
        
        
        //Create and Insert Test Tests
        List<TargetX_SRMb__Test__c> testsToInsert = new List<TargetX_SRMb__Test__c>();
        
        TargetX_SRMb__Test__c objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[0].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 31
                                                                  , TargetX_SRMb__ACT_English_Score__c = 30, TargetX_SRMb__ACT_Math_Score__c = 34
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 30, TargetX_SRMb__ACT_Science_Score__c = 30
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[1].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 31
                                                                  , TargetX_SRMb__ACT_English_Score__c = 30, TargetX_SRMb__ACT_Math_Score__c = 35
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 30, TargetX_SRMb__ACT_Science_Score__c = 30
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[2].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 28
                                                                  , TargetX_SRMb__ACT_English_Score__c = 26, TargetX_SRMb__ACT_Math_Score__c = 35
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 26, TargetX_SRMb__ACT_Science_Score__c = 26
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[3].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 26
                                                                  , TargetX_SRMb__ACT_English_Score__c = 26, TargetX_SRMb__ACT_Math_Score__c = 26
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 26, TargetX_SRMb__ACT_Science_Score__c = 26
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[4].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 31
                                                                  , TargetX_SRMb__ACT_English_Score__c = 31, TargetX_SRMb__ACT_Math_Score__c = 32
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 31, TargetX_SRMb__ACT_Science_Score__c = 31
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[5].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 27
                                                                  , TargetX_SRMb__ACT_English_Score__c = 27, TargetX_SRMb__ACT_Math_Score__c = 26
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 27, TargetX_SRMb__ACT_Science_Score__c = 27
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[6].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 33
                                                                  , TargetX_SRMb__ACT_English_Score__c = 33, TargetX_SRMb__ACT_Math_Score__c = 33
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 33, TargetX_SRMb__ACT_Science_Score__c = 33
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[7].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 27
                                                                  , TargetX_SRMb__ACT_English_Score__c = 27, TargetX_SRMb__ACT_Math_Score__c = 26
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 27, TargetX_SRMb__ACT_Science_Score__c = 27
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[8].Id, Name = 'SAT I', TargetX_SRMb__Test__c = 'SAT I'
                                            , TargetX_SRMb__Score_Validated__c = true, RecordTypeId = '012j0000000xaqs'
                                            , TargetX_SRMb__SAT_I_Math_Score__c = 550, TargetX_SRMb__SAT_I_Verbal_Score__c = 500
											, TargetX_SRMb__Test_Date__c = System.today());
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[9].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 32
                                                                  , TargetX_SRMb__ACT_English_Score__c = 34, TargetX_SRMb__ACT_Math_Score__c = 27
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 34, TargetX_SRMb__ACT_Science_Score__c = 34
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[9].Id, Name = 'SAT I', TargetX_SRMb__Test__c = 'SAT I'
                                            , TargetX_SRMb__Score_Validated__c = true, RecordTypeId = '012j0000000xaqs'
                                            , TargetX_SRMb__SAT_I_Math_Score__c = 580, TargetX_SRMb__SAT_I_Verbal_Score__c = 660
                                            , TargetX_SRMb__Test_Date__c = System.today());
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[10].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 27
                                                                  , TargetX_SRMb__ACT_English_Score__c = 27, TargetX_SRMb__ACT_Math_Score__c = 26
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 27, TargetX_SRMb__ACT_Science_Score__c = 27
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[11].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 25
                                                                  , TargetX_SRMb__ACT_English_Score__c = 25, TargetX_SRMb__ACT_Math_Score__c = 26
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 25, TargetX_SRMb__ACT_Science_Score__c = 25
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[12].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 32
                                                                  , TargetX_SRMb__ACT_English_Score__c = 33, TargetX_SRMb__ACT_Math_Score__c = 30
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 33, TargetX_SRMb__ACT_Science_Score__c = 33
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[13].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 21
                                                                  , TargetX_SRMb__ACT_English_Score__c = 21, TargetX_SRMb__ACT_Math_Score__c = 22
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 21, TargetX_SRMb__ACT_Science_Score__c = 21
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[14].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 32
                                                                  , TargetX_SRMb__ACT_English_Score__c = 34, TargetX_SRMb__ACT_Math_Score__c = 27
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 34, TargetX_SRMb__ACT_Science_Score__c = 34
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[15].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 34
                                                                  , TargetX_SRMb__ACT_English_Score__c = 34, TargetX_SRMb__ACT_Math_Score__c = 33
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 34, TargetX_SRMb__ACT_Science_Score__c = 34
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[16].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 27
                                                                  , TargetX_SRMb__ACT_English_Score__c = 27, TargetX_SRMb__ACT_Math_Score__c = 26
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 27, TargetX_SRMb__ACT_Science_Score__c = 27
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[17].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 29
                                                                  , TargetX_SRMb__ACT_English_Score__c = 30, TargetX_SRMb__ACT_Math_Score__c = 27
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 30, TargetX_SRMb__ACT_Science_Score__c = 30
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[18].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 25
                                                                  , TargetX_SRMb__ACT_English_Score__c = 25, TargetX_SRMb__ACT_Math_Score__c = 25
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 25, TargetX_SRMb__ACT_Science_Score__c = 25
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[19].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 30
                                                                  , TargetX_SRMb__ACT_English_Score__c = 32, TargetX_SRMb__ACT_Math_Score__c = 24
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 32, TargetX_SRMb__ACT_Science_Score__c = 32
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[19].Id, Name = 'SAT I', TargetX_SRMb__Test__c = 'SAT I'
                                            , TargetX_SRMb__Score_Validated__c = true, RecordTypeId = '012j0000000xaqs'
                                            , TargetX_SRMb__SAT_I_Math_Score__c = 640, TargetX_SRMb__SAT_I_Verbal_Score__c = 680
                                            , TargetX_SRMb__Test_Date__c = System.today());
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[20].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 25
                                                                  , TargetX_SRMb__ACT_English_Score__c = 25, TargetX_SRMb__ACT_Math_Score__c = 25
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 25, TargetX_SRMb__ACT_Science_Score__c = 25
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[21].Id, Name = 'SAT I', TargetX_SRMb__Test__c = 'SAT I'
                                            , TargetX_SRMb__Score_Validated__c = true, RecordTypeId = '012j0000000xaqs'
                                            , TargetX_SRMb__SAT_I_Math_Score__c = 680, TargetX_SRMb__SAT_I_Verbal_Score__c = 650
                                            , TargetX_SRMb__Test_Date__c = System.today());
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[22].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 31
                                                                  , TargetX_SRMb__ACT_English_Score__c = 31, TargetX_SRMb__ACT_Math_Score__c = 31
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 31, TargetX_SRMb__ACT_Science_Score__c = 31
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[23].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 28
                                                                  , TargetX_SRMb__ACT_English_Score__c = 29, TargetX_SRMb__ACT_Math_Score__c = 24
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 29, TargetX_SRMb__ACT_Science_Score__c = 29
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[24].Id, Name = 'ACT'
                                                                  , TargetX_SRMb__Test__c = 'ACT', TargetX_SRMb__Score_Validated__c = true
                                                                  , RecordTypeId = '012j0000000xaqm', TargetX_SRMb__ACT_Composite_Score__c = 25
                                                                  , TargetX_SRMb__ACT_English_Score__c = 24, TargetX_SRMb__ACT_Math_Score__c = 28
                                                                  , TargetX_SRMb__ACT_Reading_Score__c = 24, TargetX_SRMb__ACT_Science_Score__c = 24
                                                                  , TargetX_SRMb__Test_Date__c = System.today());        
        testsToInsert.add(objTest);
        
        objTest = new TargetX_SRMb__Test__c(TargetX_SRMb__Contact__c = contactsToInsert[24].Id, Name = 'SAT I', TargetX_SRMb__Test__c = 'SAT I'
                                            , TargetX_SRMb__Score_Validated__c = true, RecordTypeId = '012j0000000xaqs'
                                            , TargetX_SRMb__SAT_I_Math_Score__c = 690, TargetX_SRMb__SAT_I_Verbal_Score__c = 620
											, TargetX_SRMb__Test_Date__c = System.today());
        testsToInsert.add(objTest);
        
        insert testsToInsert;
        
        
        //Create and Insert Test Applications
        List<TargetX_SRMb__Application__c> applicationsToInsert = new List<TargetX_SRMb__Application__c>();
        
        TargetX_SRMb__Application__c objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                                               , TargetX_SRMb__Contact__c = contactsToInsert[0].Id
                                                                               , TargetX_SRMb__Stage__c = 'Submitted'
                                                                               , TargetX_SRMb__Status__c = 'Complete'
                                                                               , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                                               , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                                               , IIT_Application_Start_Date__c = System.today()
                                                                               , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                                               , TargetX_SRMb__Start_Term__c = 'Fall'
                                                                               , TargetX_SRMb__Start_Term_Year__c = '2017'
                                                                               , TargetX_SRMb__Level__c = 'Undergraduate'
                                                                               , TargetX_SRMb__Student_Type__c = 'First Year'
                                                                               , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                                               , TargetX_SRMb__Possible_Academic_Major__c = 'Biomedical Engineering'
                                                                               , TargetX_SRMb__College__c = 'Armour College of Engineering'
                                                                               , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[1].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Applied Mathematics'
                                                  , TargetX_SRMb__College__c = 'College of Science'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[2].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Civil Engineering'
                                                  , TargetX_SRMb__College__c = 'Armour College of Engineering'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[3].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Computer Science'
                                                  , TargetX_SRMb__College__c = 'College of Science'
                                                  , TargetX_SRMb__Housing__c = 'Commuter');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[4].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Aerospace Engineering'
                                                  , TargetX_SRMb__College__c = 'Armour College of Engineering'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[5].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Professional Bachelor'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Architecture'
                                                  , TargetX_SRMb__College__c = 'College of Architecture'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[6].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Professional Bachelor'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Architecture'
                                                  , TargetX_SRMb__College__c = 'College of Architecture'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[7].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Mechanical Engineering'
                                                  , TargetX_SRMb__College__c = 'Armour College of Engineering'
                                                  , TargetX_SRMb__Housing__c = 'Commuter');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[8].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Business Administration'
                                                  , TargetX_SRMb__College__c = 'Stuart School of Business'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[9].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Computer Science'
                                                  , TargetX_SRMb__College__c = 'College of Science'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[10].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Material Science and Engineering'
                                                  , TargetX_SRMb__College__c = 'Armour College of Engineering'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[11].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Computer Engineering'
                                                  , TargetX_SRMb__College__c = 'Armour College of Engineering'
                                                  , TargetX_SRMb__Housing__c = 'Commuter');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[12].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Chemistry'
                                                  , TargetX_SRMb__College__c = 'College of Science'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[13].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Professional Bachelor'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Information Technology and Management'
                                                  , TargetX_SRMb__College__c = 'School of Applied Technology'
                                                  , TargetX_SRMb__Housing__c = 'Commuter');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[14].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Psychology'
                                                  , TargetX_SRMb__College__c = 'Lewis College of Human Sciences'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[15].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Social and Economic Development Policy'
                                                  , TargetX_SRMb__College__c = 'Lewis College of Human Sciences'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[16].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Psychology'
                                                  , TargetX_SRMb__College__c = 'Lewis College of Human Sciences'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[17].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Biology'
                                                  , TargetX_SRMb__College__c = 'College of Science'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[18].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Undecided Human Science'
                                                  , TargetX_SRMb__College__c = 'Lewis College of Human Sciences'
                                                  , TargetX_SRMb__Housing__c = 'Commuter');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[19].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Biology'
                                                  , TargetX_SRMb__College__c = 'College of Science'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[20].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Electrical Engineering'
                                                  , TargetX_SRMb__College__c = 'Armour College of Engineering'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[21].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Professional Bachelor'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Architecture'
                                                  , TargetX_SRMb__College__c = 'College of Architecture'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[22].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Computer Information Systems'
                                                  , TargetX_SRMb__College__c = 'College of Science'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[23].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Psychology'
                                                  , TargetX_SRMb__College__c = 'Lewis College of Human Sciences'
                                                  , TargetX_SRMb__Housing__c = 'Commuter');
        applicationsToInsert.add(objApp);
        
        objApp = new TargetX_SRMb__Application__c(RecordTypeId = '012j0000000n198'
                                                  , TargetX_SRMb__Contact__c = contactsToInsert[24].Id
                                                  , TargetX_SRMb__Stage__c = 'Submitted', TargetX_SRMb__Status__c = 'Complete'
                                                  , IIT_Application_Processing_Status__c = 'Pending Initial Review'
                                                  , TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic'
                                                  , IIT_Application_Start_Date__c = System.today()
                                                  , TargetX_SRMb__Application_Submit_Date__c = System.today()
                                                  , TargetX_SRMb__Start_Term__c = 'Fall', TargetX_SRMb__Start_Term_Year__c = '2017'
                                                  , TargetX_SRMb__Level__c = 'Undergraduate', TargetX_SRMb__Student_Type__c = 'First Year'
                                                  , TargetX_SRMb__Degree__c = 'Bachelor of Science'
                                                  , TargetX_SRMb__Possible_Academic_Major__c = 'Computer Science'
                                                  , TargetX_SRMb__College__c = 'College of Science'
                                                  , TargetX_SRMb__Housing__c = 'On Campus');
        applicationsToInsert.add(objApp);
        
        insert applicationsToInsert;
        
        
        //Create and Insert Test Enrollment Histories
        List<TargetX_SRMb__Enrollment_History__c> enrollmenthistoriesToInsert = new List<TargetX_SRMb__Enrollment_History__c>();
        
        TargetX_SRMb__Enrollment_History__c objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                                                            , TargetX_SRMb__Contact__c = contactsToInsert[0].Id
                                                                                            , TargetX_SRMb__Application__c = applicationsToInsert[0].Id
                                                                                            , TargetX_SRMb__Account__c = accountsToInsert[0].Id
                                                                                            , RecordTypeId = '012j0000000xaql'
                                                                                            , TargetX_SRMb__End_Date__c = System.today()
                                                                                            , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                                                            , TargetX_SRMb__Official_GPA__c = 5.091
                                                                                            , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                                                            , TargetX_SRMb__Official_Class_Rank__c = ''
                                                                                            , TargetX_SRMb__Official_Class_Size__c = 252);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[1].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[1].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[1].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 4.255
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = '1'
                                                        , TargetX_SRMb__Official_Class_Size__c = 71);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[2].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[2].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[2].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 4.3
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 495);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[3].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[3].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[3].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 4.31
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 151);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[4].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[4].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[4].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 4.316
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = '9'
                                                        , TargetX_SRMb__Official_Class_Size__c = 376);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[5].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[5].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[5].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 3.470
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 86);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[6].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[6].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[6].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 3.704
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 492);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[7].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[7].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[7].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 4.59
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = '16'
                                                        , TargetX_SRMb__Official_Class_Size__c = 198);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[8].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[8].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[8].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 3.135
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 695);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[9].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[9].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[9].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 4.676
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = '18'
                                                        , TargetX_SRMb__Official_Class_Size__c = 612);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[10].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[10].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[10].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 3.946
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 370);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[11].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[11].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[11].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 5.07
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = '4'
                                                        , TargetX_SRMb__Official_Class_Size__c = 694);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[12].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[12].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[12].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 4.4
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 508);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[13].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[13].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[13].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 2.7
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = '448'
                                                        , TargetX_SRMb__Official_Class_Size__c = 695);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[14].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[14].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[14].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 4.0
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 53);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[15].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[15].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[15].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 4.171
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 556);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[16].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[16].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[16].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 3.4
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 630);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[17].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[17].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[17].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 3.4
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 497);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[18].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[18].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[18].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 3.75
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = '353'
                                                        , TargetX_SRMb__Official_Class_Size__c = 448);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[19].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[19].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[19].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 3.160
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 600);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[20].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[20].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[16].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 3.5
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 630);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[21].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[21].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[20].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 3.59
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = null);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[22].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[22].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[21].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 4.16
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = '60'
                                                        , TargetX_SRMb__Official_Class_Size__c = 673);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[23].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[23].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[23].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 3.92
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = '183'
                                                        , TargetX_SRMb__Official_Class_Size__c = 840);
        enrollmenthistoriesToInsert.add(objEH);
        
        objEH = new TargetX_SRMb__Enrollment_History__c(Name = objAcc.Name
                                                        , TargetX_SRMb__Contact__c = contactsToInsert[24].Id
                                                        , TargetX_SRMb__Application__c = applicationsToInsert[24].Id
                                                        , TargetX_SRMb__Account__c = accountsToInsert[23].Id
                                                        , RecordTypeId = '012j0000000xaql'
                                                        , TargetX_SRMb__End_Date__c = System.today()
                                                        , TargetX_SRMb__Start_Date__c = System.today().addYears(-3)
                                                        , TargetX_SRMb__Official_GPA__c = 3.217
                                                        , TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale'
                                                        , TargetX_SRMb__Official_Class_Rank__c = ''
                                                        , TargetX_SRMb__Official_Class_Size__c = 1303);
        enrollmenthistoriesToInsert.add(objEH);
        
        insert enrollmenthistoriesToInsert;
        
        
        //Create and Insert Test App Review Types
        TargetX_Reader__Application_Review_Type__c objAppRevType = new TargetX_Reader__Application_Review_Type__c();
        objAppRevType.Name = 'UG Initial Review FY US';
        insert objAppRevType;
        
        
        //Create and Insert Test App Reviews
        List <TargetX_Reader__Application_Review__c> appreviewsToInsert = new List<TargetX_Reader__Application_Review__c>();
        
        TargetX_Reader__Application_Review__c objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                                                                    , TargetX_Reader__Application__c = applicationsToInsert[0].Id
                                                                                                    , IIT_Level__c = 'Undergraduate'
                                                                                                    , IIT_Highest_Math__c = 'AP Calculus and Higher'
                                                                                                    , IIT_Rigor_Rating__c = 'Majority');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[1].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'AP Calculus and Higher'
                                                              , IIT_Rigor_Rating__c = 'Majority');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[2].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'AP Calculus and Higher'
                                                              , IIT_Rigor_Rating__c = 'Majority');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[3].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Calculus'
                                                              , IIT_Rigor_Rating__c = 'Medium');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[4].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'AP Calculus and Higher'
                                                              , IIT_Rigor_Rating__c = 'Medium');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[5].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Pre-Calculus'
                                                              , IIT_Rigor_Rating__c = 'Basic');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[6].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'AP Calculus and Higher'
                                                              , IIT_Rigor_Rating__c = 'Medium');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[7].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'AP Calculus and Higher'
                                                              , IIT_Rigor_Rating__c = 'Majority');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[8].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Below Pre-Calculus'
                                                              , IIT_Rigor_Rating__c = 'Basic');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[9].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'AP Calculus and Higher'
                                                              , IIT_Rigor_Rating__c = 'Medium');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[10].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Pre-Calculus'
                                                              , IIT_Rigor_Rating__c = 'Basic');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[11].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'AP Calculus and Higher'
                                                              , IIT_Rigor_Rating__c = 'Majority');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[12].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'AP Calculus and Higher'
                                                              , IIT_Rigor_Rating__c = 'Majority');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[13].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Below Pre-Calculus'
                                                              , IIT_Rigor_Rating__c = 'Basic');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[14].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Calculus'
                                                              , IIT_Rigor_Rating__c = 'Medium');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[15].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'AP Calculus and Higher'
                                                              , IIT_Rigor_Rating__c = 'Majority');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[16].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Pre-Calculus'
                                                              , IIT_Rigor_Rating__c = 'Basic');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[17].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Pre-Calculus'
                                                              , IIT_Rigor_Rating__c = 'Basic');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[18].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Below Pre-Calculus'
                                                              , IIT_Rigor_Rating__c = 'Basic');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[19].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Pre-Calculus'
                                                              , IIT_Rigor_Rating__c = 'Medium');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[20].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Below Pre-Calculus'
                                                              , IIT_Rigor_Rating__c = 'Basic');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[21].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Pre-Calculus'
                                                              , IIT_Rigor_Rating__c = 'Medium');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[22].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'AP Calculus and Higher'
                                                              , IIT_Rigor_Rating__c = 'Medium');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[23].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Pre-Calculus'
                                                              , IIT_Rigor_Rating__c = 'Medium');
        appreviewsToInsert.add(objAppRev);
        
        objAppRev = new TargetX_Reader__Application_Review__c(TargetX_Reader__Application_Review_Type__c = objAppRevType.Id
                                                              , TargetX_Reader__Application__c = applicationsToInsert[24].Id
                                                              , IIT_Level__c = 'Undergraduate'
                                                              , IIT_Highest_Math__c = 'Calculus'
                                                              , IIT_Rigor_Rating__c = 'Basic');
        appreviewsToInsert.add(objAppRev);
        
        insert appreviewsToInsert;
        
        
        //Create and Insert Test Custom Settings
		List<IITRSATTotalToSATComposite__c> customSettings1ToInsert = new List<IITRSATTotalToSATComposite__c>();
        IITRSATTotalToSATComposite__c customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='400',IIT_SAT_Composite__c=400); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='410',IIT_SAT_Composite__c=410); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='420',IIT_SAT_Composite__c=410); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='430',IIT_SAT_Composite__c=420); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='440',IIT_SAT_Composite__c=430); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='450',IIT_SAT_Composite__c=430); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='460',IIT_SAT_Composite__c=440); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='470',IIT_SAT_Composite__c=450); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='480',IIT_SAT_Composite__c=450); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='490',IIT_SAT_Composite__c=460); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='500',IIT_SAT_Composite__c=470); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='510',IIT_SAT_Composite__c=470); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='520',IIT_SAT_Composite__c=480); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='530',IIT_SAT_Composite__c=490); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='540',IIT_SAT_Composite__c=490); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='550',IIT_SAT_Composite__c=500); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='560',IIT_SAT_Composite__c=510); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='570',IIT_SAT_Composite__c=510); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='580',IIT_SAT_Composite__c=520); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='590',IIT_SAT_Composite__c=530); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='600',IIT_SAT_Composite__c=540); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='610',IIT_SAT_Composite__c=540); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='620',IIT_SAT_Composite__c=550); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='630',IIT_SAT_Composite__c=560); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='640',IIT_SAT_Composite__c=560); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='650',IIT_SAT_Composite__c=570); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='660',IIT_SAT_Composite__c=580); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='670',IIT_SAT_Composite__c=580); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='680',IIT_SAT_Composite__c=590); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='690',IIT_SAT_Composite__c=600); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='700',IIT_SAT_Composite__c=600); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='710',IIT_SAT_Composite__c=610); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='720',IIT_SAT_Composite__c=620); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='730',IIT_SAT_Composite__c=630); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='740',IIT_SAT_Composite__c=640); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='750',IIT_SAT_Composite__c=660); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='760',IIT_SAT_Composite__c=670); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='770',IIT_SAT_Composite__c=680); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='780',IIT_SAT_Composite__c=690); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='790',IIT_SAT_Composite__c=700); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='800',IIT_SAT_Composite__c=710); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='810',IIT_SAT_Composite__c=720); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='820',IIT_SAT_Composite__c=730); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='830',IIT_SAT_Composite__c=740); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='840',IIT_SAT_Composite__c=750); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='850',IIT_SAT_Composite__c=760); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='860',IIT_SAT_Composite__c=780); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='870',IIT_SAT_Composite__c=790); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='880',IIT_SAT_Composite__c=800); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='890',IIT_SAT_Composite__c=810); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='900',IIT_SAT_Composite__c=820); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='910',IIT_SAT_Composite__c=830); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='920',IIT_SAT_Composite__c=840); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='930',IIT_SAT_Composite__c=850); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='940',IIT_SAT_Composite__c=860); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='950',IIT_SAT_Composite__c=870); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='960',IIT_SAT_Composite__c=880); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='970',IIT_SAT_Composite__c=890); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='980',IIT_SAT_Composite__c=900); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='990',IIT_SAT_Composite__c=910); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1000',IIT_SAT_Composite__c=920); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1010',IIT_SAT_Composite__c=930); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1020',IIT_SAT_Composite__c=940); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1030',IIT_SAT_Composite__c=950); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1040',IIT_SAT_Composite__c=960); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1050',IIT_SAT_Composite__c=970); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1060',IIT_SAT_Composite__c=980); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1070',IIT_SAT_Composite__c=990); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1080',IIT_SAT_Composite__c=1000); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1090',IIT_SAT_Composite__c=1010); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1100',IIT_SAT_Composite__c=1020); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1110',IIT_SAT_Composite__c=1030); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1120',IIT_SAT_Composite__c=1040); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1130',IIT_SAT_Composite__c=1060); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1140',IIT_SAT_Composite__c=1070); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1150',IIT_SAT_Composite__c=1080); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1160',IIT_SAT_Composite__c=1090); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1170',IIT_SAT_Composite__c=1100); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1180',IIT_SAT_Composite__c=1110); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1190',IIT_SAT_Composite__c=1120); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1200',IIT_SAT_Composite__c=1130); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1210',IIT_SAT_Composite__c=1140); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1220',IIT_SAT_Composite__c=1150); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1230',IIT_SAT_Composite__c=1160); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1240',IIT_SAT_Composite__c=1170); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1250',IIT_SAT_Composite__c=1180); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1260',IIT_SAT_Composite__c=1190); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1270',IIT_SAT_Composite__c=1200); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1280',IIT_SAT_Composite__c=1210); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1290',IIT_SAT_Composite__c=1220); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1300',IIT_SAT_Composite__c=1230); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1310',IIT_SAT_Composite__c=1250); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1320',IIT_SAT_Composite__c=1260); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1330',IIT_SAT_Composite__c=1270); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1340',IIT_SAT_Composite__c=1280); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1350',IIT_SAT_Composite__c=1290); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1360',IIT_SAT_Composite__c=1300); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1370',IIT_SAT_Composite__c=1310); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1380',IIT_SAT_Composite__c=1320); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1390',IIT_SAT_Composite__c=1330); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1400',IIT_SAT_Composite__c=1340); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1410',IIT_SAT_Composite__c=1350); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1420',IIT_SAT_Composite__c=1370); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1430',IIT_SAT_Composite__c=1380); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1440',IIT_SAT_Composite__c=1390); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1450',IIT_SAT_Composite__c=1400); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1460',IIT_SAT_Composite__c=1410); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1470',IIT_SAT_Composite__c=1420); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1480',IIT_SAT_Composite__c=1430); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1490',IIT_SAT_Composite__c=1450); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1500',IIT_SAT_Composite__c=1460); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1510',IIT_SAT_Composite__c=1470); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1520',IIT_SAT_Composite__c=1490); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1530',IIT_SAT_Composite__c=1500); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1540',IIT_SAT_Composite__c=1510); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1550',IIT_SAT_Composite__c=1530); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1560',IIT_SAT_Composite__c=1540); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1570',IIT_SAT_Composite__c=1560); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1580',IIT_SAT_Composite__c=1570); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1590',IIT_SAT_Composite__c=1580); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='1600',IIT_SAT_Composite__c=1600); customSettings1ToInsert.add(customSetting1ToInsert);
        customSetting1ToInsert = new IITRSATTotalToSATComposite__c(Name='0',IIT_SAT_Composite__c=0); customSettings1ToInsert.add(customSetting1ToInsert);
		insert customSettings1ToInsert;
		
		List<IITRSATMathToSATMath__c> customSettings2ToInsert = new List<IITRSATMathToSATMath__c>();
        IITRSATMathToSATMath__c customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='200',IIT_SAT_Math__c=200); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='210',IIT_SAT_Math__c=200); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='220',IIT_SAT_Math__c=210); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='230',IIT_SAT_Math__c=220); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='240',IIT_SAT_Math__c=220); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='250',IIT_SAT_Math__c=230); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='260',IIT_SAT_Math__c=240); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='270',IIT_SAT_Math__c=240); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='280',IIT_SAT_Math__c=250); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='290',IIT_SAT_Math__c=260); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='300',IIT_SAT_Math__c=260); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='310',IIT_SAT_Math__c=270); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='320',IIT_SAT_Math__c=280); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='330',IIT_SAT_Math__c=280); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='340',IIT_SAT_Math__c=290); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='350',IIT_SAT_Math__c=300); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='360',IIT_SAT_Math__c=310); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='370',IIT_SAT_Math__c=330); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='380',IIT_SAT_Math__c=340); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='390',IIT_SAT_Math__c=350); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='400',IIT_SAT_Math__c=360); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='410',IIT_SAT_Math__c=370); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='420',IIT_SAT_Math__c=380); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='430',IIT_SAT_Math__c=390); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='440',IIT_SAT_Math__c=400); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='450',IIT_SAT_Math__c=410); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='460',IIT_SAT_Math__c=420); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='470',IIT_SAT_Math__c=430); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='480',IIT_SAT_Math__c=440); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='490',IIT_SAT_Math__c=450); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='500',IIT_SAT_Math__c=460); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='510',IIT_SAT_Math__c=470); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='520',IIT_SAT_Math__c=490); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='530',IIT_SAT_Math__c=500); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='540',IIT_SAT_Math__c=510); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='550',IIT_SAT_Math__c=520); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='560',IIT_SAT_Math__c=530); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='570',IIT_SAT_Math__c=550); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='580',IIT_SAT_Math__c=560); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='590',IIT_SAT_Math__c=570); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='600',IIT_SAT_Math__c=580); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='610',IIT_SAT_Math__c=590); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='620',IIT_SAT_Math__c=600); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='630',IIT_SAT_Math__c=610); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='640',IIT_SAT_Math__c=620); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='650',IIT_SAT_Math__c=630); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='660',IIT_SAT_Math__c=640); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='670',IIT_SAT_Math__c=650); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='680',IIT_SAT_Math__c=650); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='690',IIT_SAT_Math__c=660); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='700',IIT_SAT_Math__c=670); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='710',IIT_SAT_Math__c=680); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='720',IIT_SAT_Math__c=690); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='730',IIT_SAT_Math__c=700); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='740',IIT_SAT_Math__c=710); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='750',IIT_SAT_Math__c=720); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='760',IIT_SAT_Math__c=740); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='770',IIT_SAT_Math__c=750); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='780',IIT_SAT_Math__c=760); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='790',IIT_SAT_Math__c=780); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='800',IIT_SAT_Math__c=800); customSettings2ToInsert.add(customSetting2ToInsert);
        customSetting2ToInsert = new IITRSATMathToSATMath__c(Name='0',IIT_SAT_Math__c=0); customSettings2ToInsert.add(customSetting2ToInsert);
		insert customSettings2ToInsert;
		
		List<IITRSATReadingToSATVerbal__c> customSettings3ToInsert = new List<IITRSATReadingToSATVerbal__c>();
        IITRSATReadingToSATVerbal__c customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='10',IIT_SAT_Verbal__c=200); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='11',IIT_SAT_Verbal__c=210); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='12',IIT_SAT_Verbal__c=220); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='13',IIT_SAT_Verbal__c=240); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='14',IIT_SAT_Verbal__c=250); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='15',IIT_SAT_Verbal__c=260); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='16',IIT_SAT_Verbal__c=270); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='17',IIT_SAT_Verbal__c=280); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='18',IIT_SAT_Verbal__c=310); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='19',IIT_SAT_Verbal__c=340); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='20',IIT_SAT_Verbal__c=370); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='21',IIT_SAT_Verbal__c=380); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='22',IIT_SAT_Verbal__c=400); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='23',IIT_SAT_Verbal__c=420); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='24',IIT_SAT_Verbal__c=440); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='25',IIT_SAT_Verbal__c=460); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='26',IIT_SAT_Verbal__c=480); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='27',IIT_SAT_Verbal__c=500); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='28',IIT_SAT_Verbal__c=520); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='29',IIT_SAT_Verbal__c=530); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='30',IIT_SAT_Verbal__c=550); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='31',IIT_SAT_Verbal__c=570); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='32',IIT_SAT_Verbal__c=590); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='33',IIT_SAT_Verbal__c=610); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='34',IIT_SAT_Verbal__c=640); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='35',IIT_SAT_Verbal__c=660); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='36',IIT_SAT_Verbal__c=680); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='37',IIT_SAT_Verbal__c=700); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='38',IIT_SAT_Verbal__c=720); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='39',IIT_SAT_Verbal__c=760); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='40',IIT_SAT_Verbal__c=790); customSettings3ToInsert.add(customSetting3ToInsert);
        customSetting3ToInsert = new IITRSATReadingToSATVerbal__c(Name='0',IIT_SAT_Verbal__c=0); customSettings3ToInsert.add(customSetting3ToInsert);
		insert customSettings3ToInsert;
		
		List<IITSATCompositeToACTComposite__c> customSettings4ToInsert = new List<IITSATCompositeToACTComposite__c>();
        IITSATCompositeToACTComposite__c customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='500',IIT_ACT_Composite__c=11); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='510',IIT_ACT_Composite__c=11); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='520',IIT_ACT_Composite__c=11); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='530',IIT_ACT_Composite__c=11); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='540',IIT_ACT_Composite__c=11); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='550',IIT_ACT_Composite__c=11); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='560',IIT_ACT_Composite__c=12); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='570',IIT_ACT_Composite__c=12); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='580',IIT_ACT_Composite__c=12); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='590',IIT_ACT_Composite__c=12); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='600',IIT_ACT_Composite__c=12); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='610',IIT_ACT_Composite__c=12); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='620',IIT_ACT_Composite__c=13); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='630',IIT_ACT_Composite__c=13); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='640',IIT_ACT_Composite__c=13); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='650',IIT_ACT_Composite__c=13); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='660',IIT_ACT_Composite__c=13); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='670',IIT_ACT_Composite__c=14); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='680',IIT_ACT_Composite__c=14); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='690',IIT_ACT_Composite__c=14); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='700',IIT_ACT_Composite__c=14); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='710',IIT_ACT_Composite__c=14); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='720',IIT_ACT_Composite__c=15); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='730',IIT_ACT_Composite__c=15); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='740',IIT_ACT_Composite__c=15); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='750',IIT_ACT_Composite__c=15); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='760',IIT_ACT_Composite__c=15); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='770',IIT_ACT_Composite__c=16); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='780',IIT_ACT_Composite__c=16); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='790',IIT_ACT_Composite__c=16); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='800',IIT_ACT_Composite__c=16); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='810',IIT_ACT_Composite__c=16); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='820',IIT_ACT_Composite__c=17); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='830',IIT_ACT_Composite__c=17); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='840',IIT_ACT_Composite__c=17); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='850',IIT_ACT_Composite__c=17); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='860',IIT_ACT_Composite__c=18); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='870',IIT_ACT_Composite__c=18); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='880',IIT_ACT_Composite__c=18); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='890',IIT_ACT_Composite__c=18); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='900',IIT_ACT_Composite__c=19); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='910',IIT_ACT_Composite__c=19); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='920',IIT_ACT_Composite__c=19); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='930',IIT_ACT_Composite__c=19); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='940',IIT_ACT_Composite__c=20); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='950',IIT_ACT_Composite__c=20); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='960',IIT_ACT_Composite__c=20); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='970',IIT_ACT_Composite__c=20); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='980',IIT_ACT_Composite__c=21); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='990',IIT_ACT_Composite__c=21); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1000',IIT_ACT_Composite__c=21); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1010',IIT_ACT_Composite__c=21); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1020',IIT_ACT_Composite__c=22); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1030',IIT_ACT_Composite__c=22); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1040',IIT_ACT_Composite__c=22); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1050',IIT_ACT_Composite__c=23); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1060',IIT_ACT_Composite__c=23); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1070',IIT_ACT_Composite__c=23); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1080',IIT_ACT_Composite__c=23); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1090',IIT_ACT_Composite__c=24); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1100',IIT_ACT_Composite__c=24); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1110',IIT_ACT_Composite__c=24); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1120',IIT_ACT_Composite__c=24); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1130',IIT_ACT_Composite__c=25); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1140',IIT_ACT_Composite__c=25); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1150',IIT_ACT_Composite__c=25); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1160',IIT_ACT_Composite__c=25); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1170',IIT_ACT_Composite__c=26); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1180',IIT_ACT_Composite__c=26); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1190',IIT_ACT_Composite__c=26); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1200',IIT_ACT_Composite__c=26); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1210',IIT_ACT_Composite__c=27); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1220',IIT_ACT_Composite__c=27); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1230',IIT_ACT_Composite__c=27); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1240',IIT_ACT_Composite__c=27); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1250',IIT_ACT_Composite__c=28); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1260',IIT_ACT_Composite__c=28); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1270',IIT_ACT_Composite__c=28); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1280',IIT_ACT_Composite__c=28); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1290',IIT_ACT_Composite__c=29); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1300',IIT_ACT_Composite__c=29); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1310',IIT_ACT_Composite__c=29); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1320',IIT_ACT_Composite__c=29); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1330',IIT_ACT_Composite__c=30); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1340',IIT_ACT_Composite__c=30); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1350',IIT_ACT_Composite__c=30); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1360',IIT_ACT_Composite__c=31); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1370',IIT_ACT_Composite__c=31); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1380',IIT_ACT_Composite__c=31); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1390',IIT_ACT_Composite__c=31); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1400',IIT_ACT_Composite__c=32); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1410',IIT_ACT_Composite__c=32); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1420',IIT_ACT_Composite__c=32); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1430',IIT_ACT_Composite__c=32); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1440',IIT_ACT_Composite__c=33); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1450',IIT_ACT_Composite__c=33); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1460',IIT_ACT_Composite__c=33); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1470',IIT_ACT_Composite__c=33); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1480',IIT_ACT_Composite__c=33); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1490',IIT_ACT_Composite__c=34); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1500',IIT_ACT_Composite__c=34); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1510',IIT_ACT_Composite__c=34); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1520',IIT_ACT_Composite__c=34); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1530',IIT_ACT_Composite__c=34); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1540',IIT_ACT_Composite__c=35); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1550',IIT_ACT_Composite__c=35); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1560',IIT_ACT_Composite__c=35); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1570',IIT_ACT_Composite__c=35); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1580',IIT_ACT_Composite__c=35); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1590',IIT_ACT_Composite__c=35); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='1600',IIT_ACT_Composite__c=36); customSettings4ToInsert.add(customSetting4ToInsert);
        customSetting4ToInsert = new IITSATCompositeToACTComposite__c(Name='0',IIT_ACT_Composite__c=0); customSettings4ToInsert.add(customSetting4ToInsert);
		insert customSettings4ToInsert;
		
		List<IITSATMathToACTMath__c> customSettings5ToInsert = new List<IITSATMathToACTMath__c>();
        IITSATMathToACTMath__c customSetting5ToInsert = new IITSATMathToACTMath__c(Name='250',IIT_ACT_Math__c=11); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='260',IIT_ACT_Math__c=11); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='270',IIT_ACT_Math__c=11); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='280',IIT_ACT_Math__c=12); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='290',IIT_ACT_Math__c=12); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='300',IIT_ACT_Math__c=12); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='310',IIT_ACT_Math__c=13); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='320',IIT_ACT_Math__c=13); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='330',IIT_ACT_Math__c=13); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='340',IIT_ACT_Math__c=14); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='350',IIT_ACT_Math__c=14); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='360',IIT_ACT_Math__c=15); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='370',IIT_ACT_Math__c=15); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='380',IIT_ACT_Math__c=15); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='390',IIT_ACT_Math__c=16); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='400',IIT_ACT_Math__c=16); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='410',IIT_ACT_Math__c=17); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='420',IIT_ACT_Math__c=17); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='430',IIT_ACT_Math__c=18); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='440',IIT_ACT_Math__c=18); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='450',IIT_ACT_Math__c=19); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='460',IIT_ACT_Math__c=19); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='470',IIT_ACT_Math__c=20); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='480',IIT_ACT_Math__c=20); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='490',IIT_ACT_Math__c=21); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='500',IIT_ACT_Math__c=21); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='510',IIT_ACT_Math__c=22); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='520',IIT_ACT_Math__c=22); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='530',IIT_ACT_Math__c=23); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='540',IIT_ACT_Math__c=23); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='550',IIT_ACT_Math__c=24); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='560',IIT_ACT_Math__c=24); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='570',IIT_ACT_Math__c=25); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='580',IIT_ACT_Math__c=25); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='590',IIT_ACT_Math__c=26); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='600',IIT_ACT_Math__c=26); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='610',IIT_ACT_Math__c=27); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='620',IIT_ACT_Math__c=27); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='630',IIT_ACT_Math__c=28); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='640',IIT_ACT_Math__c=28); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='650',IIT_ACT_Math__c=29); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='660',IIT_ACT_Math__c=29); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='670',IIT_ACT_Math__c=30); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='680',IIT_ACT_Math__c=31); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='690',IIT_ACT_Math__c=31); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='700',IIT_ACT_Math__c=32); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='710',IIT_ACT_Math__c=32); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='720',IIT_ACT_Math__c=33); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='730',IIT_ACT_Math__c=33); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='740',IIT_ACT_Math__c=33); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='750',IIT_ACT_Math__c=34); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='760',IIT_ACT_Math__c=34); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='770',IIT_ACT_Math__c=35); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='780',IIT_ACT_Math__c=35); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='790',IIT_ACT_Math__c=35); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='800',IIT_ACT_Math__c=36); customSettings5ToInsert.add(customSetting5ToInsert);
        customSetting5ToInsert = new IITSATMathToACTMath__c(Name='0',IIT_ACT_Math__c=0); customSettings5ToInsert.add(customSetting5ToInsert);
		insert customSettings5ToInsert;
        
        //for(Integer i = 0; i < 3; i++) {
        	ApexPages.currentPage().getParameters().put('id',applicationsToInsert[0].id);
        	ApexPages.StandardController stdApp = new ApexPages.StandardController(objApp);
        	IITACRKController objIITACRKController = new IITACRKController(stdApp);
        
        	objIITACRKController.getacrkDisplay();
        	objIITACRKController.getACRK();
        	objIITACRKController.gethsGPAScaleWeightFlag();
            objIITACRKController.getmeritFinal();
        	objIITACRKController.getmeritHousing();
        	objIITACRKController.getswInviteFlag();
        	objIITACRKController.getdecisionGuide();
        	objIITACRKController.executeDML();
			objIITACRKController.executeBatchDML();
        //}
        
        objIITACRKController.gethighMathInd(28, 27);
        objIITACRKController.gethighMathInd(30, 30);
        objIITACRKController.getmajorType('Biochemistry');
        objIITACRKController.getmajorType('Architecture');
        objIITACRKController.getusePoint(1, 4, 0, 'Architecture');
        objIITACRKController.getusePoint(1, 3, 3, 'Architecture');
        objIITACRKController.getusePoint(1, 1, 3, 'Architecture');
        objIITACRKController.getusePoint(2, 2, 2, 'Biochemistry');
        objIITACRKController.getusePoint(2, 1, 1, 'Biochemistry');
        objIITACRKController.getusePoint(1, 1, 1, 'Business Administration');
        objIITACRKController.getusePoint(1, 3, 2, 'Communication');
        objIITACRKController.getzBestComp(0);
        objIITACRKController.getzBestMath(0);
        objIITACRKController.getzHSGPA(0);
        objIITACRKController.getzHSRank(0.75);
        objIITACRKController.getzHSQuality(0);
        objIITACRKController.getzRigor(0);
        objIITACRKController.getmodel1CompWeight(30, 2, 0);
        objIITACRKController.getmodel1CompWeight(30, 2, 1);
        objIITACRKController.getmodel1CompWeight(30, 1, 0);
        objIITACRKController.getmodel1CompWeight(30, 1, 1);
        objIITACRKController.getmodel1HSRankWeight(-0.5);
        objIITACRKController.getmodel2CompWeight(30, 2, 0);
        objIITACRKController.getmodel2CompWeight(30, 2, 1);
        objIITACRKController.getmodel2CompWeight(30, 1, 0);
        objIITACRKController.getmodel2CompWeight(30, 1, 1);
        objIITACRKController.getrawScore(-0.5, 0.5, 0.5);
        objIITACRKController.getcutPoint(0, 0, 0);
        objIITACRKController.getcutPoint(30, 4.0, -0.6);
        objIITACRKController.getcutPoint(30, 4.0, 0.0);
        objIITACRKController.getcutPoint(30, 4.0, 0.3);
        objIITACRKController.getcutPoint(30, 4.0, 0.6);
        objIITACRKController.getcutPoint(30, 4.0, 0.8);
        objIITACRKController.getACRK(-999, 30, 6, 30);
        objIITACRKController.getACRK(-0.15, 20, 6, 20);
        objIITACRKController.getACRK(-0.6, 31, 6, 31);
        objIITACRKController.getACRK(0.8, 27, 1, 27);
        objIITACRKController.getmeritLewis(1);
        objIITACRKController.getmeritLewis(4);
        objIITACRKController.getmeritLewis(6);
        objIITACRKController.getmeritStuart(1, 'Female', 0);
        objIITACRKController.getmeritStuart(3, 'Female', 0);
        objIITACRKController.getmeritStuart(4, 'Female', 0);
        objIITACRKController.getmeritStuart(6, 'Female', 0);
        objIITACRKController.getmeritArchitecture(1, 'Female', 0);
        objIITACRKController.getmeritArchitecture(4, 'Female', 0);
        objIITACRKController.getmeritArchitecture(6, 'Female', 0);
        objIITACRKController.getmeritScience(1, 0);
        objIITACRKController.getmeritScience(4, 0);
        objIITACRKController.getmeritScience(6, 0);
        objIITACRKController.getswExclusions(0.75, 4.5);
        objIITACRKController.getswExclusions(0.9, 4.5);
        objIITACRKController.getswGrowthPrograms('Applied Analytics');
        objIITACRKController.getswOverPopulatedPrograms('Architecture');
        objIITACRKController.getswInviteFlag('', 'Scholar', '', '');
        objIITACRKController.getswInviteFlag('', '', 'Strongly Consider', '');
        objIITACRKController.getswInviteFlag('', '', '', 'Consider');
        objIITACRKController.getswInviteFlag('', '', '', '');
        
    }
    
}