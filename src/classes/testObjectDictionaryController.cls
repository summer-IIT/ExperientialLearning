@isTest
public class testObjectDictionaryController {

    public static testMethod void testObjectDictionaryController() {
        
        PageReference pageRef = Page.objectDictionary;
        Test.setCurrentPage(pageRef);
      
        objectDictionaryController controller = new objectDictionaryController();       
        
        controller.buildObjectGroupList();
        system.assert(controller.objectGroups.size() != 0);
        
        controller.selectedObjectGroup = 'Standard Objects';
        controller.buildObjectList();
        system.assert(controller.objects.size() > 0);
        
        controller.selectedObjectGroup = 'Custom Objects';
        controller.buildObjectList();
        
        controller.selectedObjectGroup = 'Custom_Object__c';
        controller.buildObjectList();
        
        controller.displayObjects = 'Name';
        controller.selectedObjectGroup = 'Standard Objects';
        controller.buildObjectList();
        system.assert(controller.objects.size() > 0);
        
        controller.selectedObjectGroup = 'Custom Objects';
        controller.buildObjectList();
        
        controller.selectedObjectGroup = 'Custom_Object__c';
        controller.buildObjectList();
        
        controller.fieldResult();
        
        controller.selectedObject = 'Account';
        controller.selectedType = 'All';
        controller.fieldResult();
        system.assert(controller.fieldProfiles.size() > 0);
        
        controller.selectedType = 'STRING';
        controller.fieldResult();
        
        controller.selectAll = true;
        controller.selectAllFields();
        controller.generateImportTemplate();
        system.assertEquals('/apex/objectimportheader', controller.generateImportTemplate().getURL() );      
        
        controller.selectAll = false;
        controller.selectAllFields();       
        controller.generateImportTemplate();
        
        for(ApexPages.Message msg :  ApexPages.getMessages()) {
            System.assertEquals('No fields selected.', msg.getSummary());
            System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity()); 
        }

        controller.selectAll = true;
        controller.selectAllFields();
        controller.export();
        system.assertEquals('/apex/objectdictionaryexport', controller.export().getURL() );      
        
        controller.selectAll = false;
        controller.selectAllFields();       
        controller.export();
        
        for(ApexPages.Message msg :  ApexPages.getMessages()) {
            System.assertEquals('No fields selected.', msg.getSummary());
            System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity()); 
        }
        
        
        
        
    }
    }