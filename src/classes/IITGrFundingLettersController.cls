public with sharing class IITGrFundingLettersController {
	
    public string reportId;
    public string appId;
    public string appKey;
    
    public IITGrFundingLettersController() {
        
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
                                                      , TargetX_SRMb__Program__c
                                                      , IIT_Admit_Date__c
                                                      , TargetX_SRMb__College__c
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
                                                      , TargetX_SRMb__Contact__r.IIT_PhD_Continuation_Indicator_Exists__c //consider moving to app
                                                      , TargetX_SRMb__Contact__r.IIT_Tuition_Funding_Exists_Currently__c //consider moving to app
                                                      , TargetX_SRMb__Contact__r.IIT_Stipend_Funding_Exists_Currently__c //consider moving to app
                                                      , TargetX_SRMb__Contact__r.IIT_TA_Funding_Exists_Currently__c //consider moving to app
                                                      , TargetX_SRMb__Contact__r.IIT_Is_International__c
                                                      , TargetX_SRMb__Contact__r.TargetX_Base__Access_Key__c
                                                      FROM TargetX_SRMb__Application__c
                                                      WHERE Id IN :appIds
                                                      ORDER BY TargetX_SRMb__Contact__r.LastName,TargetX_SRMb__Contact__r.FirstName
        ];
        return appList;
    }
    
    public List<TargetX_SRMb__Financial_Aid__c> getFinancialAid() {
        
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
        
        List<TargetX_SRMb__Financial_Aid__c> finAidList = [SELECT Id
                                                           , IIT_Application__c
                                                           , TargetX_SRMb__Type__c
                                                           , IIT_Description__c
                                                           , IIT_Term_Description__c
                                                           , IIT_Aid_Year_Description__c
                                                           , TargetX_SRMb__Amount__c
                                                           , IIT_Credit_Hours__c
                                                           , IIT_Percentage__c
                                                           , IIT_Stipend_Amount__c
                                                           FROM TargetX_SRMb__Financial_Aid__c
                                                           WHERE IIT_Application__c IN :appIds
                                                           AND (TargetX_SRMb__Amount__c != 0 OR IIT_Credit_Hours__c != 0 OR IIT_Percentage__c != 0 OR IIT_Stipend_Amount__c != 0)
                                                           AND (TargetX_SRMb__Type__c = 'Stipend' OR TargetX_SRMb__Type__c = 'Tuition')
                                                           AND IIT_Award_Status__c != 'Canceled'
                                                           ORDER BY IIT_Application__c ASC, IIT_Aid_Year_Description__c ASC, IIT_Term_Description__c ASC
		];
        return finAidList;
    }

}