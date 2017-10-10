@isTest
public class IITControllerTests {
    
    @isTest
    public static void conductIITCourseCatalogControllerTesting() {
        
        List<IIT_Courses__c> coursesToTest = dataCourses(1);
        Database.Insert(coursesToTest, false);
        
        for(IIT_Courses__c courseToTest : coursesToTest){
            ApexPages.currentPage().getParameters().put('id',courseToTest.id);
            ApexPages.StandardController stdCourse = new ApexPages.StandardController(courseToTest);
            IITCourseCatalogController objIITCourseCatalogController = new IITCourseCatalogController(stdCourse);
            objIITCourseCatalogController.getIITCourses();
            objIITCourseCatalogController.getColleges();
            objIITCourseCatalogController.getDepartments();
            objIITCourseCatalogController.getAreasOfStudy();
            objIITCourseCatalogController.getCollegeKey();
            objIITCourseCatalogController.getDepartmentKey();
            objIITCourseCatalogController.getAreaOfStudyKey();
            objIITCourseCatalogController.getTermKey();
            objIITCourseCatalogController.getIITPopCourses();
            objIITCourseCatalogController.searchstring = '101';
            objIITCourseCatalogController.search();
        }
    }
    
    @isTest
    public static void conductIITEPICaseControllerTesting(){
        
        List<Account> supportAccountsToTest = dataSupportAccounts(1);
        insert supportAccountsToTest;
        
        List<Contact> supportContactsToTest = dataSupportContacts(supportAccountsToTest,1);
        insert supportContactsToTest;
        
        PageReference epiSupportPage1 = Page.IIT_EPI_Support;
        Test.setCurrentPage(epiSupportPage1);        
        IITEPICaseController objIITEPICaseController1 = new IITEPICaseController();
        objIITEPICaseController1.ctEmail = 'bwoods5+test0@iit.edu';
        objIITEPICaseController1.c.Subject = 'Case Subject';
        objIITEPICaseController1.c.Description = 'Case Description';
        objIITEPICaseController1.c.Priority = 'High';
        objIITEPICaseController1.submitCase();
        
        PageReference epiSupportPage2 = Page.IIT_EPI_Support;
        Test.setCurrentPage(epiSupportPage2);        
        IITEPICaseController objIITEPICaseController2 = new IITEPICaseController();
        objIITEPICaseController2.ctEmail = 'bwoods5+test1@iit.edu';
        objIITEPICaseController2.c.Subject = 'Case Subject';
        objIITEPICaseController2.c.Description = 'Case Description';
        objIITEPICaseController2.c.Priority = 'High';
        objIITEPICaseController2.submitCase();
    }
    
    @isTest(SeeAllData = 'true')
    public static void conductIITAttachmentCopyControllerTesting(){
        
        PageReference attCopyPage = Page.IITAttachmentCopy;
        Test.setCurrentPage(attCopyPage);        
        IITAttachmentCopyController objIITAttachmentCopyController = new IITAttachmentCopyController();
        objIITAttachmentCopyController.idOld = [Select Id From TargetX_SRMb__Application__c Where TargetX_SRMb__Level__c = 'Undergraduate' And TargetX_SRMb__Application_Decision__c != null Order By LastModifiedDate Desc Limit 1].Id;
        objIITAttachmentCopyController.idNew = [Select Id From TargetX_SRMb__Application__c Where TargetX_SRMb__Level__c = 'Undergraduate' And TargetX_SRMb__Application_Decision__c != null Order By LastModifiedDate Desc Limit 1].Id;
        objIITAttachmentCopyController.copyDoc();
        
        objIITAttachmentCopyController.idOld = [Select Id From TargetX_SRMb__Application__c Order By CreatedDate Asc Limit 1].Id;
        objIITAttachmentCopyController.idNew = [Select Id From TargetX_SRMb__Application__c Order By CreatedDate Asc Limit 1].Id;
        objIITAttachmentCopyController.copyDoc();
        
    }
        
    @isTest
    public static void conductIITAppTrackerControllerTesting(){
        
        List<Account> accountsToTest = dataAccounts(1);
        insert accountsToTest;
        
        List<Contact> contactsToTest = dataContacts(accountsToTest,1);
        insert contactsToTest;
        
        List<TargetX_SRMb__Application__c> applicationsToTest = dataApplications(contactsToTest,1);
        insert applicationsToTest;
        
        List<TargetX_Reader__Application_Review_Type__c> applicationReviewTypesToTest = dataApplicationReviewTypes();
        insert applicationReviewTypesToTest;
        
        List<TargetX_Reader__Application_Review__c> applicationReviewsToTest = dataApplicationReviews(applicationsToTest,applicationReviewTypesToTest,1);
        insert applicationReviewsToTest;
        
        for(TargetX_SRMb__Application__c applicationToTest : applicationsToTest){
            ApexPages.currentPage().getParameters().put('id',applicationToTest.id);
            ApexPages.StandardController stdApplication = new ApexPages.StandardController(applicationToTest);
            IITAppTrackerController objIITAppTrackerController = new IITAppTrackerController(stdApplication); 
            objIITAppTrackerController.getAppList();
            objIITAppTrackerController.getAppReviews();
        }
        
    }
    
