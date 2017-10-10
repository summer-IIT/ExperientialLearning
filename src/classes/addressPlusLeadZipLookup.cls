public with sharing class addressPlusLeadZipLookup {
	public static void zipLookup(List<Lead> newLeads, Map<Id, Lead> oldMap){

		Set<string> zipCodes = new Set<string>();
		
		List<Lead> leadsToUpdate = new List<Lead>();
		
		Map<string,AddressPlus__c> zipMap = new Map<string,AddressPlus__c>();
		
		//create a set of zip codes for the list of leads being evaluated and add involved leads to update list
		for(Lead l : newLeads) {
			Pattern us = Pattern.compile('United States( of America)?|U[.]?S[.]?(A[.]?)?') ;

			if(l.PostalCode != NULL

				&& l.PostalCode.length() >= 5
				&& (l.Country == NULL || 
					us.matcher(l.Country).matches())) {

				zipCodes.add(l.PostalCode.substring(0,5));
				leadsToUpdate.add(l);
			}
		}
		
		//create zip code map to use as lookup for zip values
		for(AddressPlus__c z : [SELECT Zip_Code__c,City__c,State__c,EPS_Code__c,County__c
								FROM AddressPlus__c WHERE Zip_Code__c in :zipCodes]){
			zipMap.put(z.Zip_Code__c, z);
		}
		
		//iterate through the list of leads to update and assign the corresponding zip code values
		for(Lead l : leadsToUpdate) {
			AddressPlus__c zip = zipMap.get(l.PostalCode.substring(0,5));
			
			// If we find our zip in the list
			if(zip != null) {
				Lead oldL = oldMap.get(l.Id) ;

				if(oldL == null || oldL.PostalCode != l.PostalCode) {
					// If our zip changes, or I'm a new record, fill in all the things
					l.City = zip.City__c ;
					l.State = zip.State__c ;
					l.TargetX_SRMb__County__c = zip.County__c ;
					l.TargetX_SRMb__EPS_Code__c = zip.EPS_Code__c ;
				}
			}
		}
	}
}