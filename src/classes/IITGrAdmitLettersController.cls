public with sharing class IITGrAdmitLettersController {
    
    public string reportId;
    public string appId;
    public string appKey;
    
    public IITGrAdmitLettersController() {
        
        reportId = System.currentPageReference().getParameters().get('rid');
        appId = System.currentPageReference().getParameters().get('aid');
        appKey = System.currentPageReference().getParameters().get('k');
        
    }
    
    public List<TargetX_SRMb__Application__c> getApps() {
        
        set<id> appIds = new set<id>();
        if (reportId != null) {
            Reports.ReportResults results = Reports.ReportManager.runReport(reportId,true);        
        	Reports.ReportFactWithDetails factWithDetails = (Reports.ReportFactWithDetails) results.getFactMap().get('T!T');
        	for (Reports.ReportDetailRow row : factWithDetails.getRows()) {
                for (Reports.ReportDataCell cell : row.getDataCells()) {
                    appIds.add(cell.getLabel());
            	}
        	}
        } else if (appId != null) {
            appIds.add(appId);
        }
        
        List<TargetX_SRMb__Application__c> appList = [SELECT Id
                                                      , TargetX_SRMb__Degree__c
                                                      , TargetX_SRMb__Possible_Academic_Major__c
                                                      , TargetX_SRMb__Program__c
                                                      , TargetX_SRMb__College__c
                                                      , TargetX_SRMb__Start_Term_and_Year__c
                                                      , IIT_Clone_Type__c
                                                      , IIT_Contingency_Courses__c
                                                      , TargetX_SRMb__Application_Decision__c
                                                      , IIT_Original_Program__c
                                                      , TargetX_SRMb__Contact__r.FirstName
                                                      , TargetX_SRMb__Contact__r.LastName
                                                      , TargetX_SRMb__Contact__r.mailingstreet
                                                      , TargetX_SRMb__Contact__r.mailingcity
                                                      , TargetX_SRMb__Contact__r.mailingstate
                                                      , TargetX_SRMb__Contact__r.mailingpostalcode
                                                      , TargetX_SRMb__Contact__r.mailingcountry
                                                      , TargetX_SRMb__Contact__r.TargetX_SRMb__Alternate_Address__c
                                                      , TargetX_SRMb__Contact__r.TargetX_SRMb__Alternate_City__c
                                                      , TargetX_SRMb__Contact__r.TargetX_SRMb__Alternate_State__c
                                                      , TargetX_SRMb__Contact__r.TargetX_SRMb__Alternate_Postal_Code__c
                                                      , TargetX_SRMb__Contact__r.TargetX_SRMb__Alternate_Country__c
                                                      , TargetX_SRMb__Contact__r.IIT_Mailing_Address_Active__c
                                                      , TargetX_SRMb__Contact__r.TargetX_SRMb__BannerID__c
                                                      , TargetX_SRMb__Contact__r.IIT_Is_International__c
                                                      , TargetX_SRMb__Contact__r.TargetX_Base__Access_Key__c
                                                      , TargetX_SRMb__Contact__r.IIT_English_Proficiency__c
                                                      , TargetX_SRMb__Contact__r.IIT_I_20_Requested__c
                                                      , TargetX_SRMb__Contact__r.IIT_Tuition_Funding_Exists_Currently__c //consider moving to app
                                                      , TargetX_SRMb__Contact__r.IIT_Stipend_Funding_Exists_Currently__c //consider moving to app
                                                      FROM TargetX_SRMb__Application__c
                                                      WHERE Id IN :appIds
                                                      ORDER BY TargetX_SRMb__Contact__r.LastName,TargetX_SRMb__Contact__r.FirstName
        ];
        return appList;
    }

}