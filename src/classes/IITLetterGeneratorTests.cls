@isTest
public class IITLetterGeneratorTests {
	
    @isTest(SeeAllData = 'true')
    public static void conductIITLetterGeneratorControllerTesting() {
                
        PageReference pageRef = Page.IITLetterGenerator;
		Test.setCurrentPage(pageRef);
        
        IITLetterGeneratorController controller1 = new IITLetterGeneratorController();
        controller1.getReports();
        controller1.getLetters();
        controller1.getActivities();
        controller1.currentReport = controller1.getReports()[1].getValue();
        controller1.currentLetter = controller1.getLetters()[1].getValue();
        controller1.currentActivity = controller1.getActivities()[1].getValue();
        controller1.getURL();
        controller1.getNumOfTasks();
        controller1.runLetters();
        controller1.postActivities();
        
    }
    
    @isTest(SeeAllData = 'true')
    public static void conductIITGrAdmitLetterTesting() {
        
        List<Report> reportList = [SELECT Id, Name FROM Report WHERE FolderName = 'IIT Letter Reports' ORDER BY Name];
        
        PageReference pageRef = Page.IITGrAdmitLetters;
		Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('rid',reportList[0].id);
        
        IITGrAdmitLettersController controller2 = new IITGrAdmitLettersController();
        controller2.getApps();
        
    }
    
    @isTest(SeeAllData = 'true')
    public static void conductIITGrFundingLetterTesting() {
        
        List<Report> reportList = [SELECT Id, Name FROM Report WHERE FolderName = 'IIT Letter Reports' ORDER BY Name];
        
        PageReference pageRef = Page.IITGrFundingLetters;
		Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('rid',reportList[0].id);
        
        IITGrFundingLettersController controller3 = new IITGrFundingLettersController();
        controller3.getApps();
        controller3.getFinancialAid();
        
    }
    
    @isTest(SeeAllData = 'true')
    public static void conductIITActivityUploadControllerTesting() {
        
        //Get one contact for testing
        string cid = [Select Id From Contact Limit 1].id;
        
        //Create CSVs
        string contactIdCSV1 = 'ContactID\r\n';
        contactIdCSV1 = contactIdCSV1 + cid;
        
        string contactIdCSV2 = 'ContactID\r\n';
        contactIdCSV2 = contactIdCSV2 + '1';
        
        //Test Page
        PageReference pageRef = Page.IITActivityUpload;
        pageRef.getParameters().put('r','1');
		Test.setCurrentPage(pageRef);
        
        //Test Insert and Success
        IITActivityUploadController controller4 = new IITActivityUploadController();
        controller4.avtySubject = 'Test Subject';
        controller4.avtyDate = '01/01/2017';
        controller4.csvFileBody = Blob.valueOf(contactIdCSV1);
        controller4.uploadActivities();
        controller4.getNumOfTasks();
        controller4.getSuccessMessage();
        
        //Test Exception
        controller4.avtySubject = 'Test Subject';
        controller4.avtyDate = '01/01/2017';
        controller4.csvFileBody = Blob.valueOf(contactIdCSV2);
        controller4.uploadActivities();
        
    }
    
}