@isTest
public class IITSSControllerTests {
    
    @isTest(SeeAllData = 'true')
    public static void conductIITSSLoginControllerTesting() {
        
        //Get Admin User for Testing
        IITScholarshipSymposiumSiteUsers__c ssUserA = [SELECT Id
                                                      , Name
                                                      , IIT_User_Password__c
                                                      , IIT_Session_ID__c
                                                      , IIT_Full_Name__c
                                                      , IIT_Admin_User__c
                                                      FROM IITScholarshipSymposiumSiteUsers__c
                                                      WHERE IIT_Admin_User__c = TRUE
                                                      LIMIT 1
                                                      ];
        
        
        //Test Correct Credentials
        PageReference pageRef = Page.SSLogin;
        Test.setCurrentPage(pageRef);
        IITSSLoginController loginController = new IITSSLoginController();
        loginController.username = ssUserA.Name;
        loginController.password = ssUserA.IIT_User_Password__c;
        loginController.login();
        
        
        //Test Incorrect Username
        pageRef = Page.SSLogin;
        Test.setCurrentPage(pageRef);        
        loginController = new IITSSLoginController();
        loginController.username = ssUserA.Name + 'TEST';
        loginController.password = ssUserA.IIT_User_Password__c;
        loginController.login();
        
        
        //Test Incorrect Password
        pageRef = Page.SSLogin;
        Test.setCurrentPage(pageRef);        
        loginController = new IITSSLoginController();
        loginController.username = ssUserA.Name;
        loginController.password = ssUserA.IIT_User_Password__c + 'TEST';
        loginController.login();
        
        
        //Test Inactive User
        ssUserA.IIT_Active__c = FALSE;
        update ssUserA;
        
        pageRef = Page.SSLogin;
        Test.setCurrentPage(pageRef);        
        loginController = new IITSSLoginController();
        loginController.username = ssUserA.Name;
        loginController.password = ssUserA.IIT_User_Password__c;
        loginController.login();
        
        
        //Test Error Messages
        pageRef = Page.SSLogin;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('error','u');
        loginController = new IITSSLoginController();
        loginController.getErrorMessage();
        ApexPages.currentPage().getParameters().put('error','p');
        loginController = new IITSSLoginController();
        loginController.getErrorMessage();
        ApexPages.currentPage().getParameters().put('error','a');
        loginController = new IITSSLoginController();
        loginController.getErrorMessage();
        
        
        //Test Forgot Password
        pageRef = Page.SSForgotPassword;
        Test.setCurrentPage(pageRef);
        loginController = new IITSSLoginController();
        loginController.username = 'Admin';
        loginController.requestPassword();
        
    }
    
