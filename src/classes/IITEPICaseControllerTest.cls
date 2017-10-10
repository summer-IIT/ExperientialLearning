@isTest
public class IITEPICaseControllerTest {
    
    public static testMethod void IITEPICaseControllerTest() {
        
        PageReference pageRef = Page.IIT_EPI_Support;
		Test.setCurrentPage(pageRef);
        
        Account objAcc = new Account();
        objAcc.Name = 'IIT';
        objAcc.TargetX_SRMb__ceeb_code__c = '111111';
        insert objAcc;
        
        Contact objCon = new Contact();
        objCon.FirstName = 'Fname';
        objCon.LastName = 'Lname';
        objCon.AccountId = objAcc.Id;
        objCon.Email = 'bwoods5+test1@iit.edu';
        objCon.RecordTypeId = '012j00000010JL7AAM';
        insert objCon;
        
        IITEPICaseController controller = new IITEPICaseController();
        controller.ctEmail = 'bwoods5+test1@iit.edu';
        controller.c.Subject = 'Case Subject';
        controller.c.Description = 'Case Description';
        controller.c.Priority = 'High';
        controller.submitCase();
        
        controller.ctEmail = 'bwoods5+test2@iit.edu';
        controller.c.Subject = 'Case Subject';
        controller.c.Description = 'Case Description';
        controller.c.Priority = 'High';
        controller.submitCase();
        
    }

}