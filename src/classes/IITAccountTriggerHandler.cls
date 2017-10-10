public without sharing class IITAccountTriggerHandler extends IITTriggerHandler {//Trigger handler to handle single IIT account trigger in all cases

	private List<Account> newAccountList; //Strongly typed account list from Trigger.new
	private Map<Id,Account> oldAccountMap; //Strongly typed account map from Trigger.oldMap

	public IITAccountTriggerHandler() {
		this.newAccountList = (List<Account>)Trigger.new; //Strongly type the account list in Trigger.new to Account from SObject
		this.oldAccountMap = (Map<Id,Account>)Trigger.oldMap; //Strongly type the account map in Trigger.oldMap to Account from SObject
	}

	public override void afterInsert() {
    	TargetX_Group.RoundRobin txRoundRobin = new TargetX_Group.RoundRobin('Account'); //Create roundrobin assignment group
    	txRoundRobin.assign(this.newAccountList); //Process group assignment
	}

	public override void afterUpdate(){
    	TargetX_Group.RoundRobin txRoundRobin = new TargetX_Group.RoundRobin('Account');
    	//  getRelevantRecords() returns only records whose group assignment changed
        txRoundRobin.assign(txRoundRobin.getRelevantRecords(trigger.oldMap, trigger.newMap));
    }

	public override void beforeInsert() {
		addressPlusAccountZipLookup.zipLookup(this.newAccountList, new Map<Id, Account>()) ;
	}

	public override void beforeUpdate() {
		addressPlusAccountZipLookup.zipLookup(this.newAccountList, this.oldAccountMap) ;
	}
}