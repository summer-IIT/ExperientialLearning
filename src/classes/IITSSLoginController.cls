public with sharing class IITSSLoginController {
    
    public string username { get; set; }
    public string password { get; set; }
    public string passwordMap;
	public string sessionId;
    public string userEmail;
	public boolean active;
	public boolean validatedUser;
    public string error;
    public string errorCode;
    public string errorMessage;
    
    public IITSSLoginController() {
        
        errorCode = System.currentPageReference().getParameters().get('error');
        if(errorCode == 'u') {
            errorMessage = 'Invalid username or user not authorized to access the system. Please contact studentsystem@iit.edu for assistance.';
        } else if (errorCode == 'p') {
            errorMessage = 'Invalid password, please verify your password is correct or use the forgot password button above.';
        } else if (errorCode == 'a') {
            errorMessage = 'User is not currently active. Please contact studentsystem@iit.edu for assistance.';
        } else {
            errorMessage = NULL;
        }
        
    }
    
    public PageReference login() {
        
        map<string, IITScholarshipSymposiumSiteUsers__c> ssUserMap = IITScholarshipSymposiumSiteUsers__c.getAll();
		
        if(ssUserMap.keySet().contains(username) == TRUE) {
            passwordMap = ssUserMap.get(username).IIT_User_Password__c;
        	sessionId = ssUserMap.get(username).IIT_Session_ID__c;
        	active = ssUserMap.get(username).IIT_Active__c;
        	validatedUser = (password == passwordMap && active == TRUE ? TRUE : FALSE);
        } else {
            validatedUser = FALSE;
        }
        
        if(ssUserMap.keySet().contains(username) == FALSE) {
            error = 'u';
        } else if (active == FALSE) {
            error = 'a';
        } else if (validatedUser == FALSE) {
            error = 'p';
        } else {
            error = NULL;
        }
        
        if(validatedUser == true) {
            PageReference redirectPage = Page.SSDashboard;
            redirectPage.setRedirect(true);
            redirectPage.getParameters().put('uid',username);
            redirectPage.getParameters().put('sid',sessionId);
            return redirectPage;
        } else {
            PageReference redirectPage = Page.SSLogin;
            redirectPage.setRedirect(true);
            redirectPage.getParameters().put('error',error);
            return redirectPage;
        }
        
    }
    
    public PageReference requestPassword() {
        
        map<string, IITScholarshipSymposiumSiteUsers__c> ssUserMap = IITScholarshipSymposiumSiteUsers__c.getAll();
		
        if(ssUserMap.keySet().contains(username) == TRUE) {
            userEmail = ssUserMap.get(username).IIT_Email__c;
            passwordMap = ssUserMap.get(username).IIT_User_Password__c;
        }
        
        String[] toAddresses = new String[] {userEmail};
        String[] bccAddresses = new String[] {'bwoods5@iit.edu'};
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(toAddresses);
        email.setOrgWideEmailAddressId('0D2j00000000CKU');
        email.setReplyTo('studentsystem@iit.edu');
        email.setBccAddresses(bccAddresses);
        email.setSubject('Illinois Tech Scholarship Symposium Password Request');
        email.setPlainTextBody('Your password to the system is:  ' + passwordMap);  
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email },false);
        
        PageReference redirectPage = Page.SSLogin;
        redirectPage.setRedirect(true);
        return redirectPage;
        
    }
    
    public string getErrorMessage() {
        return errorMessage;
    }

}