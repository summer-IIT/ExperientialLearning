public with sharing class IITLetterGeneratorController {
	
    public string url;
    public string currentReport {get;set;}
    public string currentLetter {get;set;}
    public string currentActivity {get;set;}
    public string numOfTasks;
    
    public IITLetterGeneratorController() {
        
    }
    
    public List<SelectOption> getReports() {
        List<Report> reportList = [SELECT Id, Name FROM Report WHERE FolderName = 'IIT Letter Reports' ORDER BY Name];
        
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','--Select a Report--'));
        for(Report r : reportList){
            options.add(new SelectOption(r.Id,r.Name));
        }
        return options;
    }
    
    public List<SelectOption> getLetters() {
        List<ApexPage> pageList = [SELECT Id, Name, MasterLabel FROM ApexPage Where Name like 'IIT%Letters' ORDER BY Name];
        
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','--Select a Letter--'));
        for(ApexPage p : pageList){
            options.add(new SelectOption(p.Name,p.MasterLabel));
        }
        return options;
    }
    
    public List<SelectOption> getActivities() {
        set<string> activities = IITLetterGeneratorActivities__c.getAll().keyset();
        
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','--Select an Activity to Post--'));
        for(string a : activities){
            options.add(new SelectOption(a,a));
        }
        options.sort();
        return options;
    }
    
    public PageReference runLetters() {
        url = currentLetter + '?rid=' + currentReport;
        return null;
    }
    
    public PageReference postActivities() {
        List<Task> tasks = new List<Task>();
        Reports.ReportResults results = Reports.ReportManager.runReport(currentReport,true);        
		Reports.ReportFactWithDetails factWithDetails = (Reports.ReportFactWithDetails) results.getFactMap().get('T!T');     
        	for (Reports.ReportDetailRow row : factWithDetails.getRows()) {
            	for (Reports.ReportDataCell cell : row.getDataCells()) {
                	Task t = new Task(Subject = currentActivity, ActivityDate = date.today(), Status = 'Completed', Priority = 'Normal'
                                     , OwnerId = UserInfo.getUserId(), WhatId = cell.getLabel());
                    tasks.add(t);
            	}
        	}
        insert tasks;
        numOfTasks = string.valueOf(tasks.size());
        return null;
    }
    
    public string getURL() {
        return url;
    }
    
    public string getNumOfTasks() {
        return numOfTasks;
    }
    
}