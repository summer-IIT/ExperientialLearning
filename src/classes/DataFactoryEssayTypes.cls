@isTest
public without sharing class DataFactoryEssayTypes {
	public static String createEssayType() {
		String essayType = 'Personal Statement';
		
		return essayType;
	}
	
	public static List<String> createEssayTypesList() {
		List<String> essayTypes = new List<String>();
		essayTypes.add('Personal Statement');
		essayTypes.add('Professional Statement');
		essayTypes.add('Resume');
		
		return essayTypes;
	}
}