    @isTest
    public static void conductIITInsufficiencyControllerTesting(){
        
        List<Account> accountsToTest = dataAccounts(1);
        insert accountsToTest;
        
        List<Contact> contactsToTest = dataContacts(accountsToTest,1);
        insert contactsToTest;
        
        List<TargetX_SRMb__Application__c> applicationsToTest = dataApplications(contactsToTest,1);
        insert applicationsToTest;
        
        List<TargetX_SRMb__Essay__c> insuffEssaysToTest = dataInsuffEssays(applicationsToTest,1);
        insert insuffEssaysToTest;
        
        List<TargetX_SRMb__Recommendation__c> insuffRecommendationsToTest = dataInsuffRecommendations(applicationsToTest,1);
        insert insuffRecommendationsToTest;
        
        List<TargetX_SRMb__Recommendation__c> incRecommendationsToTest = dataIncRecommendations(applicationsToTest,1);
        insert incRecommendationsToTest;
        
        List<TargetX_SRMb__Enrollment_History__c> insuffEnrollmentHistoiesToTest = dataInsuffEnrollmentHistories(applicationsToTest,1);
        insert insuffEnrollmentHistoiesToTest;
        
        for(TargetX_SRMb__Application__c applicationToTest : applicationsToTest){
            ApexPages.currentPage().getParameters().put('id',applicationToTest.id);
            ApexPages.StandardController stdApplication = new ApexPages.StandardController(applicationToTest);
            IITInsufficiencyController objIITInsufficiencyController = new IITInsufficiencyController(stdApplication); 
            objIITInsufficiencyController.getAppEssay();
            objIITInsufficiencyController.getAppRec();
            objIITInsufficiencyController.getAppIncomRec();
            objIITInsufficiencyController.getEnrollHis();
            objIITInsufficiencyController.getFinalEnrollHist();
        }
        
    }
    
    @isTest
    public static void conductIITAppTrackerAccountControllerTesting(){
        
        List<Account> accountsToTest = dataAccounts(1);
        insert accountsToTest;
        
        List<Contact> contactsToTest = dataContacts(accountsToTest,1);
        insert contactsToTest;
        
        List<TargetX_SRMb__Application__c> applicationsToTest = dataApplications(contactsToTest,1);
        insert applicationsToTest;
        
        for(Account accountToTest : accountsToTest){
            ApexPages.currentPage().getParameters().put('id',accountToTest.id);
            ApexPages.currentPage().getParameters().put('k',accountToTest.TargetX_SRMb__ceeb_code__c);
            ApexPages.StandardController stdAccount = new ApexPages.StandardController(accountToTest);
            IITAppTrackerAccountController objIITAppTrackerAccountController = new IITAppTrackerAccountController(stdAccount);
            objIITAppTrackerAccountController.getaccessError();
            objIITAppTrackerAccountController.getaccountContacts();
            objIITAppTrackerAccountController.getaccountEvents();
            objIITAppTrackerAccountController.getcontactApps();
        }
        
    }
    
    @isTest
    public static void conductIITAppTrackerTransferEvalControllerTesting(){
        
        List<Account> accountsToTest = dataAccounts(1);
        insert accountsToTest;
        
        List<Contact> contactsToTest = dataContacts(accountsToTest,1);
        insert contactsToTest;
        
        List<IIT_Course_Evaluation__c> courseEvaluationsToTest = dataCourseEvaluations(contactsToTest,5);
        insert courseEvaluationsToTest;
        
        for(Contact contactToTest : contactsToTest){
            ApexPages.currentPage().getParameters().put('id',contactToTest.id);
            ApexPages.currentPage().getParameters().put('k',contactToTest.TargetX_Base__Access_Key__c);
            ApexPages.StandardController stdContact = new ApexPages.StandardController(contactToTest);
            IITAppTrackerTransferEvalController objIITAppTrackerTransferEvalController = new IITAppTrackerTransferEvalController(stdContact);
            objIITAppTrackerTransferEvalController.getaccessError();
            objIITAppTrackerTransferEvalController.getcourseEvaluations();
        }
        
    }
    
