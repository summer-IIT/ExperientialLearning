@isTest
public without sharing class IITDatabaseTestTools {
	public static void checkForSuccessfulSaveResult(Database.SaveResult saveResult) {
		// Test a single save result to confirm the save was successful.  If the save succeeded, then assert true
		// otherwise, if the save failed, assert false
		if(saveResult.isSuccess()) {
			System.assert(saveResult.isSuccess());
		} else {
			// The save failed
			for(Database.Error saveError : saveResult.getErrors()) {//Iterate through each error
				System.debug(saveError.getMessage()); //Display the message to the console
			}
			// indicate the test has failed due to an unexpected result (the database operation failed)
			System.assert(false);
		}
	}
	
	public static void checkForFailedSaveResult(Database.SaveResult saveResult) {
		// Test a single save result to confirm that the save failed.  If the save failed, then assert true
		// otherwise, if the save succeeded, assert false
		if(!saveResult.isSuccess()) {
			// The save failed - which this test expects
			for(Database.Error saveError : saveResult.getErrors()) {
				System.debug(saveError.getMessage());
			}
			System.assert(!saveResult.isSuccess());
		} else {
			// The save succeeded when failure was expected
			System.assert(false);
		}
	}
	
	public static void checkSuccessfulSaveResultList(Database.SaveResult[] saveResults) {//Validates if save results pass testing, otherwise displays errors
		for(Database.SaveResult saveResult : saveResults) {//Iterate through each save result.
			if(!saveResult.isSuccess()) {//Check that the save operation failed
				for(Database.Error saveError : saveResult.getErrors() ) {//Iterate through each error
					System.debug(saveError.getMessage()); //Display the message to the console
				}
				System.assert(false);
			} else {
				System.assert(saveResult.isSuccess());
			}
		}
	}
	
	public static void checkForSuccessfulDeleteResult(Database.DeleteResult deleteResult) {
		// Test a single delete result to confirm the delete was successful.  If the delete succeeded, then assert true
		// otherwise, if the save failed, assert false
		if(deleteResult.isSuccess()) {
			System.assert(deleteResult.isSuccess());
		} else {
			// The save failed
			for(Database.Error saveError : deleteResult.getErrors()) {//Iterate through each error
				System.debug(saveError.getMessage()); //Display the message to the console
			}
			// indicate the test has failed
			System.assert(false);
		}
	}
	
	public static void checkForFailedDeleteResult(Database.DeleteResult deleteResult) {
		// Test a single delete result to confirm that the delete failed.  If the delete failed, then assert true
		// otherwise, if the delete succeeded, assert false
		if(!deleteResult.isSuccess()) {
			// The delete failed - which this test expects
			for(Database.Error saveError : deleteResult.getErrors()) {
				System.debug(saveError.getMessage());
			}
			System.assert(!deleteResult.isSuccess());
		} else {
			// The delete succeeded when failure was expected
			System.assert(false);
		}
	}
	
	public static void checkSuccessfulDeleteResultList(Database.DeleteResult[] deleteResults) {//Validates if save results pass testing, otherwise displays errors
		for(Database.DeleteResult deleteResult : deleteResults) {//Iterate through each save result.
			if(!deleteResult.isSuccess()) {//Check that the save operation failed
				for(Database.Error deleteError :deleteResult.getErrors() ) {//Iterate through each error
					System.debug(deleteError.getMessage()); //Display the message to the console
				}
				System.assert(false);
			} else {
				System.assert(deleteResult.isSuccess());
			}
		}
	}
}