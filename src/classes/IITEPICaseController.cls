public class IITEPICaseController {
    
    public Case c {get; set;}
    
    public String ctEmail {get; set;}
    
    public IITEPICaseController() {
            c = new Case();
    }
    
    public PageReference submitCase() {
        List<Contact> ct = [SELECT Id FROM Contact WHERE Email = :ctEmail and RecordTypeId='012j00000010JL7']; //ProductionID
        //List<Contact> ct = [SELECT Id FROM Contact WHERE Email = :ctEmail and RecordTypeId='0127A0000000EMp']; //TestID
        if (ct.size() != 1) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.FATAL, 'Invalid email address or more than one record returned');
            ApexPages.addMessage(msg);
            return null;
        } else {
            try {
                c.ContactId = ct.get(0).Id;
                c.Status = 'New';
                c.Origin = 'Web';
                
                // Specify DML options to ensure the assignment rules are executed
                Database.DMLOptions dmlOpts = new Database.DMLOptions();
                dmlOpts.assignmentRuleHeader.useDefaultRule = true;
                c.setOptions(dmlOpts);
                
                //Insert the case
                INSERT c;
                return new PageReference('/home/home.jsp');
                
            } catch (Exception e) {
                ApexPages.addMessages(e);
                return null;
            }
        }
    }
    
}