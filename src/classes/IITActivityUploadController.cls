public class IITActivityUploadController {
    
    public Blob csvFileBody{get;set;}
	public string csvAsString{get;set;}
	public String[] csvFileLines{get;set;}
    public string avtySubject{get;set;}
    public string avtyDate{get;set;}
    public string numOfTasks;
    public string successNum;
    public string successMessage;
    
    public IITActivityUploadController(){
        
        csvFileLines = new String[]{};
        successNum = ApexPages.currentPage().getParameters().get('r');
        if(successNum != null) {
            successMessage = successNum + ' Activities Inserted!';
        }
        
    }
    
    public PageReference uploadActivities(){        
        List<Task> avtyList = new List<Task>();        
        try{
            csvAsString = csvFileBody.toString();
			csvFileLines = csvAsString.split('\r\n');            
            for(Integer i=1;i<csvFileLines.size();i++){
				Task avtyObj = new Task() ;
				string[] csvRecordData = csvFileLines[i].split(',');
				avtyObj.WhoId = csvRecordData[0];
				avtyObj.Subject = avtySubject;
				avtyObj.ActivityDate = Date.parse(avtyDate);
				avtyObj.Status = 'Completed';
				avtyObj.Priority = 'Normal';
                avtyObj.OwnerId = '005j0000000hLtiAAE';
				avtyList.add(avtyObj);
			}
			insert avtyList;
            numOfTasks = string.valueOf(avtyList.size());
		}
        catch (Exception e) {
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.Severity.ERROR,'An error has occured while importing data. Please make sure input csv file is correct.');
            ApexPages.addMessage(errorMessage);
        }
        PageReference pageRef = Page.IITActivityUpload;
        pageRef.setRedirect(true);
        pageRef.getParameters().put('r',numOfTasks);
        return pageRef;
    }
    
    public string getNumOfTasks(){
        return numOfTasks;
    }
    
    public string getSuccessMessage(){
        return successMessage;
    }
    
}