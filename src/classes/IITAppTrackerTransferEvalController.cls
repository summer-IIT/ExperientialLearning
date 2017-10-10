public with sharing class IITAppTrackerTransferEvalController {
	
    Public id Current_Contact_Id;
    Public boolean accessError;
    Public string accessKey;
    Public string Current_Contact_Key;
    
    public IITAppTrackerTransferEvalController(ApexPages.StandardController controller) {
        
        Current_Contact_Id = controller.getRecord().id;
        
        String query = 'Select TargetX_Base__Access_Key__c from Contact Where Id = :Current_Contact_Id';
        
        Contact obj = database.query(query);
        Current_Contact_Key = obj.TargetX_Base__Access_Key__c;
        
        accessKey = System.currentPageReference().getParameters().get('k');
        
        if (Current_Contact_Key == accessKey) {
            accessError = false;
        } else {
            accessError = true;
        }
        
    }
    
    public List<IIT_Course_Evaluation__c> getcourseEvaluations(){
       List<IIT_Course_Evaluation__c> evaluationList = New List<IIT_Course_Evaluation__c>();
       for(Contact currentContact:[select id,(select id,IIT_Course_Name__c,IIT_Course_Title__c,IIT_IIT_Course_Equivalent__c,IIT_IIT_Course_Equivalent_Title__c,IIT_Semester_Hours__c,IIT_School__r.name from IIT_Course_Evaluations__r ORDER BY IIT_School__r.name,IIT_Course_Name__c) from contact where Id = :Current_Contact_Id]){
           for(IIT_Course_Evaluation__c courseEvaluation:currentContact.IIT_Course_Evaluations__r)
               evaluationList.add(courseEvaluation);
       }
       return evaluationList;
    }
    
    public boolean getaccessError() {
        return accessError;
    }
    
}