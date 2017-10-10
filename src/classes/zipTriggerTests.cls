@isTest
private class zipTriggerTests {

	@isTest static void testContactLookup() {
		makeZips() ;

		Contact[] cons = new List<Contact>() ;

		cons.add(new Contact(FirstName='Test0',LastName='Link',MailingPostalCode='00764')) ;
		cons.add(new Contact(FirstName='Test1',LastName='Malon',MailingPostalCode='12345')) ;
		cons.add(new Contact(FirstName='Test2',LastName='Ganondorf',MailingPostalCode='66666')) ;
		cons.add(new Contact(FirstName='Test3',LastName='Anju',MailingPostalCode='52224',MailingState='Something')) ;

		insert cons ;

		Contact[] updatedCons =	[SELECT LastName,MailingPostalCode,MailingState,MailingCity,TargetX_SRMb__EPS_Code__c
								FROM Contact WHERE FirstName LIKE 'Test%' ORDER BY FirstName ASC] ;

		System.AssertEquals(updatedCons[0].TargetX_SRMb__EPS_Code__c, 'HY03') ;
		System.AssertEquals(updatedCons[0].MailingState, 'Hyrule') ;
		System.AssertEquals(updatedCons[1].TargetX_SRMb__EPS_Code__c, 'HY01') ;
		System.AssertEquals(updatedCons[1].MailingCity, 'Hyrule Field') ;
		System.AssertEquals(updatedCons[2].TargetX_SRMb__EPS_Code__c, null) ;
		System.AssertEquals(updatedCons[2].MailingCity, null) ;
		System.AssertEquals(updatedCons[2].MailingState, null) ;
		System.AssertEquals(updatedCons[3].TargetX_SRMb__EPS_Code__c, 'HY02') ;
		System.AssertEquals(updatedCons[3].MailingState, 'Hyrule') ;
		System.AssertEquals(updatedCons[3].MailingCity, 'Hyrule Field') ;

		Contact cToUpdate = updatedCons[2] ;
		cToUpdate.MailingPostalCode = '77777' ;

		update cToUpdate ;

		Contact[] updatedC = [SELECT TargetX_SRMb__EPS_Code__c FROM Contact WHERE LastName='Ganondorf'] ;

		System.AssertEquals(updatedC[0].TargetX_SRMb__EPS_Code__c, 'HY04') ;
	}

	@isTest static void testAccountLookup() {
		makeZips() ;

		Account[] accs = new List<Account>() ;

		accs.add(new Account(AccountNumber='Test0',Name='Lon Lon Academy',BillingPostalCode='12345')) ;
		accs.add(new Account(AccountNumber='Test1',Name='Kakariko University',BillingPostalCode='52224',BillingCity='Something')) ;
		accs.add(new Account(AccountNumber='Test2',Name='Gerudo Training Grounds',BillingPostalCode='54321')) ;

		insert accs ;

		Account[] updatedAccs =	[SELECT Name,BillingPostalCode,BillingState,BillingCity,TargetX_SRMb__EPS_Code__c
								FROM Account WHERE AccountNumber LIKE 'Test%' ORDER BY AccountNumber ASC] ;

		System.AssertEquals(updatedAccs[0].TargetX_SRMb__EPS_Code__c, 'HY01') ;
		System.AssertEquals(updatedAccs[1].TargetX_SRMb__EPS_Code__c, 'HY02') ;
		System.AssertEquals(updatedAccs[1].BillingState, 'Hyrule') ;
		System.AssertEquals(updatedAccs[1].BillingCity, 'Hyrule Field') ;
		System.AssertEquals(updatedAccs[2].TargetX_SRMb__EPS_Code__c, null) ;

		Account aToUpdate = updatedAccs[2] ;
		aToUpdate.BillingPostalCode = '99999' ;

		update aToUpdate ;

		Account[] updatedA = [SELECT TargetX_SRMb__EPS_Code__c FROM Account WHERE Name='Gerudo Training Grounds'] ;

		System.AssertEquals(updatedA[0].TargetX_SRMb__EPS_Code__c, 'HY05') ;
	}
	
	@isTest static void testLeadLookup() {
		makeZips() ;

		Lead[] leads = new List<Lead>() ;

		leads.add(new Lead(Company='Triforce Inc.',FirstName='Test0',LastName='Link',PostalCode='00764')) ;
		leads.add(new Lead(Company='Triforce Inc.',FirstName='Test1',LastName='Malon',PostalCode='12345')) ;
		leads.add(new Lead(Company='Triforce Inc.',FirstName='Test2',LastName='Ganondorf',PostalCode='66666')) ;
		leads.add(new Lead(Company='Triforce Inc.',FirstName='Test3',LastName='Anju',PostalCode='52224',TargetX_SRMb__County__c='Something')) ;

		insert leads ;

		Lead[] updatedLeads =	[SELECT LastName,PostalCode,State,City,TargetX_SRMb__EPS_Code__c,TargetX_SRMb__County__c
								FROM Lead WHERE FirstName LIKE 'Test%' ORDER BY FirstName ASC] ;

		System.AssertEquals(updatedLeads[0].TargetX_SRMb__EPS_Code__c, 'HY03') ;
		System.AssertEquals(updatedLeads[1].TargetX_SRMb__EPS_Code__c, 'HY01') ;
		System.AssertEquals(updatedLeads[2].TargetX_SRMb__EPS_Code__c, null) ;
		System.AssertEquals(updatedLeads[3].TargetX_SRMb__EPS_Code__c, 'HY02') ;
		System.AssertEquals(updatedLeads[0].State, 'Hyrule') ;
		System.AssertEquals(updatedLeads[1].City, 'Hyrule Field') ;
		System.AssertEquals(updatedLeads[2].City, null) ;
		System.AssertEquals(updatedLeads[2].State, null) ;
		System.AssertEquals(updatedLeads[3].TargetX_SRMb__County__c, 'Kakariko Village') ;
		System.AssertEquals(updatedLeads[3].City, 'Hyrule Field') ;


		Lead lToUpdate = updatedLeads[2] ;
		lToUpdate.PostalCode = '77777' ;

		update lToUpdate ;

		Lead[] updatedL = [SELECT City FROM Lead WHERE LastName='Ganondorf'] ;

		System.AssertEquals(updatedL[0].City, 'Hyrule Castle Town') ;
	}

	private static void makeZips() {
		AddressPlus__c[] zips = new List<AddressPlus__c>() ;

		zips.add(new AddressPlus__c(State__c='Hyrule',City__c='Hyrule Field',County__c='Lon Lon Ranch',EPS_Code__c='HY01',Zip_Code__c='12345')) ;
		zips.add(new AddressPlus__c(State__c='Hyrule',City__c='Hyrule Field',County__c='Kakariko Village',EPS_Code__c='HY02',Zip_Code__c='52224')) ;
		zips.add(new AddressPlus__c(State__c='Hyrule',City__c='Lost Woods',County__c='Kokiri Forest',EPS_Code__c='HY03',Zip_Code__c='00764')) ;
		zips.add(new AddressPlus__c(State__c='Hyrule',City__c='Hyrule Castle Town',County__c='Hyrule Castle',EPS_Code__c='HY04',Zip_Code__c='77777')) ;
		zips.add(new AddressPlus__c(State__c='Hyrule',City__c='Gerudo Valley',County__c='Gerudo Fortress',EPS_Code__c='HY05',Zip_Code__c='99999')) ;

		insert zips ;
	}
}