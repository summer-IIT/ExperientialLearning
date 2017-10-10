@isTest
public without sharing class DataFactoryAwardStatusTypes {
	public static String createAwardStatusType() {
		// create a single award status type
		return 'Awarded';
	}
	
	public static List<String> createAwardStatusTypesList() {
		// create a list of award status types
		List<String> awardStatusTypes = new List<String>();
		
		awardStatusTypes.add('Awarded');
		awardStatusTypes.add('Cancelled');
		awardStatusTypes.add('Upgraded');
		
		return awardStatusTypes;
	}
}