    @isTest
    public static void conductIITDecCloudControllerTesting(){
        
        List<Account> accountsToTest = dataAccounts(5);
        insert accountsToTest;
        
        List<Contact> contactsToTest = dataContacts(accountsToTest,1);
        insert contactsToTest;
        
        List<TargetX_SRMb__Test__c> testsActToTest = dataTestsAct(contactsToTest,1);
        insert testsActToTest;
        for(TargetX_SRMb__Test__c testActToTest : testsActToTest) {
            testActToTest.TargetX_SRMb__ACT_Composite_Score__c = Math.round((testActToTest.TargetX_SRMb__ACT_English_Score__c + testActToTest.TargetX_SRMb__ACT_Math_Score__c + testActToTest.TargetX_SRMb__ACT_Reading_Score__c + testActToTest.TargetX_SRMb__ACT_Science_Score__c)/4);
        }
        update testsActToTest;
        
        List<TargetX_SRMb__Test__c> testsSatToTest = dataTestsSat(contactsToTest,1);
        insert testsSatToTest;
        
        List<TargetX_SRMb__Application__c> applicationsToTest = dataApplications(contactsToTest,1);
        insert applicationsToTest;
        
        List<TargetX_SRMb__Enrollment_History__c> enrollmentHistoriesToTest = dataEnrollmentHistories(applicationsToTest,1);
        insert enrollmentHistoriesToTest;
        
        for(TargetX_SRMb__Application__c applicationToTest : applicationsToTest){
            ApexPages.currentPage().getParameters().put('id',applicationToTest.id);
            ApexPages.StandardController stdApplication = new ApexPages.StandardController(applicationToTest);
            IITDecCloudController objIITDecCloudController = new IITDecCloudController(stdApplication);
            objIITDecCloudController.getcontactTests();
            objIITDecCloudController.getAppReviews();
            objIITDecCloudController.getApplications();
            objIITDecCloudController.getContactEnrollHist();
        }
        
    }
    
    @isTest(SeeAllData = 'true')
    public static void conductIITFinAidYearControllerTesting(){
        
        map<string, IIT_App_Tracker_Settings__c> appTrackerSettingsMap = IIT_App_Tracker_Settings__c.getAll();
        string finAidYearDesc = appTrackerSettingsMap.get('Default').IIT_Fin_Aid_Year_Description__c;
        
        Id appId = [Select IIT_Application__c From TargetX_SRMb__Financial_Aid__c Where IIT_Application__c != null and TargetX_SRMb__Type__c = 'Tuition' and IIT_Aid_Year_Description__c = :finAidYearDesc and IIT_Award_Status__c != 'Canceled' and (IIT_Stipend_Amount__c !=0 or TargetX_SRMb__Amount__c != 0 or IIT_Credit_Hours__c !=0) Limit 1].IIT_Application__c;
        TargetX_SRMb__Application__c applicationToTest = [Select Id From TargetX_SRMb__Application__c Where Id = :appId Limit 1];
        ApexPages.currentPage().getParameters().put('id',appId);
		ApexPages.StandardController stdApplication = new ApexPages.StandardController(applicationToTest);
		IITFinAidYearController objIITFinAidYearController = new IITFinAidYearController(stdApplication); 
		objIITFinAidYearController.getcontactFinAid();
        
    }
    
    @isTest
    public static void conductIITOnlineAppUserOverrideControllerTesting(){
    	IIT_OnlineAppUser_Override_Controller testController = new IIT_OnlineAppUser_Override_Controller();
    }
    
    
//Create Data for Testing
    public static List<String> dataContactMailingStates() {
        List<String> contactMailingStates = new List<String>();
        contactMailingStates.add('IL');
        contactMailingStates.add('WI');
        contactMailingStates.add('CA');
        contactMailingStates.add('IN');
        contactMailingStates.add('TX');
        return contactMailingStates;
    }
    
    public static List<String> dataContactEthnicities() {
        List<String> contactEthnicities = new List<String>();
        contactEthnicities.add('White');
        contactEthnicities.add('Black or African American');
        contactEthnicities.add('Asian');
        contactEthnicities.add('American Indian or Alaska Native');
        contactEthnicities.add('Native Hawaiian/Other Pacific Islander');
        return contactEthnicities;
    }
    