    @isTest(SeeAllData = 'true')
    public static void conductIITSSControllerTesting() {
        
        //Update IITScholarshipSymposiumSiteSettings with Event Id from 2017
        Id eventId = [SELECT Id FROM TargetX_Eventsb__OrgEvent__c WHERE Name = 'Scholarship Symposium 2017' LIMIT 1].id;
        string startTerm = 'Fall 2017';
        IITScholarshipSymposiumSiteSettings__c ssSettings = [SELECT Id
                                                            , Name
                                                            , IIT_Scholarship_Symposium_Event_ID__c
                                                            , IIT_Application_Start_Term__c
                                                            FROM IITScholarshipSymposiumSiteSettings__c
                                                            WHERE Name = 'Default'
                                                            ];
        ssSettings.IIT_Scholarship_Symposium_Event_ID__c = eventId;
        ssSettings.IIT_Application_Start_Term__c = startTerm;
        update ssSettings;
        
        
        //Get Contact for Testing
        Id contactId = [SELECT TargetX_Eventsb__Contact__c
                       FROM TargetX_Eventsb__ContactScheduleItem__c
                       WHERE TargetX_Eventsb__OrgEvent__c = :eventId
                       AND TargetX_Eventsb__Attended__c = TRUE
                       AND IIT_SW_Interview_Date_and_Time__c != NULL
                       LIMIT 1
                       ].TargetX_Eventsb__Contact__c;
        
        
        //Get Admin User for Testing
        IITScholarshipSymposiumSiteUsers__c ssUserA = [SELECT Id
                                                      , Name
                                                      , IIT_User_Password__c
                                                      , IIT_Session_ID__c
                                                      , IIT_Full_Name__c
                                                      , IIT_Admin_User__c
                                                      FROM IITScholarshipSymposiumSiteUsers__c
                                                      WHERE IIT_Admin_User__c = TRUE
                                                      LIMIT 1
                                                      ];
        
        
        //Get Non-Admin User for Testing (Toni Riley)
        IITScholarshipSymposiumSiteUsers__c ssUserNA = [SELECT Id
                                                       , Name
                                                       , IIT_User_Password__c
                                                       , IIT_Session_ID__c
                                                       , IIT_Full_Name__c
                                                       , IIT_Admin_User__c
                                                       FROM IITScholarshipSymposiumSiteUsers__c
                                                       WHERE Name = 'A20344768'
                                                       LIMIT 1
                                                       ];
        
        
        //Test Scholarship Symposium Dashboard Page
        
        //Test Access Error with Bad Username
        PageReference pageRef = Page.SSDashboard;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('uid','FakeUser');
        IITSSController controller = new IITSSController();
        controller.getAccessError();
        System.assertEquals(TRUE, controller.getAccessError());
        
        //Test Admin View
        pageRef = Page.SSDashboard;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('uid',ssUserA.Name);
        ApexPages.currentPage().getParameters().put('sid',ssUserA.IIT_Session_ID__c);
        controller = new IITSSController();
        controller.getUsername();
        controller.getSessionId();
        controller.getUserFullName();
        controller.getAdminUser();
        controller.getInterviewList();
        
        //Test Non-Admin View
        pageRef = Page.SSDashboard;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('uid',ssUserNA.Name);
        ApexPages.currentPage().getParameters().put('sid',ssUserNA.IIT_Session_ID__c);
        controller = new IITSSController();
        controller.getUsername();
        controller.getSessionId();
        controller.getUserFullName();
        controller.getAdminUser();
        controller.getInterviewList();
        
        
        //Test Scholarship Symposium Applicant Detail Page
        
        //Test Non-Admin Access and Applicant Data Retrieval
        pageRef = Page.SSApplicantDetail;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('uid',ssUserNA.Name);
        ApexPages.currentPage().getParameters().put('sid',ssUserNA.IIT_Session_ID__c);
        ApexPages.currentPage().getParameters().put('cid',contactId);
        controller = new IITSSController();
        controller.getUsername();
        controller.getSessionId();
        controller.getUserFullName();
        controller.getInterview();
        controller.getApplication();
        controller.getAppAttachments();
        controller.getSSAttachments();
        
        //Test Review Submission and Retrieval
        controller.getReviewRatings();
        controller.getReviewYesNo();
        controller.getReviewFinal();
        controller.reviewRobustIntellectualCuriosity = '6';
        controller.reviewAcadDetermination = '6';
        controller.reviewLeadership = '6';
        controller.reviewService = '6';
        controller.reviewDesireToEngage = '6';
        controller.reviewAlumniDonors = 'Yes';
        controller.reviewOverall = 'Strongly Recommend';
        controller.reviewComments = 'Comments';
        controller.submitReview();
        controller.getReview();
        
        //Test Review Submission Exception
        controller.reviewRobustIntellectualCuriosity = 'BadData';
        controller.submitReview();
        
    }
    
    @isTest(SeeAllData = 'TRUE')
    public static void conductIITSSEmailUsersTesting() {
        
        IITSSEmailUsers emailController = new IITSSEmailUsers();
        emailController.sendEmails();
        
    }

}