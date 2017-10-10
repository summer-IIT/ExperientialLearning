public with sharing class addressPlusContactZipLookup {
	public static void zipLookup(List<Contact> newContacts, Map<Id,Contact> oldMap){
		//Id rmsRecordTypeId = [SELECT Id FROM RecordType WHERE Name = 'Recruitment Manager Student' AND SObjectType = 'Contact' LIMIT 1].Id;
		Set<string> zipCodes = new Set<string>();
		
		List<Contact> contactsToUpdate = new List<Contact>();
		
		Map<string,AddressPlus__c> zipMap = new Map<string,AddressPlus__c>();
		
		//create a set of zip codes for the list of contacts being evaluated and add involved contacts to update list
		for(contact c : newContacts) {
			Pattern us = Pattern.compile('United States( of America)?|U[.]?S[.]?(A[.]?)?') ;

			if(c.MailingPostalCode != NULL
				//&& c.RecordTypeId == rmsRecordTypeId
				&& c.MailingPostalCode.length() >= 5
				&& (c.MailingCountry == NULL || 
					us.matcher(c.MailingCountry).matches())) {

				zipCodes.add(c.MailingPostalCode.substring(0,5));
				contactsToUpdate.add(c);
			}
		}
		
		//create zip code map to use as lookup for zip values
		for(AddressPlus__c z : [SELECT Zip_Code__c,City__c,State__c,EPS_Code__c,County__c
								FROM AddressPlus__c WHERE Zip_Code__c in :zipCodes]){
			zipMap.put(z.Zip_Code__c, z);
		}
		
		//iterate through the list of contacts to update and assign the corresponding zip code values
		for(contact c : contactsToUpdate) {
			AddressPlus__c zip = zipMap.get(c.MailingPostalCode.substring(0,5));
			
			// If we find our zip in the list
			if(zip != null) {
				Contact oldC = oldMap.get(c.Id) ;

				if(oldC == null || oldC.MailingPostalCode != c.MailingPostalCode) {
					// If our zip changes, or I'm a new record, fill in all the things
					c.MailingCity = zip.City__c ;
					c.MailingState = zip.State__c ;
					c.TargetX_SRMb__MailingCounty__c = zip.County__c ;
					c.TargetX_SRMb__EPS_Code__c = zip.EPS_Code__c ;
				}
			}
		}
	}
}