    public static List<IIT_Program__c> dataPrograms() {
        List<IIT_Program__c> programsToCreate = new List<IIT_Program__c>(); 
        
        IIT_Program__c programToCreate = new IIT_Program__c(Name = 'BAC-ARCH'
        , IIT_Program_Name__c = 'Bachelor of Architecture'
        , IIT_Level__c = 'Undergraduate'
        , IIT_Degree__c = 'Professional Bachelor'
        , IIT_Major__c = 'Architecture'
        , IIT_College__c = 'College of Architecture'
        , IIT_Department__c = 'College of Architecture'
        );
        programsToCreate.add(programToCreate);
        
        programToCreate = new IIT_Program__c(Name = 'BS-AE'
        , IIT_Program_Name__c = 'Bachelor of Science in Aerospace Engineering'
        , IIT_Level__c = 'Undergraduate'
        , IIT_Degree__c = 'Bachelor of Science'
        , IIT_Major__c = 'Aerospace Engineering'
        , IIT_College__c = 'Armour College of Engineering'
        , IIT_Department__c = 'Mechanical, Materials, and Aerospace Engineering'
        );
        programsToCreate.add(programToCreate);
        
        programToCreate = new IIT_Program__c(Name = 'BS-CS-1'
        , IIT_Program_Name__c = 'Bachelor of Science in Computer Science'
        , IIT_Level__c = 'Undergraduate'
        , IIT_Degree__c = 'Bachelor of Science'
        , IIT_Major__c = 'Computer Science'
        , IIT_College__c = 'College of Science'
        , IIT_Department__c = 'Computer Science'
        );
        programsToCreate.add(programToCreate);
        
        programToCreate = new IIT_Program__c(Name = 'BS-PSYC-2'
        , IIT_Program_Name__c = 'Bachelor of Science in Psychology'
        , IIT_Level__c = 'Undergraduate'
        , IIT_Degree__c = 'Bachelor of Science'
        , IIT_Major__c = 'Psychology'
        , IIT_College__c = 'Lewis College of Human Sciences'
        , IIT_Department__c = 'Psychology'
        );
        programsToCreate.add(programToCreate);
        
        programToCreate = new IIT_Program__c(Name = 'BS-BA'
        , IIT_Program_Name__c = 'Bachelor of Science in Business Administration'
        , IIT_Level__c = 'Undergraduate'
        , IIT_Degree__c = 'Bachelor of Science'
        , IIT_Major__c = 'Business Administration'
        , IIT_College__c = 'Stuart School of Business'
        , IIT_Department__c = 'Business Administration'
        );
        programsToCreate.add(programToCreate);

        return programsToCreate;
    }
    
    public static List<String> dataApplicationReviewHighestMaths() {
        List<String> applicationReviewHighestMaths = new List<String>();
        applicationReviewHighestMaths.add('AP Calculus and Higher');
        applicationReviewHighestMaths.add('Calculus');
        applicationReviewHighestMaths.add('Pre-Calculus');
        applicationReviewHighestMaths.add('Below Pre-Calculus');
        return applicationReviewHighestMaths;
    }
    
    public static List<String> dataApplicationReviewRigorRatings() {
        List<String> applicationReviewRigorRatings = new List<String>();
        applicationReviewRigorRatings.add('Majority');
        applicationReviewRigorRatings.add('Medium');
        applicationReviewRigorRatings.add('Basic');
        applicationReviewRigorRatings.add('Not Offered');
        return applicationReviewRigorRatings;
    }
    
    public static List<Account> dataAccounts(Integer numberOfAccounts) {
        List<Account> accountsToCreate = new List<Account>();
        
        for(Integer i = 0; i < numberOfAccounts; i++) {
            Account accountToCreate = new Account(
                Name = 'Test High School ' + String.valueof(i),
                TargetX_SRMb__ceeb_code__c = (numberOfAccounts >= 100 ? '000' + String.valueof(i) : (numberOfAccounts >= 10 ? '0000' + String.valueof(i) : '00000' + String.valueof(i))),
                IIT_Highschool_Quality__c = Math.random(),
                IIT_HS_Build_Flag__c = (Math.round(Math.random()) == 0 ? false : true),
                RecordTypeId = '012j0000000zCdB'
            );
            accountsToCreate.add(accountToCreate);
        }
        
        return accountsToCreate;
    }
    
    public static List<Contact> dataContacts(List<Account> accountsForContacts, Integer numberOfContactsPerAccount) {
        List<Contact> contactsToCreate = new List<Contact>();
        
        List<String> contactMailingStates = dataContactMailingStates();
        List<String> contactEthnicities = dataContactEthnicities();
        
        for(Account accountForContact : accountsForContacts) {
            for(Integer i = 0; i < numberOfContactsPerAccount; i++) {
                Contact contactToCreate = new Contact(
                    FirstName = 'Fname' + String.valueof(i),
                    LastName = 'Lname' + String.valueof(i),
                    AccountId = accountForContact.id,
                    Email = 'bwoods5+test' + String.valueof(i) + '@iit.edu',
                    MailingState = contactMailingStates[(Math.floor(Math.random() * ((4-0)+1) + 0)).intValue()],
                    TargetX_SRMb__Gender__c = (Math.round(Math.random()) == 0 ? 'Female' : 'Male'),
                    TargetX_SRMb__IPEDS_Hispanic__c = (Math.round(Math.random()) == 0 ? false : true),
                    TargetX_SRMb__IPEDS_Ethnicities__c = contactEthnicities[(Math.floor(Math.random() * ((4-0)+1) + 0)).intValue()],
                    TargetX_SRMb__Anticipated_Start_Term__c = 'Fall',
                    TargetX_SRMb__Anticipated_Start_Year__c = System.Today().Year()+1,
                    RecordTypeId = '012j0000000xaqj'
                );
                contactsToCreate.add(contactToCreate);
            }
        }
        
        return contactsToCreate;
    }
    
