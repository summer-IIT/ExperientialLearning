/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TelemarketingControllerTest {

     static testMethod void testNormalFlow(){
        //campaign
        Campaign testCampaign       = new Campaign();
        testCampaign.name           = 'TestCampaign';
        testCampaign.CallerTimeout__c = 'Null';
        testCampaign.Callbacks__c = '2 Callbacks';
        insert testCampaign;
        
        //Lead
        Lead testLead1          = new Lead();
        testLead1.FirstName     = 'LeadFirstName1';
        testLead1.LastName      = 'LeadLastName1';
        testLead1.Company       = 'Test1';
        testLead1.Street        = '123 abc st';
        insert testLead1;
        
        //Lead
        Lead testLead2          = new Lead();
        testLead2.FirstName     = 'LeadFirstName2';
        testLead2.LastName      = 'LeadLastName2';
        testLead2.Company       = 'Test2';
        insert testLead2;
        
        //Contact
        Contact testContact         = new Contact();
        testContact.FirstName       = 'ContactFirstName';
        testContact.LastName        ='ContactLastName';
        testContact.Email           = 'Adress2@Adress.com';
        testContact.Title           = 'ContactTitile';
        testContact.MailingStreet   ='456 garrik st';
        insert testContact;
        
        //Contact2
        Contact testContact2        = new Contact();
        testContact2.FirstName      = 'ContactFirstName2';
        testContact2.Email          = 'Adress@Adress.com';
        testContact2.LastName       ='ContactLastName2';
        testContact2.Title          = 'ContactTitile2';
        insert testContact2;
        
        //make campaign members
        CampaignMember testCM       = new CampaignMember();
        testCM.leadID               = testLead1.Id;
        testCM.campaignID           = testCampaign.Id;
        testCM.Status               ='None';
        insert testCM;
        
        //make campaign members
        CampaignMember testCM1      = new CampaignMember();
        testCM1.leadID              = testLead2.Id;
        testCM1.campaignID          = testCampaign.Id;
        testCM1.Status              = 'None';
        testCM1.Failed_Calls__c     = 0;
        insert testCM1;
        
        CampaignMember testCM2      = new CampaignMember();
        testCM2.ContactId           = testContact.Id;
        testCM2.CampaignId          = testCampaign.Id;
        testCM2.Status              = 'None';
        testCM2.Failed_Calls__c     = 0;
        insert testCM2;
        
        CampaignMember testCM3      = new CampaignMember();
        testCM3.ContactId           = testContact2.Id;
        testCM3.CampaignId          = testCampaign.Id;
        testCM3.Status              = 'None';
        testCM3.Failed_Calls__c     = 0;
        insert testCM3;
        
        //begin tests
        TelemarketingController tc1 = new TelemarketingController();
        tc1.ownerId = UserInfo.getUserId();
        List<CampaignMember> testCMList = [ SELECT id, ContactId, CampaignId, Status, Failed_Calls__c FROM CampaignMember WHERE id =: testCM.id OR id =: testCM1.id OR id =: testCM2.id OR id =: testCM3.id ];
        tc1.updateAll();
        List<CampaignMember> testCMList2 = [ SELECT id, ContactId, CampaignId, Status, Failed_Calls__c FROM CampaignMember WHERE id =: testCM.id OR id =: testCM1.id OR id =: testCM2.id OR id =: testCM3.id ];
        
        // No changes
        System.assertEquals( testCMList, testCMList2 );
        
        List<Selectoption>sO=tc1.getstatusItems();
        
        tc1.camp = testCampaign.Id;
        String s = tc1.getCampaignName();
        
        //Campaign name
        System.assertEquals( s, 'All Leads' );
        
        tc1.campaignRefresh();
        s = tc1.getCampaignName();
        sO=tc1.getstatusItems();
        
        List<Selectoption> options= new List<Selectoption>{ new Selectoption( 'None', 'None'), new Selectoption( 'No Answer', 'No Answer' ), new Selectoption( 'Left Message', 'Left Message'), new Selectoption('Had Conversation', 'Had Conversation')};
       
        // Options
        System.assertEquals( sO[ 0 ].getLabel(), options[ 0 ].getLabel());
        System.assertEquals( sO[ 1 ].getLabel(), options[ 1 ].getLabel());
        System.assertEquals( sO[ 2 ].getLabel(), options[ 2 ].getLabel());
        System.assertEquals( sO[ 3 ].getLabel(), options[ 3 ].getLabel());
        System.assertEquals( sO[ 0 ].getValue(), options[ 0 ].getValue());
        System.assertEquals( sO[ 1 ].getValue(), options[ 1 ].getValue());
        System.assertEquals( sO[ 2 ].getValue(), options[ 2 ].getValue());
        System.assertEquals( sO[ 3 ].getValue(), options[ 3 ].getValue());
        //Campaign name
        System.assertEquals( s, 'TestCampaign' );
        
        tc1.getLeadPlusTasks()[0].statusUpdate = 'No Answer';
        System.debug('******' + tc1.getLeadPlusTasks().size());
        tc1.updateAll();
        System.debug('******' + tc1.getLeadPlusTasks().size());
        List<CampaignMember> testCMList3 = [ SELECT id, ContactId, CampaignId, Status, Failed_Calls__c FROM CampaignMember WHERE id =: testCM.id OR id =: testCM2.id OR id =: testCM3.id ];
        tc1.getLeadPlusTasks()[0].statusUpdate = 'Never Answered';
        System.debug('******' + tc1.getLeadPlusTasks().size());
        tc1.updateAll();
        System.debug('******' + tc1.getLeadPlusTasks().size());
       
        
       
        
        
        // Changes
        System.assert( testCMList != testCMList3, 'The collections not be equals.' );
        
        sO=tc1.getcampaignItems();
        
        List<Selectoption> auxCampList = new List<Selectoption>(); 
        auxCampList.add(new SelectOption( '1','SELECT' ));
        
        for(Campaign c : [Select Name, Id From Campaign Where Type = 'Telemarketing' AND isactive = true order by Name limit 1])
            auxCampList.add( new SelectOption( c.ID, c.Name ));
            
        Integer k = 0;
        for( SelectOption op: auxCampList )
            System.assertEquals( sO[ k++ ].getValue(), op.getValue(), 'Error list of campaigns must be equals');
    
        tc1.getLeadPlusTasks()[ 0 ].getmemStatusValue();
        tc1.getLeadPlusTasks()[ 0 ].sett( tc1.getLeadPlusTasks()[ 0 ].gett());
        tc1.getLeadPlusTasks()[ 0 ].getmemStatus();
    
    
    
        System.assert( tc1.gethasCampaignID());
        
        tc1.status='None';
        tc1.campaignRefresh();
        System.assert( tc1.status == 'None');
        
        tc1.status='None';
        tc1.campaignRefresh();
        System.assert( tc1.status == 'None');
        
        sO=tc1.getcampaignItems();
        sO=tc1.getstatusItems();
        
        s = tc1.getCampaignName();
        boolean b = tc1.getName();
        
        tc1.setowners(new List<SelectOption>());
        System.assert( tc1.getowners().size() == 0);
        
      }
  
}