Public with sharing class IITSSEmailUsers {
	
    public void sendEmails() {
        
		List<IITScholarshipSymposiumSiteUsers__c> ssUserList = [Select Name, IIT_Email__c, IIT_User_Password__c From IITScholarshipSymposiumSiteUsers__c Where IIT_Active__c = true];
    
    	List<Messaging.SingleEmailMessage>  emailList = new List<Messaging.SingleEmailMessage>();
	
    	for(IITScholarshipSymposiumSiteUsers__c u : ssUserList) {
			String[] toAddresses = new String[] {u.IIT_Email__c};
			String[] bccAddresses = new String[] {'bwoods5@iit.edu'};
			Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    		email.setToAddresses(toAddresses);
    		email.setOrgWideEmailAddressId('0D2j00000000CKU');
    		email.setReplyTo('studentsystem@iit.edu');
    		email.setBccAddresses(bccAddresses);
    		email.setSubject('Illinois Tech Scholarship Symposium Password');
    		email.setPlainTextBody('Your password to the system is:  ' + u.IIT_User_Password__c);
			emailList.add(email);
    	}

		Messaging.sendEmail(emailList,false);
        
    }
}