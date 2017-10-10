public with sharing class IITACRKController {
    
    Public id Current_Application_Id;
    Public id Current_AppReview_Id;
    Public id Current_Contact_Id;
    Public boolean appReviewCompleted;
    Public decimal highestMath;
    Public decimal rigorRating;
    Public decimal acrkFinal;
    Public string altCollege;
    Public string altMajor;
    Public decimal actSuper;
    Public decimal actComp;
    Public decimal actEnglish;
    Public decimal actMath;
    Public decimal actReading;
    Public decimal actScience;
    Public decimal satSuper;
    Public decimal satComp;
    Public decimal satMath;
    Public decimal satVerbal;
    Public decimal rsatComp;
    Public decimal rsatMath;
    Public decimal rsatReading;
    Public map<string, IITRSATTotalToSATComposite__c> rsatTotalToSatCompositeMap;
    Public map<string, IITRSATMathToSATMath__c> rsatMathToSatMathMap;
    Public map<string, IITRSATReadingToSATVerbal__c> rsatReadingToSatVerbalMap;
    Public map<string, IITSATCompositeToACTComposite__c> satCompositeToActCompositeMap;
    Public map<string, IITSATMathToACTMath__c> satMathToActMathMap;
    Public decimal rsatCompToSatComp;
    Public decimal rsatMathToSatMath;
    Public decimal satSuperConv;
    Public decimal satCompConv;
    Public decimal satMathConv;
    Public decimal bestSuper;
    Public decimal bestComp;
    Public decimal bestMath;
    Public string appStudentType;
    Public integer appIntl;
    Public string appMajor;
    Public string appCollege;
    Public string appGender;
    Public integer appInState;
    Public integer appCommuter;
    Public integer appURM;
    Public integer appBuildState;
    Public decimal hsQuality;
    Public decimal hsBuildFlag;
    Public string hsGPAScaleFlag;
    Public string hsGPAScaleWeightFlag;
    Public integer hsUS;
    Public decimal hsGPA;
    Public decimal hsRank;
    Public decimal hsSize;
    Public decimal hsPctRank;
    Public decimal highMathInd;
    Public decimal majorType;
    Public decimal usePoint;
    Public decimal zBestComp;
    Public decimal zBestMath;
    Public decimal zHSGPA;
	Public decimal zHSRank;
	Public decimal zHSQuality;
	Public decimal zRigor;
    Public decimal model1CompWeight;
    Public decimal model1MathWeight;
    Public decimal model1HSGPAWeight;
    Public decimal model1HSRankWeight;
    Public decimal model1HSQualityWeight;
    Public decimal model1TotalWeight;
    Public decimal model2CompWeight;
    Public decimal model2MathWeight;
    Public decimal model2HSGPAWeight;
    Public decimal model2HSQualityWeight;
    Public decimal model2HighestMathWeight;
    Public decimal model2TotalWeight;
    Public decimal aIndex1;
    Public decimal aIndex2;
    Public decimal rawScore;
    Public integer cutPoint;
    Public integer ACRK;
    Public integer meritACRK;
    Public string meritMajor;
    Public string meritCollege;
    Public integer meritLewis;
    Public integer meritStuart;
    Public integer meritArchitecture;
    Public integer meritScience;
    Public integer meritArmourSatFemale;
    Public integer meritArmourSatMale;
    Public integer meritFinal;
    Public integer meritHousing;
    Public string swScholarRule1;
    Public string swScholarRule2;
    Public string swScholarRule3;
    Public integer swACRK;
    Public integer swGrowthPrograms;
    Public integer swOverPopulatedPrograms;
    Public string swExclusions;
    Public string swInviteFlag;
    Public string decisionGuide;
    Public boolean acrkDisplay;
    
    public IITACRKController(ApexPages.StandardController controller) {
        
        //START ACRK CALCULATION
        
        //Get Application ID
        Current_Application_Id = controller.getRecord().id;
        
        //Query Application Review
        String queryAppRev = 'Select Id, TargetX_Reader__Completed__c, IIT_Highest_Math_Converted__c, IIT_Rigor_Rating_Converted__c, IIT_ACRK__c, IIT_New_Program__r.IIT_College__c, IIT_New_Program__r.IIT_Major__c from TargetX_Reader__Application_Review__c Where TargetX_Reader__Application__c = :Current_Application_Id AND (TargetX_Reader__Application_Review_Type__r.Name LIKE \'UG Initial Review%\' OR TargetX_Reader__Application_Review_Type__r.Name LIKE \'UG Final Review%\') Order By LastModifiedDate DESC LIMIT 1';

        TargetX_Reader__Application_Review__c objAppRev = database.query(queryAppRev);
        
        Current_AppReview_Id = objAppRev.Id;        
        appReviewCompleted = objAppRev.TargetX_Reader__Completed__c;
        highestMath = objAppRev.IIT_Highest_Math_Converted__c;        
        rigorRating = objAppRev.IIT_Rigor_Rating_Converted__c;
        acrkFinal = objAppRev.IIT_ACRK__c;
        altCollege = objAppRev.IIT_New_Program__r.IIT_College__c;
        altMajor = objAppRev.IIT_New_Program__r.IIT_Major__c;
    
        //Query Application and Contact
        String queryApp = 'Select TargetX_SRMb__Contact__c, TargetX_SRMb__Possible_Academic_Major__c, TargetX_SRMb__College__c, TargetX_SRMb__Contact__r.TargetX_SRMb__Gender__c, TargetX_SRMb__Contact__r.MailingState, TargetX_SRMb__Housing__c, TargetX_SRMb__Contact__r.TargetX_SRMb__IPEDS_Hispanic__c, TargetX_SRMb__Contact__r.TargetX_SRMb__IPEDS_Ethnicities__c, TargetX_SRMb__Student_Type__c, IIT_Is_International__c From TargetX_SRMb__Application__c Where Id = :Current_Application_Id';
        
        TargetX_SRMb__Application__c objApp = database.query(queryApp);
        
        Current_Contact_Id = objApp.TargetX_SRMb__Contact__c;
        appStudentType = objApp.TargetX_SRMb__Student_Type__c;
        appIntl = (objApp.IIT_Is_International__c == true ? 1 : 0);
        appMajor = objApp.TargetX_SRMb__Possible_Academic_Major__c;
        appCollege = objApp.TargetX_SRMb__College__c;
        appGender = objApp.TargetX_SRMb__Contact__r.TargetX_SRMb__Gender__c;
        appInState = (objApp.TargetX_SRMb__Contact__r.MailingState == 'IL' ? 1 : 0);
        appCommuter = (objApp.TargetX_SRMb__Housing__c == 'Commuter' ? 1 : 0);
        appURM = ((String.isNotBlank(objApp.TargetX_SRMb__Contact__r.TargetX_SRMb__IPEDS_Ethnicities__c)
          && (objApp.TargetX_SRMb__Contact__r.TargetX_SRMb__IPEDS_Ethnicities__c.contains('Black or African American')
            || objApp.TargetX_SRMb__Contact__r.TargetX_SRMb__IPEDS_Ethnicities__c.contains('American Indian or Alaska Native')))
        || objApp.TargetX_SRMb__Contact__r.TargetX_SRMb__IPEDS_Hispanic__c == true
                ? 1 : 0);
        appBuildState = (objApp.TargetX_SRMb__Contact__r.MailingState == 'IL' ||
                         objApp.TargetX_SRMb__Contact__r.MailingState == 'CA' ||
                         objApp.TargetX_SRMb__Contact__r.MailingState == 'MI' ||
                         objApp.TargetX_SRMb__Contact__r.MailingState == 'OH' ||
                         objApp.TargetX_SRMb__Contact__r.MailingState == 'TX' ||
                         objApp.TargetX_SRMb__Contact__r.MailingState == 'IN' ||
                         objApp.TargetX_SRMb__Contact__r.MailingState == 'MN' ||
                         objApp.TargetX_SRMb__Contact__r.MailingState == 'WI'
                        ? 0 : 1);
        
        //Query Enrollment History and Account
        List<TargetX_SRMb__Enrollment_History__c> objEH = [Select id, TargetX_SRMb__Account__r.IIT_Highschool_Quality__c, TargetX_SRMb__Account__r.IIT_HS_Build_Flag__c, TargetX_SRMb__Account__r.IIT_HS_GPA_Scale_Flag__c, TargetX_SRMb__Account__r.BillingCountry, TargetX_SRMb__Official_Recalculated_GPA__c, TargetX_SRMb__Official_Class_Rank__c, TargetX_SRMb__Official_Class_Size__c From TargetX_SRMb__Enrollment_History__c Where TargetX_SRMb__Application__c = :Current_Application_Id AND RecordTypeId = '012j0000000xaql' ORDER BY TargetX_SRMb__End_Date__c DESC LIMIT 1];
        if (objEH.size() > 0) {            
			hsGPAScaleFlag = objEH[0].TargetX_SRMb__Account__r.IIT_HS_GPA_Scale_Flag__c;
			hsQuality = (objEH[0].TargetX_SRMb__Account__r.IIT_Highschool_Quality__c == null ? 0 : objEH[0].TargetX_SRMb__Account__r.IIT_Highschool_Quality__c);
            hsBuildFlag = (objEH[0].TargetX_SRMb__Account__r.IIT_HS_Build_Flag__c == true ? 1 : 0);
            hsGPA = (objEH[0].TargetX_SRMb__Official_Recalculated_GPA__c > 4.5 ? 4.5 : objEH[0].TargetX_SRMb__Official_Recalculated_GPA__c);
            hsRank = (String.isBlank(objEH[0].TargetX_SRMb__Official_Class_Rank__c) ? 0 : Decimal.ValueOf(objEH[0].TargetX_SRMb__Official_Class_Rank__c));
        	hsSize = (objEH[0].TargetX_SRMb__Official_Class_Size__c == null ? 0 : objEH[0].TargetX_SRMb__Official_Class_Size__c);
        	hsPctRank = (hsSize > 49 && hsRank > 0 ? (1 - (hsRank / hsSize)) : 0);
            hsUS = (objEH[0].TargetX_SRMb__Account__r.BillingCountry == 'US' || objEH[0].TargetX_SRMb__Account__r.BillingCountry == 'United States' ? 1 : 0);
        } else {            
            hsQuality = 0;
          	hsGPAScaleFlag = null;        
          	hsBuildFlag = 0;
        	hsGPA = 0;
          	hsRank = 0;
          	hsSize = 0;
          	hsPctRank = 0;
        }
        
        //Query and Calculate Test Scores
        List<TargetX_SRMb__Test__c> objACTC = [Select Id, TargetX_SRMb__ACT_Composite_Score__c From TargetX_SRMb__Test__c Where TargetX_SRMb__Contact__c = :Current_Contact_Id and TargetX_SRMb__Test__c = 'ACT' and TargetX_SRMb__Score_Validated__c = true Order By TargetX_SRMb__ACT_Composite_Score__c Desc Limit 1];
        actComp = (objACTC.size() > 0 ? objACTC[0].TargetX_SRMb__ACT_Composite_Score__c : 0);
        
		List<TargetX_SRMb__Test__c> objACTE = [Select Id, TargetX_SRMb__ACT_English_Score__c From TargetX_SRMb__Test__c Where TargetX_SRMb__Contact__c = :Current_Contact_Id and TargetX_SRMb__Test__c = 'ACT' and TargetX_SRMb__Score_Validated__c = true Order By TargetX_SRMb__ACT_English_Score__c Desc Limit 1];
        actEnglish = (objACTE.size() > 0 ? objACTE[0].TargetX_SRMb__ACT_English_Score__c : 0);
        
		List<TargetX_SRMb__Test__c> objACTM = [Select Id, TargetX_SRMb__ACT_Math_Score__c From TargetX_SRMb__Test__c Where TargetX_SRMb__Contact__c = :Current_Contact_Id and TargetX_SRMb__Test__c = 'ACT' and TargetX_SRMb__Score_Validated__c = true Order By TargetX_SRMb__ACT_Math_Score__c Desc Limit 1];
        actMath = (objACTM.size() > 0 ? objACTM[0].TargetX_SRMb__ACT_Math_Score__c : 0);
        
		List<TargetX_SRMb__Test__c> objACTR = [Select Id, TargetX_SRMb__ACT_Reading_Score__c From TargetX_SRMb__Test__c Where TargetX_SRMb__Contact__c = :Current_Contact_Id and TargetX_SRMb__Test__c = 'ACT' and TargetX_SRMb__Score_Validated__c = true Order By TargetX_SRMb__ACT_Reading_Score__c Desc Limit 1];
        actReading = (objACTR.size() > 0 ? objACTR[0].TargetX_SRMb__ACT_Reading_Score__c : 0);
        
		List<TargetX_SRMb__Test__c> objACTS = [Select Id, TargetX_SRMb__ACT_Science_Score__c From TargetX_SRMb__Test__c Where TargetX_SRMb__Contact__c = :Current_Contact_Id and TargetX_SRMb__Test__c = 'ACT' and TargetX_SRMb__Score_Validated__c = true Order By TargetX_SRMb__ACT_Science_Score__c Desc Limit 1];
        actScience = (objACTS.size() > 0 ? objACTS[0].TargetX_SRMb__ACT_Science_Score__c : 0);
        
		List<TargetX_SRMb__Test__c> objSATC = [Select Id, IIT_SAT_I_Composite_V_M__c From TargetX_SRMb__Test__c Where TargetX_SRMb__Contact__c = :Current_Contact_Id and TargetX_SRMb__Test__c = 'SAT I' and TargetX_SRMb__Score_Validated__c = true and IIT_SAT_I_Composite_V_M__c != null Order By IIT_SAT_I_Composite_V_M__c Desc Limit 1];
        satComp = (objSATC.size() > 0 ? objSATC[0].IIT_SAT_I_Composite_V_M__c : 0);
        
        List<TargetX_SRMb__Test__c> objSATM = [Select Id, TargetX_SRMb__SAT_I_Math_Score__c From TargetX_SRMb__Test__c Where TargetX_SRMb__Contact__c = :Current_Contact_Id and TargetX_SRMb__Test__c = 'SAT I' and TargetX_SRMb__Score_Validated__c = true and TargetX_SRMb__SAT_I_Math_Score__c != null Order By TargetX_SRMb__SAT_I_Math_Score__c Desc Limit 1];
        satMath = (objSATM.size() > 0 ? objSATM[0].TargetX_SRMb__SAT_I_Math_Score__c : 0);
        
        List<TargetX_SRMb__Test__c> objSATV = [Select Id, TargetX_SRMb__SAT_I_Verbal_Score__c From TargetX_SRMb__Test__c Where TargetX_SRMb__Contact__c = :Current_Contact_Id and TargetX_SRMb__Test__c = 'SAT I' and TargetX_SRMb__Score_Validated__c = true and TargetX_SRMb__SAT_I_Verbal_Score__c != null Order By TargetX_SRMb__SAT_I_Verbal_Score__c Desc Limit 1];
        satVerbal = (objSATV.size() > 0 ? objSATV[0].TargetX_SRMb__SAT_I_Verbal_Score__c : 0);
        
        List<TargetX_SRMb__Test__c> objRSATC = [Select Id, TargetX_SRMb__RSAT_I_Total__c From TargetX_SRMb__Test__c Where TargetX_SRMb__Contact__c = :Current_Contact_Id and TargetX_SRMb__Test__c = 'SAT I' and TargetX_SRMb__Score_Validated__c = true and TargetX_SRMb__RSAT_I_Total__c != null Order By TargetX_SRMb__RSAT_I_Total__c Desc Limit 1];
        rsatComp = (objRSATC.size() > 0 ? objRSATC[0].TargetX_SRMb__RSAT_I_Total__c : 0);
        
        List<TargetX_SRMb__Test__c> objRSATM = [Select Id, TargetX_SRMb__RSAT_I_Math_Section__c From TargetX_SRMb__Test__c Where TargetX_SRMb__Contact__c = :Current_Contact_Id and TargetX_SRMb__Test__c = 'SAT I' and TargetX_SRMb__Score_Validated__c = true and TargetX_SRMb__RSAT_I_Math_Section__c != null Order By TargetX_SRMb__RSAT_I_Math_Section__c Desc Limit 1];
        rsatMath = (objRSATM.size() > 0 ? objRSATM[0].TargetX_SRMb__RSAT_I_Math_Section__c : 0);
        
        List<TargetX_SRMb__Test__c> objRSATR = [Select Id, TargetX_SRMb__RSAT_I_Reading__c From TargetX_SRMb__Test__c Where TargetX_SRMb__Contact__c = :Current_Contact_Id and TargetX_SRMb__Test__c = 'SAT I' and TargetX_SRMb__Score_Validated__c = true and TargetX_SRMb__RSAT_I_Reading__c != null Order By TargetX_SRMb__RSAT_I_Reading__c Desc Limit 1];
        rsatReading = (objRSATR.size() > 0 ? objRSATR[0].TargetX_SRMb__RSAT_I_Reading__c : 0);
        
        rsatCompToSatComp = getRsatTotalToSatCompositeMap().get(String.valueOf(rsatComp)).IIT_SAT_Composite__c;
        rsatMathToSatMath = getRsatMathToSatMathMap().get(String.valueOf(rsatMath)).IIT_SAT_Math__c;
        decimal rsatReadingToSatVerbal = getRsatReadingToSatVerbalMap().get(String.valueOf(rsatReading)).IIT_SAT_Verbal__c;
        
        decimal maxSatComp = Math.round(Math.max(satComp,rsatCompToSatComp));
        decimal maxSatMath = Math.round(Math.max(satMath,rsatMathToSatMath));
        
        actSuper = ((actEnglish + actMath + actReading + actScience)/4).round(System.RoundingMode.HALF_UP);
        //satSuper = Math.round(Math.max(satMath,rsatMathToSatMath) + Math.max(satVerbal,rsatReadingToSatVerbal));
        
        satSuperConv = getSatCompositeToActCompositeMap().get(String.valueOf(maxSatComp)).IIT_ACT_Composite__c;
        satCompConv = getSatCompositeToActCompositeMap().get(String.valueOf(maxSatComp)).IIT_ACT_Composite__c;
        satMathConv = getSatMathToActMathMap().get(String.valueOf(maxSatMath)).IIT_ACT_Math__c;
        
        //Get Max Superscore, Composite and Math
        bestSuper = Math.max(actSuper,satSuperConv);
        bestComp = Math.max(actComp,satCompConv);
        bestMath = Math.max(actMath,satMathConv);
        
        //Get High Math Ind
        gethighMathInd(bestMath,bestSuper);
                
        //Get Major Type
        getmajorType(appMajor);
        
        //Get Use Point
        getusePoint(majorType, highestMath, rigorRating, appMajor);
        
        //Get z Scores
        getzBestComp(bestSuper);
        getzBestMath(bestMath);
        getzHSGPA(hsGPA);
        getzHSRank(hsPctRank);
        getzHSQuality(hsQuality);
        getzRigor(usePoint);
        
        //Get Model 1 Weights
        getmodel1CompWeight(bestSuper, majorType, highMathInd);
        getmodel1MathWeight(bestMath, model1CompWeight);
        getmodel1HSGPAWeight(zHSGPA);
        getmodel1HSRankWeight(zHSRank);
        getmodel1HSQualityWeight(zHSQuality);
        model1TotalWeight = (model1CompWeight + model1MathWeight + model1HSGPAWeight + model1HSRankWeight + model1HSQualityWeight);
        
        //Get Model 2 Weights
        getmodel2CompWeight(bestSuper, majorType, highMathInd);
        getmodel2MathWeight(bestMath, model2CompWeight);
        getmodel2HSGPAWeight(zHSGPA);
        getmodel2HSQualityWeight(zHSQuality, majorType);
        getmodel2HighestMathWeight(zRigor, majorType);
        model2TotalWeight = (model2CompWeight + model2MathWeight + model2HSGPAWeight + model2HSQualityWeight + model2HighestMathWeight);
        
        //Get aIndex 1 & 2
        getaIndex1(model1TotalWeight, zBestComp, model1CompWeight, zBestMath, model1MathWeight, zHSGPA, model1HSGPAWeight, zHSQuality, model1HSQualityWeight, zHSRank, model1HSRankWeight);
        getaIndex2(model2TotalWeight, zBestComp, model2CompWeight, zBestMath, model2MathWeight, zHSGPA, model2HSGPAWeight, zHSQuality, model2HSQualityWeight, zRigor, model2HighestMathWeight);
        
        //Get Raw Score
        getrawScore(zHSRank, aIndex1, aIndex2);
        
        //Get Cut Point
        getcutPoint(bestSuper, hsGPA, rawScore);
        
        //Get ACRK
        getACRK(rawScore, bestComp, cutPoint, bestSuper);
        
        
        //START ACRK FLAGS
        
        //Get HS GPA Scale or Weight Flag
        gethsGPAScaleWeightFlag(hsGPAScaleFlag, hsGPA, hsRank, bestComp, highestMath, hsQuality);
        
        //Get Decision Guide Flag
        getdecisionGuide(appCollege, appMajor, rawScore, appGender, hsPctRank, bestComp, hsQuality, bestMath, hsGPA, ACRK);
        
        
        //START MERIT AND HOUSING CALCULATIONS
        
        //Get Merit Award
        meritACRK = (acrkFinal != null ? acrkFinal.intValue() : ACRK);
        meritCollege = (altCollege != null ? altCollege : appCollege);
        meritMajor = (altMajor != null ? altMajor : appMajor);
        getmeritLewis(meritACRK);
        getmeritStuart(meritACRK, appGender, appInState);
        getmeritArchitecture(meritACRK, appGender, appInState);
        getmeritScience(meritACRK, appInState);
        getmeritArmourSatFemale(meritACRK, appInState, meritMajor, bestComp);
        getmeritArmourSatMale(meritACRK, appInState, bestComp, hsGPA, hsPctRank, meritCollege);
        getmeritFinal(appIntl, hsUS, meritACRK, meritLewis, meritStuart, meritArchitecture, meritScience, meritArmourSatFemale, meritArmourSatMale, meritCollege, meritMajor, appGender);
        
        //Get Housing
        meritHousing = (appInState == 1 && appCommuter == 1 ? 2500 : 0);
        
        
        //START SCHOLARSHIP WEEKEND CALCULATIONS
        
        //Get Scholarship Weekend Flag
        swACRK = (acrkFinal != null ? acrkFinal.intValue() : ACRK);
        getswExclusions(hsPctRank, hsGPA);
        getswGrowthPrograms(appMajor);
        getswOverPopulatedPrograms(appMajor);
        getswScholarRule1(swACRK, swGrowthPrograms, swOverPopulatedPrograms, bestComp, appGender, appMajor, hsPctRank, hsSize, hsGPA);
        getswScholarRule2(swACRK, swOverPopulatedPrograms, appBuildState, hsBuildFlag, appGender, bestComp, hsPctRank, hsGPA, bestMath, hsSize, appMajor);
        getswScholarRule3(swACRK, appGender, appMajor, swOverPopulatedPrograms, bestComp, bestMath, hsBuildFlag, hsPctRank, appBuildState, hsSize, appURM, hsGPA);
        getswInviteFlag(swExclusions, swScholarRule1, swScholarRule2, swScholarRule3);
        
        
        //ACRK DISPLAY
        
        //Get ACRK Display Boolean
        acrkDisplay = (appStudentType != 'First Year' || hsGPA == 0 || highestMath == 0 || bestComp == 0 || bestMath == 0 ? false : true);
        
    }
    
    
	//START APEX CLASS FUNCTIONS
	
    //Get Test Score Conversions
    public map<string, IITRSATTotalToSATComposite__c> getRsatTotalToSatCompositeMap() {
        rsatTotalToSatCompositeMap = IITRSATTotalToSATComposite__c.getAll();
        return rsatTotalToSatCompositeMap;
    }
    
    public map<string, IITRSATMathToSATMath__c> getRsatMathToSatMathMap() {
        rsatMathToSatMathMap = IITRSATMathToSATMath__c.getAll();
        return rsatMathToSatMathMap;
    }
    
    public map<string, IITRSATReadingToSATVerbal__c> getRsatReadingToSatVerbalMap() {
        rsatReadingToSatVerbalMap = IITRSATReadingToSATVerbal__c.getAll();
        return rsatReadingToSatVerbalMap;
    }
    
    public map<string, IITSATCompositeToACTComposite__c> getSatCompositeToActCompositeMap() {
        satCompositeToActCompositeMap = IITSATCompositeToACTComposite__c.getAll();
        return satCompositeToActCompositeMap;
    }
    
    public map<string, IITSATMathToACTMath__c> getSatMathToActMathMap() {
        satMathToActMathMap = IITSATMathToACTMath__c.getAll();
        return satMathToActMathMap;
    }
        
	//Get High Math Ind
    public decimal gethighMathInd(decimal bestMath, decimal bestSuper) {
		if ((bestMath - bestSuper) > 1) { 
			highMathInd = 1; 
		} else if (((bestMath - bestSuper) == 1) && (bestSuper < 28)) { 
			highMathInd = 1; 
		} else { 
			highMathInd = 0; 
		}        
        return highMathInd;
    }
    
	//Get Major Type
    public decimal getmajorType(string appMajor) {
        if (appMajor == 'Biochemistry' || appMajor == 'Bioinformatics' || appMajor == 'Biology' || appMajor == 'Biology and Psychology Dual Degree' || appMajor == 'Chemistry' || appMajor == 'Undecided Science') { 
			majorType = 2; 
		} else if (appMajor == 'Architecture' || appMajor == 'Behavioral Health and Wellness' || appMajor == 'Business Administration' || appMajor == 'Communication' || appMajor == 'Consumer Research, Analytics and Communication' || appMajor == 'Digital Humanities' || appMajor == 'Global Studies' || appMajor == 'Humanities' || appMajor == 'Information Technology and Management' || appMajor == 'Psychology' || appMajor == 'Sociology' || appMajor == 'Social and Economic Development Policy' || appMajor == 'Undecided Human Science') { 
			majorType = 1; 
		} else { 
			majorType = 0; 
		}
        return majorType;
    }
    
	//Get Use Point
    public decimal getusePoint(decimal majorType, decimal highestMath, decimal rigorRating, string appMajor) {
        if (majorType == 0) { 
        	usePoint = highestMath; 
        } else if (highestMath == 4) { 
        	usePoint = 4; 
        } else if (rigorRating == 3 && highestMath > 1 && majorType > 0) { 
        	usePoint = 4; 
        } else if (rigorRating == 3 && appMajor == 'Architecture') { 
        	usePoint = 4; 
        } else if (rigorRating == 2 && highestMath == 2 && majorType == 2) { 
        	usePoint = 3; 
        } else if (majorType == 2) { 
        	usePoint = highestMath; 
        } else if (majorType == 1 && rigorRating == 1 && highestMath == 1 && appMajor != 'Architecture') { 
        	usePoint = 1; 
        } else { 
        	usePoint = 0; 
        }
        return usePoint;
    }
    
	//Get z Scores
    public decimal getzBestComp(decimal bestSuper) {
        if (bestSuper == 0) { 
			zBestComp = 999; 
		} else { 
      		zBestComp = (bestSuper - 28.1937) / 3.69895; 
    	}
        return zBestComp;
    }
    
    public decimal getzBestMath(decimal bestMath) {
        if (bestMath == 0) { 
      		zBestMath = 999; 
    	} else { 
      		zBestMath = (bestMath - 29.2926) / 4.02194; 
    	}
        return zBestMath;
    }
    
    public decimal getzHSGPA(decimal hsGPA) {
        if (hsGPA == 0) { 
			zHSGPA = 999; 
    	} else { 
      		zHSGPA = (hsGPA - 3.8646) / 0.46037; 
    	}
        return zHSGPA;
    }
    
    public decimal getzHSRank(decimal hsPctRank) {
        if (hsPctRank == 0) { 
			zHSRank = 999; 
    	} else { 
			zHSRank = (hsPctRank - 0.8282) / 0.15619; 
    	}
        return zHSRank;
    }
    
    public decimal getzHSQuality(decimal hsQuality) {
        if (hsQuality == 0) { 
			zHSQuality = 999; 
    	} else { 
			zHSQuality = (hsQuality - 0.69612) / 0.258044; 
    	}
        return zHSQuality;
    }
    
    public decimal getzRigor(decimal usePoint) {
		if (usePoint < 1) { 
			zRigor = 999; 
		} else { 
			zRigor = (usePoint - 3.1948) / 1.01319; 
		}
        return zRigor;
    }
    
	//Get Model 1 Weights
    public decimal getmodel1CompWeight(decimal bestSuper, decimal majorType, decimal highMathInd) {
		if (bestSuper > 0 && majorType == 0) { 
			model1CompWeight = 0.20; 
		} else if (bestSuper > 0 && majorType == 2 && highMathInd == 0) { 
			model1CompWeight = 0.25; 
		} else if (bestSuper > 0 && majorType == 2 && highMathInd == 1) { 
			model1CompWeight = 0.20; 
		} else if (bestSuper > 0 && majorType == 1 && highMathInd == 0) { 
			model1CompWeight = 0.40; 
		} else if (bestSuper > 0 && majorType == 1 && highMathInd == 1) { 
			model1CompWeight = 0.20; 
		} else { 
			model1CompWeight = 0; 
		}
        return model1CompWeight;
    }
  
    public decimal getmodel1MathWeight(decimal bestmath, decimal model1CompWeight) {
		if (bestMath == 0) { 
			model1MathWeight = 0; 
		} else { 
			model1MathWeight = (0.40 - model1CompWeight);
		}
        return model1MathWeight;
    }
  
    public decimal getmodel1HSGPAWeight(decimal zHSGPA) {
		if (zHSGPA < 999) { 
			model1HSGPAWeight = 0.20; 
		} else { 
			model1HSGPAWeight = 0; 
		}
        return model1HSGPAWeight;
    }
    
    public decimal getmodel1HSRankWeight(decimal zHSRank) {
		if (zHSRank < 999) { 
			model1HSRankWeight = 0.30; 
		} else { 
			model1HSRankWeight = 0; 
		}
        return model1HSRankWeight;
    }

    public decimal getmodel1HSQualityWeight(decimal zHSQuality) {
		if (zHSQuality < 999) { 
			model1HSQualityWeight = 0.10; 
		} else { 
			model1HSQualityWeight = 0; 
		}
		return model1HSQualityWeight;
    }
    
	//Get Model 2 Weights
    public decimal getmodel2CompWeight(decimal bestSuper, decimal majorType, decimal highMathInd) {
		if (bestSuper > 0 && majorType == 0) { 
			model2CompWeight = 0.20; 
		} else if (bestSuper > 0 && majorType == 2 && highMathInd == 0) { 
			model2CompWeight = 0.25; 
		} else if (bestSuper > 0 && majorType == 2 && highMathInd == 1) { 
			model2CompWeight = 0.20; 
		} else if (bestSuper > 0 && majorType == 1 && highMathInd == 0) { 
			model2CompWeight = 0.40; 
		} else if (bestSuper > 0 && majorType == 1 && highMathInd == 1) { 
			model2CompWeight = 0.20; 
		} else { 
			model2CompWeight = 0; 
		}
        return model2CompWeight;
    }
    
    public decimal getmodel2MathWeight(decimal bestMath, decimal model2CompWeight) {
		if (bestMath == 0) { 
			model2MathWeight = 0; 
		} else { 
			model2MathWeight = (0.40 - model2CompWeight);
		}
        return model2MathWeight;
    }
    
    public decimal getmodel2HSGPAWeight(decimal zHSGPA) {
		if (zHSGPA < 999) { 
			model2HSGPAWeight = 0.45; 
		} else { 
			model2HSGPAWeight = 0; 
		}
        return model2HSGPAWeight;
    }
    
    public decimal getmodel2HSQualityWeight(decimal zHSQuality, decimal majorType) {
		if (zHSQuality < 999 && majorType == 1) { 
			model2HSQualityWeight = 0.10;
        } else if (zHSQuality < 999) {
            model2HSQualityWeight = 0.05;
        } else { 
			model2HSQualityWeight = 0;
		}
        return model2HSQualityWeight;
    }
    
    public decimal getmodel2HighestMathWeight(decimal zRigor, decimal majorType) {
		if (zRigor < 999 && majorType == 1) { 
			model2HighestMathWeight = 0.05;
        } else if (zRigor < 999) {
            model2HighestMathWeight = 0.10;
        } else { 
			model2HighestMathWeight = 0; 
		}
        return model2HighestMathWeight;
    }
    
	//Get aIndex 1 & 2
    public decimal getaIndex1(decimal model1TotalWeight, decimal zBestComp, decimal model1CompWeight, decimal zBestMath, decimal model1MathWeight, decimal zHSGPA, decimal model1HSGPAWeight, decimal zHSQuality, decimal model1HSQualityWeight, decimal zHSRank, decimal model1HSRankWeight) {
		if (model1TotalWeight == 0) { 
			aIndex1 = -999; 
		} else { 
			aIndex1 = (((zBestComp * model1CompWeight) + (zBestMath * model1MathWeight) + (zHSGPA * model1HSGPAWeight) + (zHSQuality * model1HSQualityWeight) + (zHSRank * model1HSRankWeight)) / model1TotalWeight); 
		}
        return aIndex1;
    }
    
	public decimal getaIndex2(decimal model2TotalWeight, decimal zBestComp, decimal model2CompWeight, decimal zBestMath, decimal model2MathWeight, decimal zHSGPA, decimal model2HSGPAWeight, decimal zHSQuality, decimal model2HSQualityWeight, decimal zRigor, decimal model2HighestMathWeight) {
		if (model2TotalWeight == 0) { 
			aIndex2 = -999; 
		} else { 
			aIndex2 = (((zBestComp * model2CompWeight) + (zBestMath * model2MathWeight) + (zHSGPA * model2HSGPAWeight) + (zHSQuality * model2HSQualityWeight) + (zRigor * model2HighestMathWeight)) / model2TotalWeight); 
		}
        return aIndex2;
    }
    
	//Get Raw Score
    public decimal getrawScore(decimal zHSRank, decimal aIndex1, decimal aIndex2) {
		if (zHSRank == 999) {
			rawScore = aIndex2;
		} else {
			rawScore = aIndex1;
		}
        return rawScore;
    }
    
	//Get Cut Point
    public integer getcutPoint(decimal bestSuper, decimal hsGPA, decimal rawScore) {
		if (bestSuper == 0 && hsGPA == 0) { 
			cutPoint = 0; 
		} else if (rawScore >= -999 && rawScore < -0.527) { 
			cutPoint = 6; 
		} else if (rawScore >= -0.527 && rawScore < -0.1291) { 
			cutPoint = 5; 
		} else if (rawScore >= -0.1291 && rawScore < 0.1426) { 
			cutPoint = 4; 
		} else if (rawScore >= 0.1426 && rawScore < 0.4285) { 
			cutPoint = 3; 
		} else if (rawScore >= 0.4285 && rawScore < 0.7654) { 
			cutPoint = 2; 
		} else if (rawScore >= 0.7654) { 
			cutPoint = 1; 
		}
        return cutPoint;
    }
    
    //Get ACRK
    public integer getACRK(decimal rawScore, decimal bestComp, integer cutPoint, decimal bestSuper) {
        if (rawScore == -999) {
			ACRK = null;
        } else if (rawScore < -0.14 && bestComp < 21) {
			ACRK = 6;
        } else if (cutPoint == 6 && bestSuper >= 31) {
			ACRK = 5;
        } else if (cutPoint == 1 && bestComp <= 27) {
			ACRK = 2;
        } else {
			ACRK = cutPoint;
        }
        return ACRK;
    }
    
	//Get HS GPA Scale or Weight Flag
    public string gethsGPAScaleWeightFlag(string hsGPAScaleFlag, decimal hsGPA, decimal hsRank, decimal bestComp, decimal highestMath, decimal hsQuality) {
        if (String.isNotBlank(hsGPAScaleFlag)) {
            hsGPAScaleWeightFlag = hsGPAScaleFlag;
        } else if (hsGPA > 4.15) {
            hsGPAScaleWeightFlag = null;
        } else if (hsRank > 0) {
            hsGPAScaleWeightFlag = null;
        } else if (bestComp < 28) {
            hsGPAScaleWeightFlag = null;
        } else if (highestMath < 3) {
            hsGPAScaleWeightFlag = null;
        } else if (hsQuality < 0.8) {
            hsGPAScaleWeightFlag = null;
        } else {
            hsGPAScaleWeightFlag = 'Check Weight';
        }
        return hsGPAScaleWeightFlag;
    }
    
    //Get Decision Guide Flag
    public string getdecisionGuide(string appCollege, string appMajor, decimal rawScore, string appGender, decimal hsPctRank, decimal bestComp, decimal hsQuality, decimal bestMath, decimal hsGPA, integer ACRK) {
        integer decisionGuideCollege = (appCollege == 'Armour College of Engineering' || appCollege == 'College of Science' ? 1 : 0);
        integer decisionGuideMajors1 = (appMajor != 'Architecture' || appMajor != 'Communications' || appMajor != 'Digital Humanities' || appMajor != 'Humanities' || appMajor != 'Global Studies' ? 1 : 0);
        integer decisionGuideMajors2 = (appMajor != 'Biology' || appMajor != 'Biology and Psychology Dual Degree' || appMajor != 'Biochemistry' || appMajor != 'Chemistry' || appMajor != 'Undecided Science' || appMajor != 'Computer Information Systems' ? 1 : 0);
        
        if (rawScore < -1.65) {
            decisionGuide = 'Deny or JC Deny';
        } else if (appGender == 'Male' && rawScore < -0.90 && hsPctRank != 0 && hsPctRank < 0.40) {
            decisionGuide = 'Deny or JC Deny';
        } else if (bestComp <= 20 && rawScore < -0.75) {
            decisionGuide = 'Deny or JC Deny';
        } else if (hsQuality != 0 && hsQuality < 0.30 && rawScore < -0.85 && bestMath < 23 && decisionGuideMajors1 == 1) {
            decisionGuide = 'Deny or JC Deny';
        } else if (bestMath < 21) {
            decisionGuide = 'Deny or JC Deny';
        } else if (bestComp <= 21 && appMajor != 'Architecture') {
            decisionGuide = 'Committee';
        } else if (bestMath < 23 && decisionGuideMajors1 == 1) {
            decisionGuide = 'Committee';
        } else if (hsGPA < 3.0) {
            decisionGuide = 'Committee';
        } else if (hsGPA < 3.5 && hsQuality != 0 && hsQuality < 0.70 && hsPctRank != 0 && hsPctRank < 0.85) {
            decisionGuide = 'Committee';
        } else if (hsGPA < 3.5 && hsPctRank != 0 && hsPctRank < 0.50) {
            decisionGuide = 'Committee';
        } else if (appMajor == 'Architecture' && ACRK > 4 && hsGPA < 3.25) {
            decisionGuide = 'Committee';
        } else if (appMajor == 'Architecture' && hsPctRank != 0 && hsPctRank < 0.60) {
            decisionGuide = 'Committee';
        } else if (appGender == 'Male' && rawScore < -0.90 && hsQuality < 0.70) {
            decisionGuide = 'Committee';
        } else if (appGender == 'Female' & rawScore < -0.95 && hsQuality < 0.70) {
            decisionGuide = 'Committee';
        } else if (decisionGuideCollege == 1 && bestComp <= 23 && ACRK >= 5) {
            decisionGuide = 'Committee or Counselor Reconsider';
        } else if (decisionGuideCollege == 1 && bestMath <= 24) {
            decisionGuide = 'Committee or Counselor Reconsider';
        } else if (decisionGuideCollege == 1 && hsGPA < 3.4 && (hsPctRank < 0.85 || (ACRK == 6 && hsQuality != 0 && hsQuality < 0.90 && hsPctRank == 0) || (ACRK == 6 && highestMath == 4 && hsQuality != 0 && hsQuality <= 0.75))) {
            decisionGuide = 'Committee or Counselor Reconsider';
        } else if (decisionGuideCollege == 1 && hsPctRank != 0 && hsPctRank < 0.70 && hsQuality <= 0.70) {
            decisionGuide = 'Committee or Counselor Reconsider';
        } else if (decisionGuideCollege == 1 && appMajor == 'Applied Math' && bestMath <= 25) {
            decisionGuide = 'Committee or Counselor Reconsider';
        } else if (decisionGuideCollege == 1 && bestMath == 25 && ACRK == 6 && appGender == 'Male' && decisionGuideMajors2 == 1) {
            decisionGuide = 'Committee or Counselor Reconsider';
        } else if (decisionGuideCollege == 1 && bestMath == 25 && bestComp <= 25 && ACRK == 5 && appGender == 'Male' && decisionGuideMajors2 == 1) {
            decisionGuide = 'Committee or Counselor Reconsider';
        } else {
            decisionGuide = 'Admissible';
        }
        return decisionGuide;
    }
    
	//Get Merit Awards
    public integer getmeritLewis(integer meritACRK) {
        if (meritACRK == 1 || meritACRK == 2 || meritACRK == 3) {
            meritLewis = 27500;
        } else if (meritACRK == 4) {
            meritLewis = 25000;
        } else if (meritACRK == 5) {
            meritLewis = 22500;
        } else if (meritACRK == 6) {
            meritLewis = 18500;
        } else {
            meritLewis = 0;
        }
        return meritLewis;
    }
    
    public integer getmeritStuart(integer meritACRK, string appGender, integer appInState) {
        if (meritACRK == 1 || meritACRK == 2) {
            meritStuart = (appGender == 'Female' || appInState == 0 ? 27500 : 25000);
        } else if (meritACRK == 3) {
            meritStuart = (appGender == 'Female' || appInState == 0 ? 27500 : 22500);
        } else if (meritACRK == 4) {
            meritStuart = (appGender == 'Female' || appInState == 0 ? 25000 : 22500);
        } else if (meritACRK == 5) {
            meritStuart = (appGender == 'Female' || appInState == 0 ? 22500 : 20000);
        } else if (meritACRK == 6) {
            meritStuart = 18500;
        } else {
            meritStuart = 0;
        }
        return meritStuart;
    }
    
    public integer getmeritArchitecture(integer meritACRK, string appGender, integer appInState) {
        if (meritACRK == 1 || meritACRK == 2 || meritACRK == 3) {
            meritArchitecture = 25000;
        } else if (meritACRK == 4) {
            meritArchitecture = 23000;
        } else if (meritACRK == 5) {
            meritArchitecture = 20000;
        } else if (meritACRK == 6) {
            meritArchitecture = (appGender == 'Female' || appInState == 0 ? 18500 : 16000);
        } else {
            meritArchitecture = 0;
        }
        return meritArchitecture;
    }
    
    public integer getmeritScience(integer meritACRK, integer appInState) {
        if (meritACRK == 1 || meritACRK == 2 || meritACRK == 3) {
            meritScience = (appInState == 0 ? 27500 : 25000);
        } else if (meritACRK == 4) {
            meritScience = 25000;
        } else if (meritACRK == 5) {
            meritScience = 22500;
        } else if (meritACRK == 6) {
            meritScience = 18500;
        } else {
            meritScience = 0;
        }
        return meritScience;
    }
    
    public integer getmeritArmourSatFemale(integer meritACRK, integer appInState, string meritMajor, decimal bestComp) {
        integer meritComputing = (meritMajor == 'Computer Science' || meritMajor == 'Computer Information Systems' || meritMajor == 'Computer Engineering' || meritMajor == 'Information Technology and Management' ? 1 : 0);
        
        if (meritACRK == 1 && appInState == 0 && meritComputing == 1) {
            meritArmourSatFemale = 30000;
        } else if (meritACRK == 1 && ((appInState == 0 && meritComputing == 0) || (appInState == 1 && meritComputing == 1))) {
            meritArmourSatFemale = 27500;
        } else if (meritACRK == 1 && appInState == 1 && meritComputing == 0) {
            meritArmourSatFemale = 25000;
        } else if (meritACRK == 2 || meritACRK == 3) {
            meritArmourSatFemale = (appInState == 0 || (appInState == 1 && meritComputing == 1) ? 27500 : 25000);
        } else if (meritACRK == 4) {
            meritArmourSatFemale = (appInState == 0 && meritComputing == 1 ? 27500 : 25000);
        } else if (meritACRK == 5 && bestComp <= 25 && ((appInState == 0 && meritComputing == 0) || (appInState == 1 && meritComputing == 1))) {
            meritArmourSatFemale = 20000;
        } else if (meritACRK == 5 && appInState == 0 && meritComputing == 1) {
            meritArmourSatFemale = 25000;
        } else if (meritACRK == 5 && ((appInState == 0 && meritComputing == 0) || (appInState == 1 && meritComputing == 1))) {
            meritArmourSatFemale = 22500;
        } else if (meritACRK == 5 && appInState == 1 && meritComputing == 0) {
            meritArmourSatFemale = 18000;
        } else if (meritACRK == 6) {
            meritArmourSatFemale = (meritComputing == 1 ? 19000 : 17500);
        } else {
            meritArmourSatFemale = 0;
        }
        return meritArmourSatFemale;
    }
    
    public integer getmeritArmourSatMale(integer meritACRK, integer appInState, decimal bestComp, decimal hsGPA, decimal hsPctRank, string meritCollege) {
        if (meritACRK == 1 || meritACRK == 2) {
            meritArmourSatMale = 25000;
        } else if ((meritACRK == 3 || meritACRK == 4) && appInState == 1 && bestComp >= 28 && hsGPA >= 3.75 && (hsPctRank == 0 || hsPctRank > 0.74)) {
            meritArmourSatMale = 22500;
        } else if (meritACRK == 3) {
            meritArmourSatMale = (appInState == 0 ? 25000 : 20000);
        } else if (meritACRK == 4 && appInState == 0 && bestComp >= 27) {
            meritArmourSatMale = 25000;
        } else if (meritACRK == 4) {
            meritArmourSatMale = (appInState == 0 ? 22000 : 20000);
        } else if (meritACRK == 5 && appInState == 1 && meritCollege == 'School of Applied Technology') {
            meritArmourSatMale = 20000;
        } else if (meritACRK == 5) {
            meritArmourSatMale = (appInState == 0 ? 20000 : 15500);
        } else if (meritACRK == 6 && meritCollege == 'School of Applied Technology') {
            meritArmourSatMale = 18000;
        } else if (meritACRK == 6) {
            meritArmourSatMale = (appInState == 0 ? 17500 : 15500);
        } else {
            meritArmourSatMale = 0;
        }
        return meritArmourSatMale;
    }
    
    public integer getmeritFinal(integer appIntl, integer hsUS, integer meritACRK, integer meritLewis, integer meritStuart, integer meritArchitecture, integer meritScience, integer meritArmourSatFemale, integer meritArmourSatMale, string meritCollege, string meritMajor, string appGender) {
        integer meritComputing = (meritMajor == 'Computer Science' || meritMajor == 'Computer Information Systems' || meritMajor == 'Computer Engineering' || meritMajor == 'Information Technology and Management' ? 1 : 0);
        integer meritScienceExclusion = (meritMajor == 'Physics' || meritMajor == 'Astrophysics' || meritMajor == 'Applied Physics' || meritMajor == 'Computer Science' || meritMajor == 'Computer Information Systems' ? 1 : 0);
        
        if (appIntl == 1 && hsUS == 1) {
            if ((meritACRK == 1 || meritACRK == 2) && ((meritCollege == 'Lewis College of Human Sciences' && meritMajor != 'Undecided Human Science') || (appGender == 'Female' && meritComputing == 1))) {
                meritFinal = 27500;
            } else if (meritACRK == 1 || meritACRK == 2) {
                meritFinal = 25000;
            } else if (meritACRK == 3 || meritACRK == 4) {
                meritFinal = 21500;
            } else if (meritACRK == 5) {
                meritFinal = 18000;
            } else if (meritACRK == 6) {
                meritFinal = 16000;
            } else {
                meritFinal = 0;
            }
        } else {        
        	if (meritCollege == 'Lewis College of Human Sciences') {
            	meritFinal = meritLewis;
        	} else if (meritCollege == 'Stuart School of Business') {
            	meritFinal = meritStuart;
        	} else if (meritCollege == 'College of Architecture') {
            	meritFinal = meritArchitecture;
        	} else if (meritCollege == 'College of Science' && meritScienceExclusion != 1) {
            	meritFinal = meritScience;
        	} else if ((meritCollege == 'Armour College of Engineering' || meritCollege == 'School of Applied Technology' || meritCollege == 'College of Science') && appGender == 'Female') {
            	meritFinal = meritArmourSatFemale;
        	} else if ((meritCollege == 'Armour College of Engineering' || meritCollege == 'School of Applied Technology' || meritCollege == 'College of Science') && appGender == 'Male') {
            	meritFinal = meritArmourSatMale;
        	} else {
            	meritFinal = 0;
        	}
        }
        return meritFinal;
    }
    
	//Get Scholarship Weekend Flags
    public string getswExclusions(decimal hsPctRank, decimal hsGPA) {
        if (hsPctRank != 0 && hsPctRank < 0.85) {
            swExclusions = 'No Invite';
        } else if (hsGPA < 3.75) {
            swExclusions = 'No Invite';
        } else {
            swExclusions = null;
        }
        return swExclusions;
    }
        
    public integer getswGrowthPrograms(string appMajor) {
        if (appMajor == 'Applied Analytics' || appMajor == 'Behavioral Health and Wellness' || appMajor == 'Business Administration' || appMajor == 'Communications' || appMajor == 'Consumer Research, Analytics, and Communication' || appMajor == 'Digital Humanities' || appMajor == 'Global Studies' || appMajor == 'Humanities' || appMajor == 'Psychology' || appMajor == 'Social and Economic Development Policy') {
            swGrowthPrograms = 1;
        } else {
            swGrowthPrograms = 0;
        }
        return swGrowthPrograms;
    }
    
    public integer getswOverPopulatedPrograms(string appMajor) {
        if (appMajor == 'Aerospace Engineering' || appMajor == 'Biomedical Engineering' || appMajor == 'Civil Engineering' || appMajor == 'Computer Engineering' || appMajor == 'Computer Information Systems' || appMajor == 'Computer Science' || appMajor == 'Electrical Engineering' || appMajor == 'Engineering Management' || appMajor == 'Information Technology and Management' || appMajor == 'Mechanical Engineering' || appMajor == 'Undecided Armour') {
            swOverPopulatedPrograms = 1;
        } else {
            swOverPopulatedPrograms = 0;
        }
        return swOverPopulatedPrograms;
    }
        
    public string getswScholarRule1(integer swACRK, integer swGrowthPrograms, integer swOverPopulatedPrograms, decimal bestComp, string appGender, string appMajor, decimal hsPctRank, decimal hsSize, decimal hsGPA) {
        if (swACRK == 1 && swGrowthPrograms == 1) {
            swScholarRule1 = 'Scholar';
        } else if (swACRK == 1 && swOverPopulatedPrograms != 1 && bestComp > 30) {
            swScholarRule1 = 'Scholar';
        } else if (swACRK == 1 && appGender == 'Female' && bestComp > 30 && (appMajor == 'Computer Engineering' || appMajor == 'Computer Information Systems' || appMajor == 'Computer Science' || appMajor == 'Electrical Engineering' || appMajor == 'Information Technology and Management')) {
			swScholarRule1 = 'Scholar';
        } else if (swACRK == 1 && bestComp > 30 && hsPctRank >= 0.985 && hsSize > 100) {
			swScholarRule1 = 'Scholar';
        } else if (swACRK == 2 && swGrowthPrograms == 1 && bestComp >= 28) {
			swScholarRule1 = 'Scholar';
        } else if (swACRK == 3 && swGrowthPrograms == 1 && bestComp >= 28 && hsPctRank >= 0.90) {
			swScholarRule1 = 'Scholar';
        } else if (swACRK == 3 && swGrowthPrograms == 1 && bestComp >= 28 && hsPctRank == 0 && hsGPA >= 4.0) {
			swScholarRule1 = 'Scholar';
        } else {
            swScholarRule1 = null;
        }
        return swScholarRule1;
    }
        
    public string getswScholarRule2(integer swACRK, integer swOverPopulatedPrograms, integer appBuildState, decimal hsBuildFlag, string appGender, decimal bestComp, decimal hsPctRank, decimal hsGPA, decimal bestMath, decimal hsSize, string appMajor) {
        if (swACRK == 1 && swOverPopulatedPrograms != 1) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK == 1 && swOverPopulatedPrograms == 1 && appBuildState == 1) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK == 1 && swOverPopulatedPrograms == 1 && hsBuildFlag == 1 && appGender == 'Female' && bestComp >= 30) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK == 1 && swOverPopulatedPrograms == 1 && hsBuildFlag == 1 && bestComp >= 32) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK == 1 && swOverPopulatedPrograms == 1 && bestComp >= 33 && hsPctRank >= 0.90) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK == 1 && swOverPopulatedPrograms == 1 && bestComp >= 33 && hsPctRank == 0 && hsGPA > 4.0) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK == 1 && swOverPopulatedPrograms == 1 && bestMath >= 31 && hsPctRank >= 0.95 && hsSize > 100) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK == 2 && appMajor == 'Architecture' && bestComp > 28 && hsGPA >= 4.0 && hsPctRank == 0) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK == 2 && appMajor == 'Architecture' && bestComp > 28 && hsGPA >= 4.0 && hsPctRank >= 0.90) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK == 2 && swOverPopulatedPrograms != 1 && bestComp >= 31 && bestMath >= 28 && appBuildState == 1) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK == 2 && swOverPopulatedPrograms != 1 && bestComp >= 31 && bestMath >= 28 && hsBuildFlag == 1) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK == 2 && swOverPopulatedPrograms != 1 && bestComp >= 30 && hsPctRank >= 0.975 && hsSize >= 100) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK == 2 && swOverPopulatedPrograms != 1 && bestComp >= 31 && bestMath >= 30 && hsPctRank == 0 && hsGPA >= 3.9) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK == 2 && appGender == 'Female' && bestComp >= 28 && bestMath >= 31 && (appMajor == 'Computer Engineering' || appMajor == 'Computer Information Systems' || appMajor == 'Computer Science' || appMajor == 'Electrical Engineering' || appMajor == 'Information Technology and Management')) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK <= 2 && swOverPopulatedPrograms == 1 && appGender == 'Female' && bestComp >= 31 && hsPctRank >= 0.970 && hsSize > 100) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK <= 2 && swOverPopulatedPrograms == 1 && (appBuildState == 1 || hsBuildFlag == 1) && bestComp >= 31 && bestMath >= 31 && hsPctRank >= 0.975) {
            swScholarRule2 = 'Strongly Consider';
        } else if (swACRK <= 2 && swOverPopulatedPrograms == 1 && (appBuildState == 1 || hsBuildFlag == 1) && bestComp >= 32 && bestMath >= 31 && hsPctRank == 0) {
            swScholarRule2 = 'Strongly Consider';
        } else {
            swScholarRule2 = null;
        }
        return swScholarRule2;
    }
        
    public string getswScholarRule3(integer swACRK, string appGender, string appMajor, integer swOverPopulatedPrograms, decimal bestComp, decimal bestMath, decimal hsBuildFlag, decimal hsPctRank, integer appBuildState, decimal hsSize, integer appURM, decimal hsGPA) {
        if (swACRK == 1) {
            swScholarRule3 = 'Consider';
        } else if (swACRK == 2 && appGender == 'Female' && (appMajor == 'Computer Engineering' || appMajor == 'Computer Information Systems' || appMajor == 'Computer Science' || appMajor == 'Electrical Engineering' || appMajor == 'Information Technology and Management')) {
            swScholarRule3 = 'Consider';
        } else if (swACRK == 2 && swOverPopulatedPrograms != 1 && bestComp >= 29 && bestMath >= 29 && hsBuildFlag == 1) {
            swScholarRule3 = 'Consider';
        } else if (swACRK == 2 && swOverPopulatedPrograms == 1 && bestComp >= 33 && hsPctRank == 0) {
            swScholarRule3 = 'Consider';
        } else if (swACRK == 2 && swOverPopulatedPrograms == 1 && appGender == 'Female' && bestComp >= 32 && hsPctRank == 0) {
            swScholarRule3 = 'Consider';
        } else if (swACRK == 2 && swOverPopulatedPrograms == 1 && appGender == 'Female' && (appBuildState == 1 || hsBuildFlag == 1)) {
            swScholarRule3 = 'Consider';
        } else if (swACRK == 2 && swOverPopulatedPrograms == 1 && bestComp >= 30 && hsPctRank >= 0.98 && hsSize >= 100) {
            swScholarRule3 = 'Consider';
        } else if (swACRK <= 3 && appMajor == 'Architecture' && bestComp >= 30 && appBuildState == 1) {
            swScholarRule3 = 'Consider';
        } else if (swACRK <= 3 && appMajor == 'Undecided Human Science' && bestComp >= 28) {
            swScholarRule3 = 'Consider';
        } else if (swACRK <= 3 && appURM == 1 && bestComp >= 27 && hsPctRank == 0 && hsGPA > 3.9) {
            swScholarRule3 = 'Consider';
        } else if (swACRK <= 3 && appURM == 1 && bestComp >= 27 && hsPctRank >= 0.90) {
            swScholarRule3 = 'Consider';
        } else if (swACRK <= 2 && appURM == 1 && bestComp >= 30) {
            swScholarRule3 = 'Consider';
        } else {
            swScholarRule3 = null;
        }
        return swScholarRule3;
    }
    
    public string getswInviteFlag(string swExclusions, string swScholarRule1, string swScholarRule2, string swScholarRule3) {
        if (swExclusions == 'No Invite') {
            swInviteFlag = null;
        } else if (swScholarRule1 == 'Scholar') {
            swInviteFlag = 'Scholar';
        } else if (swScholarRule2 == 'Strongly Consider') {
            swInviteFlag = 'Strongly Consider';
        } else if (swScholarRule3 == 'Consider') {
            swInviteFlag = 'Consider';
        } else {
            swInviteFlag = null;
        }
        return swInviteFlag;
    }
        
    
	//Return All VF Page Variables
    public boolean getacrkDisplay() {
        return acrkDisplay;
    }
    
    public integer getACRK() {
        return ACRK;
    }
    
    public integer getmeritFinal() {
        return meritFinal;
    }
    
    public integer getmeritHousing() {
        return meritHousing;
    }
    
    public string gethsGPAScaleWeightFlag() {
        return hsGPAScaleWeightFlag;
    }
    
    public string getswInviteFlag() {
        return swInviteFlag;
    }
    
    public string getdecisionGuide() {
        return decisionGuide;
    }
    
    public decimal getrsatCompToSatComp() {
        return rsatCompToSatComp;
    }
    
    public decimal getrsatMathToSatMath() {
        return rsatMathToSatMath;
    }
    
    public decimal getsatCompConv() {
        return satCompConv;
    }
    
    public decimal getsatMathConv() {
        return satMathConv;
    }
    
    
	//Set Calculated Fields
    public PageReference executeDML() {
		if (appReviewCompleted == false && acrkDisplay == true) {
			TargetX_Reader__Application_Review__c appReviewToUpdate;
            appReviewToUpdate = [SELECT Id, IIT_ACRK_Calculated__c, IIT_Merit_Calculated__c, IIT_Camras_Calculated__c, IIT_Decision_Guide_Calculated__c FROM TargetX_Reader__Application_Review__c WHERE Id = :Current_AppReview_Id LIMIT 1];
            appReviewToUpdate.IIT_ACRK_Calculated__c = ACRK;
            appReviewToUpdate.IIT_Merit_Calculated__c = meritFinal;
            appReviewToUpdate.IIT_Camras_Calculated__c = swInviteFlag;
            appReviewToUpdate.IIT_Decision_Guide_Calculated__c = decisionGuide;
            update appReviewToUpdate;
            return null;
        } else {
            return null;
        }
    }
    
    
	//Set Calculated Fields in Batch
    public PageReference executeBatchDML() {
		if (acrkDisplay == true) {
			TargetX_Reader__Application_Review__c appReviewToUpdate;
			appReviewToUpdate = [SELECT Id, IIT_ACRK_Calculated__c, IIT_Merit_Calculated__c, IIT_Camras_Calculated__c, IIT_Decision_Guide_Calculated__c FROM TargetX_Reader__Application_Review__c WHERE Id = :Current_AppReview_Id LIMIT 1];
			appReviewToUpdate.IIT_ACRK_Calculated__c = ACRK;
			appReviewToUpdate.IIT_Merit_Calculated__c = meritFinal;
			appReviewToUpdate.IIT_Camras_Calculated__c = swInviteFlag;
            appReviewToUpdate.IIT_Decision_Guide_Calculated__c = decisionGuide;
			update appReviewToUpdate;
            return null;
        } else {
            return null;
        }
    }

}