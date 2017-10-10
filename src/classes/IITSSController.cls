public with sharing class IITSSController {
	
    public string username;
    public string sessionId;
    public string userFullName;
    public string sessionIdMap;
    public boolean adminUser;
    public boolean accessError;
    public string startTerm;
    public string eventId;
    public string contactId;
    public string reviewRobustIntellectualCuriosity {get;set;}
    public string reviewAcadDetermination {get;set;}
    public string reviewLeadership {get;set;}
    public string reviewService {get;set;}
    public string reviewDesireToEngage {get;set;}
    public string reviewAlumniDonors {get;set;}
    public string reviewOverall {get;set;}
    public string reviewComments {get;set;}
    
    
    public IITSSController() {
        
        username = System.currentPageReference().getParameters().get('uid');
        sessionId = System.currentPageReference().getParameters().get('sid');
        contactId = System.currentPageReference().getParameters().get('cid');
        
        map<string, IITScholarshipSymposiumSiteUsers__c> ssUserMap = IITScholarshipSymposiumSiteUsers__c.getAll();
        if (ssUserMap.keySet().contains(username) == true) {
        	sessionIdMap = ssUserMap.get(username).IIT_Session_ID__c;
            userFullName = ssUserMap.get(username).IIT_Full_Name__c;
            adminUser = ssUserMap.get(username).IIT_Admin_User__c;
            accessError = (sessionId == sessionIdMap ? FALSE : TRUE);
        } else {
            accessError = TRUE;
        }
        
        map<string, IITScholarshipSymposiumSiteSettings__c> ssSettingsMap = IITScholarshipSymposiumSiteSettings__c.getAll();
        startTerm = ssSettingsMap.get('Default').IIT_Application_Start_Term__c;
        eventId = ssSettingsMap.get('Default').IIT_Scholarship_Symposium_Event_ID__c;
        
    }
    
    Public List<TargetX_Eventsb__ContactScheduleItem__c> getInterviewList() {
        List<TargetX_Eventsb__ContactScheduleItem__c> interviewList = new List<TargetX_Eventsb__ContactScheduleItem__c>();
        if (adminUser == TRUE) {
            interviewList = [SELECT Id
							, TargetX_Eventsb__Contact__r.Id
							, TargetX_Eventsb__Contact__r.FirstName
							, TargetX_Eventsb__Contact__r.LastName
							, IIT_SW_Interview_Date_and_Time__c
							, IIT_SW_Interview_Date_and_Time_for_Merge__c
							, IIT_SW_Interview_Location__c
							, IIT_SW_Interview_Faculty__c
							, IIT_SW_Interview_Rating_Complete__c
							FROM TargetX_Eventsb__ContactScheduleItem__c
							WHERE TargetX_Eventsb__OrgEvent__r.Id = :eventId
							AND IIT_SW_Interview_Date_and_Time__c <> null
							ORDER BY IIT_SW_Interview_Date_and_Time__c ASC
							, TargetX_Eventsb__Contact__r.LastName ASC
							];
        } else {
            interviewList = [SELECT Id
							, TargetX_Eventsb__Contact__r.Id
							, TargetX_Eventsb__Contact__r.FirstName
							, TargetX_Eventsb__Contact__r.LastName
							, IIT_SW_Interview_Date_and_Time__c
							, IIT_SW_Interview_Date_and_Time_for_Merge__c
							, IIT_SW_Interview_Location__c
							, IIT_SW_Interview_Faculty__c
							, IIT_SW_Interview_Rating_Complete__c
							FROM TargetX_Eventsb__ContactScheduleItem__c
							WHERE TargetX_Eventsb__OrgEvent__r.Id = :eventId
							AND IIT_SW_Interview_Date_and_Time__c <> null
							AND IIT_SW_Interview_Faculty_Lookup__r.TargetX_SRMb__BannerID__c = :username
							ORDER BY IIT_SW_Interview_Date_and_Time__c ASC
							, TargetX_Eventsb__Contact__r.LastName ASC
							];
        }
        return interviewList;
    }
    
    Public TargetX_Eventsb__ContactScheduleItem__c getInterview() {
        TargetX_Eventsb__ContactScheduleItem__c interview = [
            SELECT Id
            , TargetX_Eventsb__Contact__r.Id
            , TargetX_Eventsb__Contact__r.FirstName
            , TargetX_Eventsb__Contact__r.LastName
            , IIT_SW_Interview_Date_and_Time__c
            , IIT_SW_Interview_Date_and_Time_for_Merge__c
            , IIT_SW_Interview_Location__c
            , IIT_SW_Interview_Faculty__c
            , IIT_SW_Interview_Rating_Complete__c
            FROM TargetX_Eventsb__ContactScheduleItem__c
            WHERE TargetX_Eventsb__OrgEvent__r.Id = :eventId
            AND TargetX_Eventsb__Contact__r.Id = :contactId
            LIMIT 1
        ];
        return interview;
    }
    
    Public TargetX_SRMb__Application__c getApplication() {
        TargetX_SRMb__Application__c application = [
			SELECT Id
            , TargetX_SRMb__Possible_Academic_Major__c
			FROM TargetX_SRMb__Application__c
			WHERE TargetX_SRMb__Contact__c = :contactId
            AND TargetX_SRMb__Start_Term_and_Year__c = :startTerm
            LIMIT 1
        ];
		return application;
    }
    
    Public List<Attachment> getAppAttachments() {
        string applicationId = getApplication().Id;
        List<Attachment> attachment = [
            SELECT Id
            , Name
            FROM Attachment
            WHERE ParentID = :applicationId
            AND (Name like '%TE%' OR Name like '%OE%' OR Name like '%REF%' OR Name like '%CR%')
        ];
        return attachment;
    }
    
    Public List<Attachment> getSSAttachments() {
        string applicationId = getApplication().Id;
        List<Attachment> attachment = [
            SELECT Id
            , Name
            FROM Attachment
            WHERE ParentId IN (SELECT Id from TargetX_SRMb__Essay__c WHERE TargetX_SRMb__Application__c = :applicationId AND Name = 'Scholarship Weekend Resume')
        ];
        return attachment;
    }
    
    Public TargetX_Reader__Application_Review__c getReview() {
        TargetX_Reader__Application_Review__c review = [
            SELECT Id
            , TargetX_Reader__Completed__c
        	, TargetX_Reader__Date_Completed__c
        	, IIT_Camras_Robust_Intellectual_Curiosity__c
        	, IIT_Camras_Academic_Determination__c
        	, IIT_Camras_Demonstrated_Leadership__c
        	, IIT_Camras_Commitment_to_Service__c
        	, IIT_Camras_Desire_to_Engage_Community__c
        	, IIT_Camras_Alumni_and_Donor__c
        	, IIT_Camras_Overall__c
        	, IIT_Camras_Comments__c
            FROM TargetX_Reader__Application_Review__c
            WHERE TargetX_Reader__Application__c IN (SELECT Id FROM TargetX_SRMb__Application__c WHERE TargetX_SRMb__Contact__c = :contactId AND TargetX_SRMb__Start_Term_and_Year__c = :startTerm)
            AND TargetX_Reader__Application_Review_Type__c = 'a1Pj0000004pPrbEAE'
            LIMIT 1
        ];
        return review;
    }
    
    Public List<SelectOption> getReviewRatings() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('',''));
        options.add(new SelectOption('1','1 - Below Average'));
        options.add(new SelectOption('2','2'));
        options.add(new SelectOption('3','3'));
        options.add(new SelectOption('4','4'));
        options.add(new SelectOption('5','5'));
        options.add(new SelectOption('6','6 - Truly Exceptional'));
        return options;
    }
    
    Public List<SelectOption> getReviewYesNo() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('',''));
        options.add(new SelectOption('Yes','Yes'));
        options.add(new SelectOption('No','No'));
        return options;
    }
    
    Public List<SelectOption> getReviewFinal() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('',''));
        options.add(new SelectOption('Strongly Recommend','Strongly recommend as a Camras Scholar'));
        options.add(new SelectOption('Recommend','Recommend as a Camras Scholar'));
        options.add(new SelectOption('Recommend with Reservations','Recommend with reservations (please note below)'));
        options.add(new SelectOption('Not Recommend','Not recommend as a Camras Scholar'));
        return options;
    }
    
    Public PageReference submitReview() {
        
        try {
        	TargetX_Reader__Application_Review__c r = new TargetX_Reader__Application_Review__c();
        	r.RecordTypeId = '012j0000000ufNSAAY';
        	r.TargetX_Reader__Application_Review_Type__c = 'a1Pj0000004pPrbEAE';
        	r.TargetX_Reader__Application__c = getApplication().Id;
        	r.IIT_Level__c = 'Undergraduate';
        	r.OwnerId = '005j000000CDWJDAA5';
        	r.TargetX_Reader__Completed__c = TRUE;
        	r.TargetX_Reader__Date_Completed__c = System.Datetime.newInstance(System.now().date(), System.now().time());
        	r.IIT_Decision__c = 'None';
        	r.IIT_Camras_Robust_Intellectual_Curiosity__c = reviewRobustIntellectualCuriosity;
        	r.IIT_Camras_Academic_Determination__c = reviewAcadDetermination;
        	r.IIT_Camras_Demonstrated_Leadership__c = reviewLeadership;
        	r.IIT_Camras_Commitment_to_Service__c = reviewService;
        	r.IIT_Camras_Desire_to_Engage_Community__c = reviewDesireToEngage;
        	r.IIT_Camras_Alumni_and_Donor__c = reviewAlumniDonors;
        	r.IIT_Camras_Overall__c = reviewOverall;
        	r.IIT_Camras_Comments__c = reviewComments + '\r\n' + 'Completed By:  ' + userFullName;
        	insert r;
            
            TargetX_Eventsb__ContactScheduleItem__c interviewToUpdate;
            interviewToUpdate = getInterview();
            interviewToUpdate.IIT_SW_Interview_Rating_Complete__c = TRUE;
        	update interviewToUpdate;
            
        } catch (DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        
        PageReference redirectPage = Page.SSDashboard;
		redirectPage.setRedirect(true);
		redirectPage.getParameters().put('uid',username);
		redirectPage.getParameters().put('sid',sessionId);
		return redirectPage;
    }
    
    public boolean getAccessError() {
        return accessError;
    }
    
    public string getUserFullName() {
        return userFullName;
    }
    
    public string getUsername() {
        return username;
    }
    
    public string getSessionId() {
        return sessionId;
    }
    
    public boolean getAdminUser() {
        return adminUser;
    }
    
}