    public static List<TargetX_SRMb__Test__c> dataTestsAct(List<Contact> contactsForTestsAct, Integer numberOfTestsActPerContact) {
        List<TargetX_SRMb__Test__c> testsActToCreate = new List<TargetX_SRMb__Test__c>();
        
        for(Contact contactForTestAct : contactsForTestsAct) {
            for(Integer i = 0; i < numberOfTestsActPerContact; i++) {
                TargetX_SRMb__Test__c testActToCreate = new TargetX_SRMb__Test__c(
                    TargetX_SRMb__Contact__c = contactForTestAct.id,
                    Name = 'ACT',
                    TargetX_SRMb__Test__c = 'ACT',
                    TargetX_SRMb__Score_Validated__c = true,
                    TargetX_SRMb__Test_Date__c = System.today(),
                    RecordTypeId = '012j0000000xaqm',
                    TargetX_SRMb__ACT_English_Score__c = (Math.floor(Math.random() * ((36-18)+1) + 18)),
                    TargetX_SRMb__ACT_Math_Score__c = (Math.floor(Math.random() * ((36-18)+1) + 18)),
                    TargetX_SRMb__ACT_Reading_Score__c = (Math.floor(Math.random() * ((36-18)+1) + 18)),
                    TargetX_SRMb__ACT_Science_Score__c = (Math.floor(Math.random() * ((36-18)+1) + 18))
                );
                testsActToCreate.add(testActToCreate);
            }
        }
        
        return testsActToCreate;
    }
    
    public static List<TargetX_SRMb__Test__c> dataTestsSat(List<Contact> contactsForTestsSat, Integer numberOfTestsSatPerContact) {
        List<TargetX_SRMb__Test__c> testsSatToCreate = new List<TargetX_SRMb__Test__c>();
        
        for(Contact contactForTestSat : contactsForTestsSat) {
            for(Integer i = 0; i < numberOfTestsSatPerContact; i++) {
                TargetX_SRMb__Test__c testSatToCreate = new TargetX_SRMb__Test__c(
                    TargetX_SRMb__Contact__c = contactForTestSat.id,
                    Name = 'SAT I',
                    TargetX_SRMb__Test__c = 'SAT I',
                    TargetX_SRMb__Score_Validated__c = true,
                    TargetX_SRMb__Test_Date__c = System.today(),
                    RecordTypeId = '012j0000000xaqs',
                    TargetX_SRMb__SAT_I_Math_Score__c = (Math.floor(Math.random() * ((800-400)+1) + 400)),
                    TargetX_SRMb__SAT_I_Verbal_Score__c = (Math.floor(Math.random() * ((800-400)+1) + 400))
                );
                testsSatToCreate.add(testSatToCreate);
            }
        }
        
        return testsSatToCreate;
    }
    
    public static List<TargetX_SRMb__Application__c> dataApplications(List<Contact> contactsForApplications, Integer numberOfApplicationsPerContact) {
        List<TargetX_SRMb__Application__c> applicationsToCreate = new List<TargetX_SRMb__Application__c>();
        
        List<IIT_Program__c> programsList = dataPrograms();
        
        for(Contact contactForApplication : contactsForApplications) {
            for(Integer i = 0; i < numberOfApplicationsPerContact; i++) {
                Integer programArrayRecord = (Math.floor(Math.random() * ((4-0)+1) + 0)).intValue();
                TargetX_SRMb__Application__c applicationToCreate = new TargetX_SRMb__Application__c(
                    RecordTypeId = '012j0000000n198',
                    TargetX_SRMb__Contact__c = contactForApplication.id,
                    TargetX_SRMb__Application_Type__c = 'Undergraduate First Year Domestic',
                    TargetX_SRMb__Stage__c = 'Submitted',
					TargetX_SRMb__Status__c = 'Complete',
					IIT_Application_Processing_Status__c = 'Pending Initial Review',
                    IIT_Application_Start_Date__c = System.today(),
                    TargetX_SRMb__Application_Submit_Date__c = System.today(),
                    IIT_Application_Decision_Date__c = System.today(),
                    TargetX_SRMb__Start_Term__c = 'Fall',
                    TargetX_SRMb__Start_Term_Year__c = String.valueof(System.Today().Year()+1),
                    TargetX_SRMb__Level__c = 'Undergraduate',
                    TargetX_SRMb__Student_Type__c = 'First Year',
                    TargetX_SRMb__Degree__c = programsList[programArrayRecord].IIT_Degree__c,
                    TargetX_SRMb__Possible_Academic_Major__c = programsList[programArrayRecord].IIT_Major__c,
                    TargetX_SRMb__College__c = programsList[programArrayRecord].IIT_College__c,
                    TargetX_SRMb__Housing__c = (Math.round(Math.random()) == 0 ? 'On Campus' : 'Commuter')
                );
                applicationsToCreate.add(applicationToCreate);
            }
        }
        
        return applicationsToCreate;
    }
    
