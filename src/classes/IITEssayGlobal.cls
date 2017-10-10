global with sharing class IITEssayGlobal {//Global wrapper class for essay handler

	webservice static String sendEssayEmail(Id essayId) {//Send an attachment email to the contact
		try {
			IITEssayHandler.sendEssayEmail(essayId);
		} catch(Exception exceptionCaught) {//Catch any errors
			IITExceptionHandler.sendExceptionEmail(exceptionCaught); //Send error messaging
			return exceptionCaught.getMessage();
		}

		return 'Email Sent.';
	}
}