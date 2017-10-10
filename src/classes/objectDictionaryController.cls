public class objectDictionaryController{
    
    public List<Schema.sObjectType> objectSchema {get; set;}
    public Set<String> namespaces {get; set;}
    public String displayObjects {get; set;}
    public string selectedObjectGroup {get; set;}
    public string selectedObject {get; set;}
    public List<String> fieldsToDisplay{get; set;}
    public List<SelectOption> types {get; set;}
    public String selectedType {get; set;}
    public List<fieldProfile> fieldProfiles {get; set;}
    public List<SelectOption> objectGroups {get; set;}
    public List<SelectOption> objects {get; set;}
    public boolean selectAll {get; set;}
    public List<fieldProfile> selectedFields {get; set;}
    public string headerRow {get; set;}
    //public Map<String,Data_Mapping__c> dataMappingMap {get; set;}
    
    public objectDictionaryController(){
        objectSchema = Schema.getGlobalDescribe().Values();
        namespaces = new Set<String>();
        objects = new List<SelectOption>();
        displayObjects = 'Label';
        fieldsToDisplay = new List<String>();

        for(Schema.sObjectType obj : objectSchema){
            if(string.valueOf(obj).countMatches('__')==2){
                namespaces.add(
                    string.valueOf(obj).substring(0, string.valueOf(obj).indexOf('__'))
                );
            }
        }
        buildObjectGroupList();
        
        types = new List<SelectOption>{
                        new SelectOption('',''),
                        new SelectOption('ALL','All'),
                        new SelectOption('BOOLEAN','Boolean'),
                        new SelectOption('COMBOBOX','ComboBox'),
                        new SelectOption('CURRENCY','Currency'),
                        new SelectOption('DATACATEGORYGROUPREFERENCE','DataCategoryGroupReference'),
                        new SelectOption('DATE','Date'),
                        new SelectOption('DATETIME','DateTime'),
                        new SelectOption('DOUBLE','Double'),
                        new SelectOption('EMAIL','Email'),
                        new SelectOption('ENCRYPTEDSTRING','EncryptedString'),
                        new SelectOption('ID','Id'),
                        new SelectOption('INTEGER','Integer'),
                        new SelectOption('MULTIPICKLIST','MultiPicklist'),
                        new SelectOption('PERCENT','Percent'),
                        new SelectOption('PHONE','Phone'),
                        new SelectOption('PICKLIST','Picklist'),
                        new SelectOption('REFERENCE','Reference'),
                        new SelectOption('STRING','String'),
                        new SelectOption('TEXTAREA','TextArea'),
                        new SelectOption('TIME','Time'),
                        new SelectOption('URL','URL')
                    };        
    }
    
    public List<SelectOption> buildObjectGroupList(){
        objectGroups = new List<SelectOption>{new selectOption('',''),new selectOption('Standard Objects','Standard Objects'),new selectOption('Custom Objects','Custom Objects')};
        for(String ns : namespaces){
            objectGroups.add(new selectOption(ns,ns));
        }
        objectGroups = SortSelectOptions.selectOptionSortByLabel(objectGroups);
        return objectGroups;
    }
    
    public pageReference buildObjectList(){
        selectedType = '';
        objects = new List<SelectOption>();
        if(selectedObjectGroup != '' && selectedObjectGroup != NULL){
            if(selectedObjectGroup == 'Standard Objects'){
                for(Schema.sObjectType obj : objectSchema){
                    if(!string.valueOf(obj).contains('__')){
                        if(displayObjects == 'Label') {
                            objects.add(new SelectOption(string.valueOf(obj), obj.getDescribe().getLabel() ) );
                        } else if (displayObjects == 'Name') {
                            objects.add(new SelectOption(string.valueOf(obj), string.valueOf(obj) ) );
                        }
                    } 
                }
            } else if(selectedObjectGroup == 'Custom Objects'){
                for(Schema.sObjectType obj : objectSchema){
                    if(string.valueOf(obj).countMatches('__') == 1){
                        if(displayObjects == 'Label') {
                            objects.add(new SelectOption(string.valueOf(obj), obj.getDescribe().getLabel() ) );
                        } else if (displayObjects == 'Name') {
                            objects.add(new SelectOption(string.valueOf(obj), string.valueOf(obj) ) );
                        }
                    } 
                }
            } else {
                for(Schema.sObjectType obj : objectSchema){
                    if(string.valueOf(obj).startsWith(selectedObjectGroup)){
                        if(displayObjects == 'Label') {
                            objects.add(new SelectOption(string.valueOf(obj), obj.getDescribe().getLabel() ) );
                        } else if (displayObjects == 'Name') {
                            objects.add(new SelectOption(string.valueOf(obj), string.valueOf(obj) ) );
                        }
                    } 
                }
            }
        }
        objects.add(new SelectOption('',''));
        objects = SortSelectOptions.selectOptionSortByLabel(objects);
        return null;
    
    }
    
    public PageReference fieldResult() {
                    
                    if(selectedObject != NULL && selectedType != NULL) {
                        //getMappings();
                        selectAll = false;
                        Map<String, Schema.SObjectField> fieldMap = (Schema.getGlobalDescribe().get(string.valueOf(selectedObject))).getDescribe().fields.getMap();
                        fieldsToDisplay = new List<String>();
                        fieldProfiles = new List<fieldProfile>();
                        
                        for (string fld : fieldMap.keySet()) {    
                                if(string.valueOf(fieldMap.get(fld).getDescribe().getType() ) == selectedType) {
                                    fieldsToDisplay.add(fld);
                                } else if(selectedType == 'ALL' || selectedType == '') {
                                    fieldsToDisplay.add(fld);
                                }
                        }

                            for (string fieldName : fieldsToDisplay ) {
                                Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fieldName).getDescribe();
                                
                                fieldProfile fp = new fieldProfile();
                                    fp.apiName=fieldName;
                                    fp.label=fieldDescribe.getLabel();
                                    fp.Type=string.valueOf(fieldDescribe.getType());
                                    fp.isExternalId=fieldDescribe.isExternalId();
                                    fp.length=fieldDescribe.getLength();
                                    fp.isFormula=fieldDescribe.isCalculated();
                                    fp.isUnique=fieldDescribe.isUnique();
                                    fp.picklistValues=new List<String>();                                   
                                    fp.isUpdateable=fieldDescribe.isUpdateable();
                                    //fp.dataMapping=dataMappingMap.get(fieldName);

                                List<String> picklistEntries = new List<String>();
                                
                                if(fp.Type == 'PICKLIST' || fp.Type == 'MULTIPICKLIST') {
                                    List<Schema.PicklistEntry> picklistValues = fieldDescribe.getPicklistValues();
                                    for(Schema.PicklistEntry ple : picklistValues) {
                                        picklistEntries.add(ple.getLabel() );
                                    }
                                    fp.picklistValues = picklistEntries;
                                
                                } else if(fp.Type == 'REFERENCE') {
                                    fp.Reference = string.valueOf(fieldDescribe.getReferenceTo());
                                    
                                } else if(fp.Type == 'DOUBLE') {
                                    fp.Precision = fieldDescribe.getPrecision();
                                } else {

                                    
                                }
                                

                                fieldProfiles.add(fp);
                                }

                        }

                    return null;
                        
                    }
    
    //public void getMappings(){
        //List<Data_Mapping__c> dataMappings = new List<Data_Mapping__c>([SELECT Id, Name, Salesforce_Field_API_Name__c, External_System_Field__c, Mapping_Instructions__c FROM Data_Mapping__c WHERE Salesforce_Object__c = :selectedObject]);
        //dataMappingMap = new Map<String, Data_Mapping__c>();
        //for(Data_Mapping__c dm : dataMappings){
        //    dataMappingMap.put(dm.Salesforce_Field_API_Name__c, dm);
        //}
    //}                
    
    public pageReference updateSelectedFieldList(){
    
        selectedFields = new List<fieldProfile>();
        for(fieldProfile fp : fieldProfiles){
            if(fp.isSelected){selectedFields.add(fp);}
        }
        if(selectedFields.size() == 0){
            selectAll = false;
            } 
    
    return null;
    }
    
    public pageReference selectAllFields(){
        selectedFields = new List<fieldProfile>();
        for(fieldProfile fp : fieldProfiles){
            if(selectAll){
                fp.isSelected = true;
                selectedFields.add(fp);
                } else {
                fp.isSelected = false;
                }
            
        } 
    
    return null;
    }
    
    public pageReference generateImportTemplate(){
        updateSelectedFieldList();
        
        if(selectedFields.size() == 0){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No fields selected.'));
        return null;
        } else {
        headerRow = '';
        for(fieldProfile fp : selectedFields){
            headerRow += fp.apiName + ',';
        }
        return Page.objectImportHeader;
        }
    }
    
    public class fieldProfile{
        public string apiName {get; set;}
        public string label {get; set;}
        public string Type {get; set;}
        public List<string> picklistValues {get; set;}
        public boolean isExternalId {get; set;}
        public integer Length {get; set;}
        public string Reference {get; set;}
        public boolean isFormula {get; set;}
        public integer Precision {get; set;}
        public boolean isUnique {get; set;}
        public boolean isUpdateable {get; set;}
        public boolean isSelected {get; set;}
        //public Data_Mapping__c dataMapping {get; set;}
        
        public fieldProfile(){
            Reference='';
            Precision=0;
            //dataMapping=new Data_Mapping__c();
        }

    }
    
    public PageReference export() {
            updateSelectedFieldList();
            if(selectedFields.size() == 0){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No fields selected.'));
                return null;
            } else {
            return Page.objectDictionaryExport;
            }
        }

}