    public static List<TargetX_SRMb__Enrollment_History__c> dataEnrollmentHistories(List<TargetX_SRMb__Application__c> applicationsForEnrollmentHistories, Integer numberOfEnrollmentHistoriesPerApplication) {
        List<TargetX_SRMb__Enrollment_History__c> enrollmentHistoriesToCreate = new List<TargetX_SRMb__Enrollment_History__c>();
        
        for(TargetX_SRMb__Application__c applicationForEnrollmentHistory : applicationsForEnrollmentHistories) {
            for(Integer i = 0; i < numberOfEnrollmentHistoriesPerApplication; i++) {
                TargetX_SRMb__Enrollment_History__c enrollmentHistoryToCreate = new TargetX_SRMb__Enrollment_History__c(
                    Name = 'High School ' + String.valueof(i),
                    TargetX_SRMb__Contact__c = applicationForEnrollmentHistory.TargetX_SRMb__Contact__c,
                    TargetX_SRMb__Application__c = applicationForEnrollmentHistory.id,
                    TargetX_SRMb__Account__c = applicationForEnrollmentHistory.TargetX_SRMb__Contact__r.AccountId,
                    RecordTypeId = '012j0000000xaql',
                    TargetX_SRMb__End_Date__c = System.today(),
                    TargetX_SRMb__Start_Date__c = System.today().addYears(-3),
                    TargetX_SRMb__Official_GPA__c = (Math.random() * ((5-3)+1) + 3),
                    TargetX_SRMb__GPA_Official_Scale__c = '4.0 Scale',
                    TargetX_SRMb__Official_Class_Rank__c = String.valueOf(Math.floor(Math.random() * ((99-1)+1) + 1)),
                    TargetX_SRMb__Official_Class_Size__c = (Math.floor(Math.random() * ((900-100)+1) + 100))
                );
                enrollmentHistoriesToCreate.add(enrollmentHistoryToCreate);
            }
        }
        
        return enrollmentHistoriesToCreate;
    }
    
    public static List<TargetX_SRMb__Enrollment_History__c> dataInsuffEnrollmentHistories(List<TargetX_SRMb__Application__c> applicationsForEnrollmentHistories, Integer numberOfEnrollmentHistoriesPerApplication) {
        List<TargetX_SRMb__Enrollment_History__c> insuffEnrollmentHistoriesToCreate = new List<TargetX_SRMb__Enrollment_History__c>();
        
        for(TargetX_SRMb__Application__c applicationForEnrollmentHistory : applicationsForEnrollmentHistories) {
            for(Integer i = 0; i < numberOfEnrollmentHistoriesPerApplication; i++) {
                TargetX_SRMb__Enrollment_History__c insuffEnrollmentHistoryToCreate = new TargetX_SRMb__Enrollment_History__c(
                    Name = 'College ' + String.valueof(i),
                    TargetX_SRMb__Contact__c = applicationForEnrollmentHistory.TargetX_SRMb__Contact__c,
                    TargetX_SRMb__Application__c = applicationForEnrollmentHistory.id,
                    TargetX_SRMb__Account__c = applicationForEnrollmentHistory.TargetX_SRMb__Contact__r.AccountId,
                    RecordTypeId = '012j0000000xaqk',
                    TargetX_SRMb__End_Date__c = System.today(),
                    TargetX_SRMb__Start_Date__c = System.today().addYears(-3),
                    IIT_Insufficiency_ID_Desc__c = 'Official documents required',
                    TargetX_SRMb__Official_Final_Transcripts_Received__c = false,
                    TargetX_SRMb__Degree_Earned__c = 'Bachelor of Science'
                );
                insuffEnrollmentHistoriesToCreate.add(insuffEnrollmentHistoryToCreate);
            }
        }
        
        return insuffEnrollmentHistoriesToCreate;
    }
    
