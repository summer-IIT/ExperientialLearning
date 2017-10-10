public with sharing class IITAppTrackerController {
    
    Public id Current_Contact_Id;
    Public id Current_Application_Id;
   
    Public IITAppTrackerController(ApexPages.StandardController controller) {
        Current_Application_Id = controller.getRecord().id;
        Current_Contact_Id = ([SELECT TargetX_SRMb__Contact__c
                               FROM TargetX_SRMb__Application__c
                               WHERE id = :Current_Application_Id LIMIT 1]).TargetX_SRMb__Contact__c;
    }
    
    //ID ARCH retrieve all ARID type app reviews for a given application 
	Public List<TargetX_Reader__Application_Review__c> getAppReviews(){
		List<TargetX_Reader__Application_Review__c> appReviewList = [
			SELECT Id
			, Name
			, TargetX_Reader__Application_Review_Type__c
			, IIT_Academic_Strength__c
			, IIT_Additional_Interview__c
			, IIT_Architecture_Ranking__c
			, IIT_Level_of_Preparation_for_Studies__c
			, IIT_Number_of_Studios__c
			, IIT_Quality_of_Letters_of_Recommendation__c
			, IIT_Quality_of_Personal_Statement__c
			, IIT_Quality_of_Portfolio__c
			, IIT_Recommend_English_for_Design_Course__c
			, IIT_Recommend_Fellowship_Consideration__c
			, IIT_Recommend_Foundation_Course__c
			, IIT_Relevant_Work_or_Life_Experience__c
			, IIT_Average_Score__c
			, IIT_Decision_Maker__c
			, IIT_Experience_in_Arch_Art_Design__c
			, TargetX_Reader__Date_Completed__c
			, IIT_Summary_Notes__c
			, IIT_Decision_Maker_Name__c
			, IIT_Faculty_Assessor_1__c
			, IIT_Faculty_Assessor_2__c	
			FROM TargetX_Reader__Application_Review__c
			WHERE TargetX_Reader__Application_Review_Type__c = 'a1Pj0000001HkQz'
			AND TargetX_Reader__Application__c = :Current_Application_Id
		];
		return appReviewList;
	}
    
    //Get list of applications for contact
	Public List<TargetX_SRMb__Application__c> getAppList(){
		List<TargetX_SRMb__Application__c> appList = [
			SELECT Id
			, Name
            , TargetX_SRMb__Application_Decision__c
            , TargetX_SRMb__Application_Type__c
            , TargetX_SRMb__College__c
            , TargetX_SRMb__Decision__c
            , TargetX_SRMb__Degree__c
            , TargetX_SRMb__Program__c
            , TargetX_SRMb__Level__c
            , TargetX_SRMb__Stage__c
            , TargetX_SRMb__Status__c
            , TargetX_SRMb__Student_Type__c
            , Department__c
            , IIT_Application_Processing_Status__c
            , IIT_Program__c
            , TargetX_SRMb__Start_Term_and_Year__c
            , RecordTypeId
			FROM TargetX_SRMb__Application__c
			WHERE TargetX_SRMb__Contact__c = :Current_Contact_Id
        ];
		return appList;
    }

}