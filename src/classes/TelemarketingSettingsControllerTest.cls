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
private class TelemarketingSettingsControllerTest {

    static testMethod void testNormalFlow() {

            CampaignColumns__c campaignColumns = CampaignColumns__c.getInstance();
            
            if(campaignColumns == null){
                campaignColumns = new CampaignColumns__c();
                campaignColumns.ADDRESS__c          = true;
                campaignColumns.COMPANY__c          = true;
                campaignColumns.EMAIL__c            = true;
                campaignColumns.PHONE__c            = true;
                campaignColumns.SALUTATION__c       = true;
                campaignColumns.OWNER__c            = true;
                campaignColumns.GENDER__c       = true;
                campaignColumns.HOMEPHONE__c       = true;
                campaignColumns.MOBILEPHONE__c       = true;

                upsert campaignColumns;
            }
            
           Boolean showAddress = !campaignColumns.ADDRESS__c;

            TelemarketingSettingsController tsc = new TelemarketingSettingsController();         
            
            //System.assert(tsc.getColumnSettingsList()[0].cValue == !showAddress);
            
            PageReference p = tsc.saveSettings();

           
            
            

    }
    
    static testMethod void testLackingOnesFlow() {
            
            CampaignColumns__c campaignColumns = CampaignColumns__c.getInstance();
            
            if(campaignColumns == null){
                campaignColumns = new CampaignColumns__c();
                campaignColumns.ADDRESS__c          = true;
                campaignColumns.COMPANY__c          = true;
                campaignColumns.EMAIL__c            = true;
                campaignColumns.PHONE__c            = true;
                campaignColumns.SALUTATION__c       = true;
                campaignColumns.OWNER__c            = true;
                campaignColumns.GENDER__c       = true;
                campaignColumns.HOMEPHONE__c       = true;
                campaignColumns.MOBILEPHONE__c       = true;
                upsert campaignColumns;
            }
            
            String backPage = '/ouch';
            Apexpages.currentPage().getParameters().put('var', backPage);
            
            TelemarketingSettingsController tsc = new TelemarketingSettingsController(); 
            
            System.assertEquals(tsc.backPage,backPage);
            PageReference p = tsc.saveSettings();
            
    }
}