    public static List<TargetX_SRMb__Essay__c> dataInsuffEssays(List<TargetX_SRMb__Application__c> applicationsForEssays, Integer numberOfEssaysPerApplication) {
        List<TargetX_SRMb__Essay__c> insuffEssaysToCreate = new List<TargetX_SRMb__Essay__c>();
        
        for(TargetX_SRMb__Application__c applicationForEssay : applicationsForEssays) {
            for(Integer i = 0; i < numberOfEssaysPerApplication; i++) {
                TargetX_SRMb__Essay__c insuffEssayToCreate = new TargetX_SRMb__Essay__c(
                    Name = 'FAS ' + String.valueof(i),
                    TargetX_SRMb__Contact__c = applicationForEssay.TargetX_SRMb__Contact__c,
                    TargetX_SRMb__Application__c = applicationForEssay.id,
                    RecordTypeId = '012j00000010ER3',
                    TargetX_SRMb__Type__c = 'Financial Affidavit of Support',
                    IIT_Insufficiency_ID_Desc__c = 'Official documents required'
                );
                insuffEssaysToCreate.add(insuffEssayToCreate);
            }
        }
        
        return insuffEssaysToCreate;
    }
    
    public static List<TargetX_SRMb__Recommendation__c> dataInsuffRecommendations(List<TargetX_SRMb__Application__c> applicationsForRecommendations, Integer numberOfRecommendationsPerApplication) {
        List<TargetX_SRMb__Recommendation__c> insuffRecommendationsToCreate = new List<TargetX_SRMb__Recommendation__c>();
        
        for(TargetX_SRMb__Application__c applicationForRecommendation : applicationsForRecommendations) {
            for(Integer i = 0; i < numberOfRecommendationsPerApplication; i++) {
                TargetX_SRMb__Recommendation__c insuffRecommendationToCreate = new TargetX_SRMb__Recommendation__c(
                    Name = 'Recommendation Letter ' + String.valueof(i),
                    TargetX_SRMb__Contact__c = applicationForRecommendation.TargetX_SRMb__Contact__c,
                    TargetX_SRMb__Application__c = applicationForRecommendation.id,
                    TargetX_SRMb__Type__c = 'Teacher',
                    TargetX_SRMb__Status__c = 'Complete',
                    IIT_Insufficiency_ID_Desc__c = 'Wrong document was uploaded'
                );
                insuffRecommendationsToCreate.add(insuffRecommendationToCreate);
            }
        }
        
        return insuffRecommendationsToCreate;
    }
    
    public static List<TargetX_SRMb__Recommendation__c> dataIncRecommendations(List<TargetX_SRMb__Application__c> applicationsForRecommendations, Integer numberOfRecommendationsPerApplication) {
        List<TargetX_SRMb__Recommendation__c> incRecommendationsToCreate = new List<TargetX_SRMb__Recommendation__c>();
        
        for(TargetX_SRMb__Application__c applicationForRecommendation : applicationsForRecommendations) {
            for(Integer i = 0; i < numberOfRecommendationsPerApplication; i++) {
                TargetX_SRMb__Recommendation__c incRecommendationToCreate = new TargetX_SRMb__Recommendation__c(
                    Name = 'Recommendation Letter ' + String.valueof(i),
                    TargetX_SRMb__Contact__c = applicationForRecommendation.TargetX_SRMb__Contact__c,
                    TargetX_SRMb__Application__c = applicationForRecommendation.id,
                    TargetX_SRMb__Type__c = 'Teacher',
                    TargetX_SRMb__Status__c = 'Incomplete'
                );
                incRecommendationsToCreate.add(incRecommendationToCreate);
            }
        }
        
        return incRecommendationsToCreate;
    }
    
    public static List<TargetX_Reader__Application_Review_Type__c> dataApplicationReviewTypes() {
        List<TargetX_Reader__Application_Review_Type__c> reviewTypesToCreate = new List<TargetX_Reader__Application_Review_Type__c>();
        
        TargetX_Reader__Application_Review_Type__c applicationReviewTypeToCreate = new TargetX_Reader__Application_Review_Type__c(
            Name = 'UG Initial Review FY US'
        );
        reviewTypesToCreate.add(applicationReviewTypeToCreate);
        
        return reviewTypesToCreate;
    }
    
