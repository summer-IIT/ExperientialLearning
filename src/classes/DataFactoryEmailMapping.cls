@isTest
public without sharing class DataFactoryEmailMapping {
	public static IITEmailMapping__c createEmailMapping() {
		IITEmailMapping__c emailMapping = new IITEmailMapping__c(
			Name = 'Primary Email',
			Email_Address_API_Name__c = 'Email'
		);
		
		return emailMapping;
	}
}