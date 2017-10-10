global class IITBatchReplace implements Database.Batchable<sObject>{
/*Code based on https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_batch_interface.htm
I call this MattImpact.
Replaces a field with a specified value for a ton of records.
Invoke with Id batchInstanceId = Database.executeBatch(new IITBatchReplace(query,entity,field,value,valuetype), BATCHSIZE);
*/
	global final String Query; //The SOQL query to run. Exclude []
	global final String Entity; //The object to run the search on by API name
	global final String Field; //The field to update.
	global final String Value; //The value to update the field to
	global final String ValueType; //The type of the value;
	
	global IITBatchReplace(String query_i, String entity_i, String field_i, String value_i, String valueType_i) {//Constructor method
		Query = query_i;
		Entity = entity_i;
		Field = field_i;
		Value = value_i;
		ValueType = valueType_i;
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC){//Runs when the Batch Job starts
		return Database.getQueryLocator(query);
	}
	
	global void execute(Database.BatchableContext BC, List<sobject> scope) {//Actually executes the batch job
		for(sobject sObjectToUpdate : scope) {//For every object in the scope
			if(ValueType == 'String'
			|| Value == null
			) {
				sObjectToUpdate.put(Field,Value);
			} else if(ValueType == 'Id') {
				sObjectToUpdate.put(Field,Id.valueOf(Value));
			} else if(ValueType == 'Boolean') {
				sObjectToUpdate.put(Field,(Value == 'TRUE'));
			}
		}
		Database.SaveResult[] saveResults = Database.Update(scope);
	}
	
	global void finish(Database.BatchableContext BC) {//Fires when the batch job finishes.
		List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
		Messaging.SingleEmailMessage mailToSend = new Messaging.SingleEmailMessage();
		mailToSend.SetToAddresses(new String[] {'studentsystem-group@iit.edu'});
		mailToSend.setReplyTo('studentsystem-group@iit.edu');
		mailToSend.setSenderDisplayName('IIT Salesforce Core Batch');
		mailToSend.SetSubject('Batch Process on ' + Entity + ' Completed');
		mailToSend.setPlainTextBody('Batch process on ' + Entity + ' has completed.'
		+ '\nSetting ' + Field + ' to: ' + (Value == null ? 'NULL' : Value)
		+ '\nUsing Query: ' + Query);
		emailsToSend.Add(mailToSend);
		Messaging.sendEmail(emailsToSend,false);
	}
}