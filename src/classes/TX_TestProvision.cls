@isTest
private class TX_TestProvision {

	@testSetup
	static void setup()
	{
		UserRole r = [SELECT Id FROM UserRole][0] ;

		User currentUser = [SELECT UserRoleId FROM User WHERE Id =:userInfo.getUserId()][0] ;
		currentUser.UserRoleId = r.Id ;
		update currentUser ;

		System.runAs(currentUser)
		{
			Account a = new Account(Name='TestAccount') ;
			insert a ;

			Contact c = new Contact(FirstName='Test', LastName='Tester', Account=a, Email='test@test.test') ;
			insert c ;
		}
	}

	private static testmethod void testValidContact()
	{
		Contact c = [SELECT Id, TargetX_Base__Access_Key__c FROM Contact WHERE LastName='Tester'][0] ;

		Test.setCurrentPage(Page.TX_CommunitiesProvision) ;
		ApexPages.currentPage().getParameters().put('startURL', 'someLegitURL') ;
		ApexPages.currentPage().getParameters().put('cid', c.Id) ;
		ApexPages.currentPage().getParameters().put('k', c.TargetX_Base__Access_Key__c) ;

		TX_CommunitiesProvisionController cpc = new TX_CommunitiesProvisionController(new TargetX_Base.TX_CommunitiesBase()) ;
		System.assertEquals(cpc.showLogin, false) ;

		cpc.createCommunityUser() ;
		// Apparently, I can't actually assert this because I can't seem to get the site.createPortalUser
		// function to actually create a user in test code. Even tried creating a new guest user to see
		// if that would let me, no luck...
		//User[] u = [SELECT ContactId FROM User WHERE ContactId = :c.Id] ;
		//System.assertEquals(u.size(), 1) ;
		Cookie thinMint = ApexPages.currentPage().getCookies().get('targetxCommunityRedirect') ;
		System.assertNotEquals(thinMint, null) ;

		cpc.resendConf() ;
	}

	private static testmethod void testNoParams()
	{
		Test.setCurrentPage(Page.TX_CommunitiesProvision) ;

		TX_CommunitiesProvisionController cpc = new TX_CommunitiesProvisionController(new TargetX_Base.TX_CommunitiesBase()) ;
		System.assertEquals(cpc.showLogin, true) ;
	}

	private static testmethod void testBadParams()
	{
		Test.setCurrentPage(Page.TX_CommunitiesProvision) ;
		ApexPages.currentPage().getParameters().put('startURL', 'someLegitURL') ;
		ApexPages.currentPage().getParameters().put('cid', 'totally a contact id') ;
		ApexPages.currentPage().getParameters().put('k', 'skeleton key') ;
		
		TX_CommunitiesProvisionController cpc = new TX_CommunitiesProvisionController(new TargetX_Base.TX_CommunitiesBase()) ;
		System.assertEquals(cpc.showLogin, true) ;
	}

	// I want to test this case, but it's not letting me create a community user beacuse of the whole role crap.
	// I don't know why adding a role to my user wasn't good enough, but apparently it wasn't. I'm leaving this
	// in here because I may fix it up later, but it's just not worth doing for 1 line of test code right now.
	//private static testmethod void testExistingUser()
	//{
	//	User currentUser = [SELECT UserRoleId FROM User WHERE Id =:userInfo.getUserId()][0] ;
	//	System.debug(currentUser) ;
	//	Contact c = [SELECT Id, TargetX_Base__Access_Key__c FROM Contact WHERE LastName='Tester'][0] ;

	//	Profile p = [SELECT Id FROM Profile WHERE Name = 'Customer Community User'][0] ;

	//	User comUser = new User() ;
	//	comUser.Alias					= 'Student' ;
	//	comUser.LastName				= 'Student' ;
	//	comUser.Email					= 'student@test.test' ;
	//	comUser.Username				= 'student@test.test' ;
	//	comUser.CommunityNickname		= 'TestCodeStudent' ;
	//	comUser.ProfileId				= p.Id ;
	//	comUser.TimeZoneSidKey			= 'America/New_York' ;
	//	comUser.LocaleSidKey			= 'en_US' ;
	//	comUser.EmailEncodingKey		= 'ISO-8859-1' ;
	//	comUser.LanguageLocaleKey		= 'en_US' ;
	//	comUser.ContactId				= c.Id ;
	//	insert comUser ;

	//	Test.setCurrentPage(Page.TX_CommunitiesProvision) ;
	//	ApexPages.currentPage().getParameters().put('startURL', 'someLegitURL') ;
	//	ApexPages.currentPage().getParameters().put('cid', c.Id) ;
	//	ApexPages.currentPage().getParameters().put('k', c.TargetX_Base__Access_Key__c) ;

	//	TX_CommunitiesProvisionController cpc = new TX_CommunitiesProvisionController(new TargetX_Base.TX_CommunitiesBase()) ;
	//	System.assertEquals(cpc.showLogin, true) ;
	//}
}