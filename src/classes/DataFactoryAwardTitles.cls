@isTest
public without sharing class DataFactoryAwardTitles {
	public static String createAwardTitle() {
		// create a single award title
		return 'Heald';	
	}
	
	public static List<String> createAwardTitlesList() {
		// create a list of available award titles
		List<String> awardTitles = new List<String>();
		
		awardTitles.add('Heald');
		awardTitles.add('Loan');
		awardTitles.add('Stipend');
		
		return awardTitles;
	}
}