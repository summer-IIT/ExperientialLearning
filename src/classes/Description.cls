public class Description{
       List<TargetX_Base__Academic_Period__c> acts = [SELECT Video_URL__c,Description__c FROM TargetX_Base__Academic_Period__c];
       
       public List<TargetX_Base__Academic_Period__c> getacts(){
       return acts;
       }
}