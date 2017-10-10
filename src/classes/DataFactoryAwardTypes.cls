@isTest
public without sharing class DataFactoryAwardTypes {
	public static String createAwardType() {
		// create a single award type
		return 'Merit';
	}
	
	public static List<String> createAwardTypesList() {
		// create a list containing award types
		List<String> awardTypes = new List<String>();
		
		awardTypes.add('Merit');
		awardTypes.add('Loans');
		awardTypes.add('Grants');
		awardTypes.add('Stipend');
		awardTypes.add('Athletic');
		awardTypes.add('Tuition');
		
		return awardTypes;
	}
}