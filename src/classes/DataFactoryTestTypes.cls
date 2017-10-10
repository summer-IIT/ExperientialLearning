@isTest
public without sharing class DataFactoryTestTypes {
	public static String createTestType() {
		return 'ACT';
	}
	
	public static List<String> createTestTypes(){
		List<String> testTypes = new List<String>();
		testTypes.add('ACT');
		testTypes.add('IELTS');
		testTypes.add('TOEFL');
		
		return testTypes;
	}
}