@isTest
public without sharing class DataFactoryPhoneMapping {
	public static IITPhoneMapping__c createPrimaryPhoneMapping() {
		// create a single primary phone mapping object
		IITPhoneMapping__c phoneMapping = new IITPhoneMapping__c(
			Name = 'Primary Phone',
			Phone_Number_API_Name__c = 'Phone'
		);
		
		return phoneMapping;
	}
	
	public static IITPhoneMapping__c createSecondaryPhoneMapping() {
		// create a single secondary phone mapping object
		IITPhoneMapping__c phoneMapping = new IITPhoneMapping__c(
			Name = 'Secondary Phone',
			Phone_Number_API_Name__c = 'OtherPhone'
		);
		
		return phoneMapping;
	}
	
	public static List<IITPhoneMapping__c> createPhoneMappingsList() {
		// create a list containing all phone mappings
		List<IITPhoneMapping__c> phoneMappings = new List<IITPhoneMapping__c>();
		
		phoneMappings.add(DataFactoryPhoneMapping.createPrimaryPhoneMapping());
		phoneMappings.add(DataFactoryPhoneMapping.createSecondaryPhoneMapping());
		
		return phoneMappings;
	}
}