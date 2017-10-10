public with sharing class IITAttachmentCopyController {

    public string idOld {get; set;}
    public string idNew {get; set;}
    
    public IITAttachmentCopyController() {
        
    }
    
    public PageReference copyDoc() {
        List<Attachment> attList = [select id, name, body from Attachment where ParentId = :idOld];
        
        if(attList.size() > 0) {
            try {
                List<Attachment> insertAttList = new List<Attachment>();
                for(Attachment a : attList) {
                    Attachment att = new Attachment(name = a.name, body = a.body, parentId = idNew);
                    insertAttList.add(att);
                }
                insert insertAttList;
                return new PageReference('javascript:window.self.close()');
            } catch (Exception e) {
                ApexPages.addMessages(e);
                return null;
            }            
        } else {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.FATAL, 'No attachments to copy!');
            ApexPages.addMessage(msg);
            return null;
        }
    }
    
}