    public static List<TargetX_Reader__Application_Review__c> dataApplicationReviews(List<TargetX_SRMb__Application__c> applicationsForReviews, List<TargetX_Reader__Application_Review_Type__c> applicationReviewTypes, Integer numberOfReviewsPerApplication) {
        List<TargetX_Reader__Application_Review__c> reviewsToCreate = new List<TargetX_Reader__Application_Review__c>();
        
        List<String> applicationReviewHighestMaths = dataApplicationReviewHighestMaths();
        List<String> applicationReviewRigorRatings = dataApplicationReviewRigorRatings();
        
        for(TargetX_SRMb__Application__c applicationForReview : applicationsForReviews) {
            for(Integer i = 0; i < numberOfReviewsPerApplication; i++) {
                TargetX_Reader__Application_Review__c reviewToCreate = new TargetX_Reader__Application_Review__c(
                    TargetX_Reader__Application__c = applicationForReview.id,
                    TargetX_Reader__Application_Review_Type__c = applicationReviewTypes[Math.mod(i,applicationReviewTypes.size())].Id,
                    IIT_Level__c = 'Undergraduate',
                    IIT_Highest_Math__c = applicationReviewHighestMaths[(Math.floor(Math.random() * ((3-0)+1) + 0)).intValue()],
                    IIT_Rigor_Rating__c = applicationReviewRigorRatings[(Math.floor(Math.random() * ((3-0)+1) + 0)).intValue()]
                );
                reviewsToCreate.add(reviewToCreate);
            }
        }
        
        return reviewsToCreate;
    }
    
    public static List<IIT_Courses__c> dataCourses(Integer numberOfCourses) {
        List<IIT_Courses__c> coursesToCreate = new List<IIT_Courses__c>();
        for(Integer i = 0; i < numberOfCourses; i++) {
            IIT_Courses__c courseToCreate = new IIT_Courses__c(
                Name = (numberOfCourses >= 100 ? 'IIT ' + String.valueof(i) : (numberOfCourses >= 10 ? 'IIT 1' + String.valueof(i) : 'IIT 10' + String.valueof(i)))
            );
            coursesToCreate.add(courseToCreate);
        }
        return coursesToCreate;
    }
    
    public static List<IIT_Course_Evaluation__c> dataCourseEvaluations(List<Contact> contactsForCourseEvaluations, Integer numberOfCourseEvaluationsPerContact) {
        List<IIT_Course_Evaluation__c> courseEvaluationsToCreate = new List<IIT_Course_Evaluation__c>();
        
        for(Contact contactForCourseEvaluation : contactsForCourseEvaluations) {
            for(Integer i = 0; i < numberOfCourseEvaluationsPerContact; i++) {
                IIT_Course_Evaluation__c courseEvaluationToCreate = new IIT_Course_Evaluation__c(
                    IIT_Course_Name__c = (numberOfCourseEvaluationsPerContact >= 100 ? 'IIT ' + String.valueof(i) : (numberOfCourseEvaluationsPerContact >= 10 ? 'IIT 1' + String.valueof(i) : 'IIT 10' + String.valueof(i))),
                    IIT_Course_Title__c = 'Course ' + String.valueof(i),
                    IIT_IIT_Course_Equivalent__c = (numberOfCourseEvaluationsPerContact >= 100 ? 'IIT ' + String.valueof(i) : (numberOfCourseEvaluationsPerContact >= 10 ? 'IIT 1' + String.valueof(i) : 'IIT 10' + String.valueof(i))),
                    IIT_IIT_Course_Equivalent_Title__c = 'Course ' + String.valueof(i),
                    IIT_Semester_Hours__c = 3,
                    IIT_School__c = contactForCourseEvaluation.AccountId,
                    IIT_Student__c = contactForCourseEvaluation.id
                );
                courseEvaluationsToCreate.add(courseEvaluationToCreate);
            }
        }
        
        return courseEvaluationsToCreate;
    }
    
    public static List<Account> dataSupportAccounts(Integer numberOfSupportAccounts) {
        List<Account> supportAccountsToCreate = new List<Account>();
        
        for(Integer i = 0; i < numberOfSupportAccounts; i++) {
            Account supportAccountToCreate = new Account(
                Name = 'IIT ' + String.valueof(i),
                TargetX_SRMb__ceeb_code__c = (numberOfSupportAccounts >= 100 ? '111' + String.valueof(i) : (numberOfSupportAccounts >= 10 ? '1111' + String.valueof(i) : '11111' + String.valueof(i))),
                RecordTypeId = '012j0000000zCdB'
            );
            supportAccountsToCreate.add(supportAccountToCreate);
        }
        
        return supportAccountsToCreate;
    }
    
    public static List<Contact> dataSupportContacts(List<Account> accountsForSupportContacts, Integer numberOfSupportContactsPerAccount) {
        List<Contact> supportContactsToCreate = new List<Contact>();
        
        for(Account accountForSupportContact : accountsForSupportContacts) {
            for(Integer i = 0; i < numberOfSupportContactsPerAccount; i++) {
                Contact supportContactToCreate = new Contact(
                    FirstName = 'Support' + String.valueof(i),
                    LastName = 'Contact' + String.valueof(i),
                    AccountId = accountForSupportContact.id,
                    Email = 'bwoods5+test' + String.valueof(i) + '@iit.edu',
                    RecordTypeId = '012j00000010JL7'
                );
                supportContactsToCreate.add(supportContactToCreate);
            }
        }
        
        return supportContactsToCreate;
    }
    
}