@isTest
public without sharing class IITProgramTest {
	@isTest
	public static void testProgramTrigger() {
		// Create program objects and insert into database in order to test triggers operating on the program object
		Boolean flagged = true;
		List<IIT_Program__c> programList = DataFactoryPrograms.createAndInsertPrograms();
		
		// Iterate through the list of programs and alternate between changing the name of the program and leaving the program unchanged
		// used to test update trigger
		for(IIT_Program__c p : programList) {
			if(flagged) {
				p.IIT_Program_Name__c += '1';
				flagged = false;
			} else {
				flagged = true;
			}
		}
		
		Database.SaveResult[] updateResult = Database.update(programList, false);
		IITDatabaseTestTools.checkSuccessfulSaveResultList(updateResult);
		
		Database.DeleteResult[] deleteResult = Database.delete(programList, false);
		IITDatabaseTestTools.checkSuccessfulDeleteResultList(deleteResult);
	}
}