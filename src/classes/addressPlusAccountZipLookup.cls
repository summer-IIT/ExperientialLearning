public with sharing class addressPlusAccountZipLookup {
	public static void zipLookup(List<Account> newAccounts, Map<Id,Account> oldMap){

		Set<string> zipCodes = new Set<string>();
		
		List<Account> accountsToUpdate = new List<Account>();
		
		Map<string,AddressPlus__c> zipMap = new Map<string,AddressPlus__c>();
		
		//create a set of zip codes for the list of accounts being evaluated and add involved accounts to update list
		for(account a : newAccounts) {
			Pattern us = Pattern.compile('United States( of America)?|U[.]?S[.]?(A[.]?)?') ;

			if(a.BillingPostalCode != NULL

				&& a.BillingPostalCode.length() >= 5
				&& (a.BillingCountry == NULL || 
					us.matcher(a.BillingCountry).matches())) {

				zipCodes.add(a.BillingPostalCode.substring(0,5));
				accountsToUpdate.add(a);
			}
		}
		
		//create zip code map to use as lookup for zip values
		for(AddressPlus__c z : [SELECT Zip_Code__c,City__c,State__c,EPS_Code__c,County__c
								FROM AddressPlus__c WHERE Zip_Code__c in :zipCodes]){
			zipMap.put(z.Zip_Code__c, z);
		}
		
		//iterate through the list of accounts to update and assign the corresponding zip code values
		for(account a : accountsToUpdate) {
			AddressPlus__c zip = zipMap.get(a.BillingPostalCode.substring(0,5));
			
			// If we find our zip in the list
			if(zip != null) {
				Account oldA = oldMap.get(a.Id) ;

				if(oldA == null || oldA.BillingPostalCode != a.BillingPostalCode) {
					// If our zip changes, or I'm a new record, fill in all the things
					a.BillingCity = zip.City__c ;
					a.BillingState = zip.State__c ;
					a.TargetX_SRMb__BillingCounty__c = zip.County__c ;
					a.TargetX_SRMb__EPS_Code__c = zip.EPS_Code__c ;
				}
			}
		}
	}
}