public with sharing class TX_sObjectRemote{
    
    //---Insert method---
    @RemoteAction 
    public static List<Database.SaveResult> insertSObjects(List<sObject> objects, Map<String,String> dmlOptions){

        //Process and set the DML options
        Database.DMLOptions dmo = TX_sObjectRemote.setDMLoptions(dmlOptions);
        
        //Do the insert
        Database.SaveResult[] result = Database.insert(objects,dmo);

        //Return the result
        return result;
    }

    //---Query method---
    @RemoteAction 
    public static QueryResult query(String soql){
        //QueryResult object that retruns sObjectType info and the records queried
        QueryResult qr = new QueryResult();

        //Perform the query
        for(sObject obj : Database.query(soql)){
            //Add sObject list of sObject returned in the QueryResult
            qr.sObjects.add(obj);
        }

        //Set the object type in the attributes of the QueryResult
        if(qr.sObjects.size() > 0){
            qr.sObjectAttributes.put('sObjectType',String.valueOf(qr.sObjects[0].getsObjectType()));
        }
        return qr;
    }

    //---Update Method---
    @RemoteAction 
    public static List<Database.SaveResult> updateSObjects(List<sObject> objects, Map<String,String> dmlOptions){
        Database.DMLOptions dmo = TX_sObjectRemote.setDMLoptions(dmlOptions);
        
        Database.SaveResult[] result = Database.update(objects,dmo);
        return result;
    }

    //---Upsert Method---
    @RemoteAction 
    public static List<Database.UpsertResult> upsertSObjects(List<sObject> objects, Map<String,String> dmlOptions){
        Database.UpsertResult[] result = new Database.UpsertResult[]{};
        Map<Schema.SObjectType,List<sObject>> sobjectsMap = new Map<Schema.SObjectType,List<sObject>>();
        Map<String,Schema.SObjectField> externalIds = parseExternalIdFields(objects,dmlOptions);
        List<Schema.SObjectType> sObjectTypeList = new List<Schema.SObjectType>(); //to maintain order
        for(sObject sobj : objects){
            Schema.SObjectType stype = sObj.getSobjectType();
            if(sobjectsMap.get(stype) == null){
                Type listType = Type.forName('List<' + stype + '>');
                sobjectsMap.put(stype,(List<sObject>)listType.newInstance());
                sObjectTypeList.add(stype);
            }
            sobjectsMap.get(stype).add(sObj);
        }
        for(Schema.SObjectType stype : sObjectTypeList){
            Schema.SObjectField sField = externalIds.get(String.valueOf(stype));
            if(sField != null){
                result.addAll(Database.upsert(sobjectsMap.get(stype),sField)); 
            }
            else{
                result.addAll(Database.upsert(sobjectsMap.get(stype),false)); 
            }
        }
        
        return result;
    }

    //---Delete Method---
    @RemoteAction
    public static List<Database.DeleteResult> deleteSObjects(List<sObject> sObjects, Map<String,String> dmlOptions){

        Database.DMLOptions dmo = TX_sObjectRemote.setDMLoptions(dmlOptions);
        
        //Default allOrNone options to true
        Boolean allOrNone = true;
        if(dmo.optAllOrNone == false){
            allOrNone = false;
        }

        Database.DeleteResult[] result = Database.delete(sObjects,allOrNone);
        return result;
    }

    //Parses a map/string of DML options and creates and Apex DML object
    public static Database.DMLOptions setDMLoptions(Map<String,String> dmlOptions){
        
        //Create lowercase key value pairs map of the dml options provided
        Map<String,String> options = new Map<String,String>();
        for(String key : dmlOptions.keySet()){
            options.put(key.toLowerCase(),String.valueOf(dmlOptions.get(key)).toLowerCase());
        }

        //Instantiate a DMLOptions object
        Database.DMLOptions dmo = new database.DMLOptions();
        
        //---Set allowFieldTruncation property---
        if(options.get('allowfieldtruncation') != null){
            String fieldTrun = options.get('allowfieldtruncation');
            if(fieldTrun == 'true' || fieldTrun == '1'){
                dmo.allowFieldTruncation = true;
            }
        }

        //---Set assignmentRuleHeader property---
        if(options.get('assignmentruleheader') != null){

            //Parse assignment rule header options in to a map
            Map<String,String> ashOptions = TX_sObjectRemote.parseKeyValueString(options.get('assignmentruleheader'));

            //Set assignmentRuleId option
            if(ashOptions.get('assignmentruleid') != null){
                dmo.assignmentRuleHeader.assignmentRuleId = ashOptions.get('assignmentruleid');
            }

            //Set useDefaultRule option
            String useDefaultRule = ashOptions.get('usedefaultrule');
            if(useDefaultRule == 'true' || useDefaultRule == '1'){
                dmo.assignmentRuleHeader.useDefaultRule = true; 
            }
        }

        //---Set emailHeader property---
        if(options.get('emailheader') != null){

            //Parse assignment rule header options in to a map
            Map<String,String> emailOptions = TX_sObjectRemote.parseKeyValueString(options.get('emailheader'));

            //Set triggerAutoResponseEmail option
            String autoResponse = emailOptions.get('triggerautoresponseemail');
            if(autoResponse == 'true' || autoResponse == '1'){
                dmo.EmailHeader.triggerAutoResponseEmail = true;
            }

            //Set triggerOtherEmail option
            String triggerOtherEmail = emailOptions.get('triggerotheremail');
            if(triggerOtherEmail == 'true' || triggerOtherEmail == '1'){
                dmo.EmailHeader.triggerOtherEmail = true;
            }

            //Set triggerUserEmail option
            String triggerUserEmail = emailOptions.get('triggeruseremail');
            if(triggerUserEmail == 'true' || triggerUserEmail == '1'){
                dmo.EmailHeader.triggerUserEmail = true;
            }
        }

        //---Set localeOptions property---
        if(options.get('localeoptions') != null){
            dmo.localeOptions = options.get('localeoptions');
        }

        //---Set optAllOrNone property---
        //Default behavior for allOrNone option to true
        dmo.optAllOrNone = true;

        if(options.get('optallornone') != null){
            String optAllOrNone = options.get('optallornone');
            if(optAllOrNone == 'false' || optAllOrNone == '0'){
                dmo.optAllOrNone = false;
            }
        }

        return dmo;
    }

    public static Map<String,String> parseKeyValueString(String keyValueString){
        Map<String,String> result = new Map<String,String>();

        //Substring removes the {} on the ends and trim whitespace
        for(String s : keyValueString.substring(1,keyValueString.length() - 1).split(',')){
            List<String> keyValue = s.split('=');
            result.put(keyValue[0].trim(),keyValue[1].trim());  
        }

        return result;
    }

    //Wrapper class for a query that returns the sObject records queried and other metadata information
    public class QueryResult{
        public List<sObject> sObjects {get; set;}
        public Map<String,String> sObjectAttributes {get; set;}

        public QueryResult(){
            this.sObjects = new List<sObject>();
            this.sObjectAttributes = new Map<String,String>();
        }
    }

    private static Map<String,Schema.SObjectField> parseExternalIdFields(List<sObject> objects,Map<String,String> dmlOptions){
        Map<String,Schema.SObjectField> fieldMap = new Map<String,Schema.SObjectField>();
        if(!objects.isEmpty()){
            Map<String,String> externalIds;
            String externalId = dmlOptions.get('externalId');
            if(String.isNotBlank(externalId)){
                if(externalId.contains('=')){
                    externalIds = TX_sObjectRemote.parseKeyValueString(externalId);
                    for(String objName : externalIds.keySet()){
                        fieldMap.put(objName,getSObjectField(objName,externalIds.get(objName)));
                    }
                }
                else{
                    String objName = objects[0].getSObjectType()+'';
                    fieldMap.put(objName,getSObjectField(objName,externalIds.get(objName)));
                }
            }
        }
        return fieldMap;
    }

    private static Schema.SObjectField getSObjectField(String objName,String fieldName){
        Type ot = Type.forName(objName);
        sObject obj = (sObject)ot.newInstance();
        Schema.DescribeSObjectResult dsr = obj.getSObjectType().getDescribe();
        return dsr.fields.getMap().get(fieldName);
    }
}