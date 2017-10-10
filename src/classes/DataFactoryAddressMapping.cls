@isTest
public without sharing class DataFactoryAddressMapping {
	public static IITAddressMapping__c createAddressMapping() {
		// creates a single address mapping object
		IITAddressMapping__c addressMapping = new IITAddressMapping__c(
			Name = 'Permanent Address',
			Address_Type__c = 'Permanent',
			Street_API_Name__c = 'MailingStreet',
			City_API_Name__c = 'MailingCity',
			State_API_Name__c = 'MailingState',
			Postal_Code_API_Name__c = 'MailingPostalCode',
			Country_API_Name__c = 'MailingCountry',
			County_API_Name__c = 'TargetX_SRMb__MailingCounty__c',
			Activity_Date_API_Name__c = 'IIT_Mailing_Address_Date__c'
		);
		
		return addressMapping;
	}
}