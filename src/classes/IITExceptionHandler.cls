public without sharing class IITExceptionHandler { //Handles IIT exceptions

	@TestVisible
	private static Boolean sendEmailInTest;

static {
	sendEmailInTest = false;
}

	public static void forceException() {//Forces exceptions to fire for testing purposes
		if(Test.isRunningtest() ) {
			throw new IITGenericException('Forced Exception in Test');
		}
	}

	public static void sendExceptionEmail (Exception exceptionToReport) {//Wrapper class for emails without any additional functionality
		IITExceptionHandler.sendDetailedExceptionEmail(exceptionToReport, '');
	}
	public static void sendDetailedExceptionEmail (Exception exceptionToReport, String additionalMessage) {
	
		if(Test.isRunningtest() == false
		|| IITExceptionHandler.sendEmailInTest
		)
		{
			string[] adminEmails = new string[]{'studentsystem-group@iit.edu'};
			List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
			Messaging.SingleEmailMessage emailToSend = new Messaging.SingleEmailMessage();
			emailToSend.setToAddresses(adminEmails);
			emailToSend.setReplyTo('studentsystem-group@iit.edu');
			emailToSend.setSaveAsActivity(false);
			emailToSend.setSubject('IIT Exception Handler: ' + exceptionToReport.getTypeName());
			emailToSend.setHtmlBody('<HTML><HEAD>'
				+ 'IIT Exception Handler: '
				+ exceptionToReport.getTypeName()
				+ '</HEAD><BODY><P>This message is an automated message sent from the user that triggered the exception:<BR />Exception <B>'
				+ exceptionToReport.getTypeName()
				+ '</B> fired in salesforce as follows:<BR />'
				+ exceptionToReport.getMessage()
				+ '<BR /></P><P>Stack Trace:<BR/>'
				+ exceptionToReport.getStackTraceString()
				+ additionalMessage
				+'</BODY></HTML>'
			);
			emailsToSend.add(emailToSend);
			Messaging.sendEmail(emailsToSend,false);
		}
	}

	public static void sendDMLExceptionEmail(DmlException dmlExceptionToReport) {//Composes a dml exception
		String fullMessage = '<BR/><BR/><P>DML Details:'
		+ '<BR/>Number of Failed Rows: ' + String.valueOf(dmlExceptionToReport.getNumDml()) + '</P>';//Initialize a message string.

		for(Integer i = 0; i < dmlExceptionToReport.getNumDml(); i++) {//Iterate through every failed row
			String dmlId = (dmlExceptionToReport.getDmlId(i) == null ? 'NULLID' : String.valueOf(dmlExceptionToReport.getDmlId(i)));//Get the id of the exception, check for null

			fullMessage += '<BR/><P>Record <A HREF="' /*Create the hyperlink to the id for easy fixing*/
			+ System.URL.getSalesforceBaseURL().toExternalForm()
			+ dmlId
			+ '">'
			+ dmlId
			+ '</A> failed with status code <b>'
			+ String.valueOf(dmlExceptionToReport.getDmlType(i)) /*Get the reason for the row*/
			+ '</B> on fields <B>'
			+ String.join(dmlExceptionToReport.getDmlFieldNames(i), ';') /*Get the fields that errored out*/
			+ '</B></P>';
		}

		IITExceptionHandler.sendDetailedExceptionEmail(dmlExceptionToReport,fullMessage);//Send that email out
	}
}