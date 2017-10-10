/**

Last update 2010-07-15
labs@salesforce.com

* with sharing added
* squashed bugs around single / multiple updates
* added limits to SOQL -- 100 for Campaigns 1000 for Campaign Members
* fixed custom settings manager
* updated Static Resources 

*/
public with sharing class TelemarketingController{
    
    //setup appropriate variables
    private Boolean             hasCampaignID = false;
    private string              thisCampaign;
    private Lead[]              lead; 
    private Contact[]           contact;
    private CampaignMember[]    members; //the members for that campaign
    private Lead[]              relevantLeads; 
    private List<leadPlusTaskPlusContact>   leadPlusTasks;
    private Map<String, Boolean>            callDownColumns;    
    private List<Campaign>      activeCampaigns;
    public String               camp { get;set; } //campaign ID
    public String               status{ get;set; } //status ID
    public Integer               counter{ get;set; } // counter
    public Integer              fullCount{ get;set; }
    private Map<String, String> cStatusMap;
    private boolean             cStatusMapIsSet;
    public string               campBackup;
    public string               backRef{ get; set; }
    public list<SelectOption>   owners;
    public string               ownerId{ get; set; }
    public Integer              assignedToCounter{ get; set;}
    public Integer              noAnswerCounter{ get; set;}
    public Integer              CallLimit {get; set;}
    public Integer              NumberOfCalls{get; set;}
    public Integer              Calls{get; set;}

    
    /**
    *Constructor
    */
    public TelemarketingController(){
        counter=0;
        fullCount=0;
        relevantLeads = new Lead[ 0 ];
        leadPlusTasks = new leadPlusTaskPlusContact[]{};
        callDownColumns = new Map<String, Boolean>();
        
        //get columns settings and set to Map
        if( ApexPages.currentPage().getUrl() != null ){
            camp = ApexPages.currentPage().getUrl().substring( 1 );
        }
        campBackup = camp;
        backRef = '/apex/TelemarketingSettings?var=/' + camp;
        cStatusMap = new Map<String, String>();
        cStatusMapIsSet = false;
        owners = new list<SelectOption>();
    }
    
    /**
    *Return if has campaign id
    *@return hasCampaignID boolean flag
    */
    public Boolean gethasCampaignID(){
        return hasCampaignID;
    }
    
    /**
    *Return the list of owners
    *@return owners
    */
    public List<SelectOption> getowners(){
        return owners;
    }
    
    public void setowners( List<SelectOption> l ){
        owners = l;
    }
    
    /**
    *Update all status and log , retuen page reference for redirection
    *@return null
    */
    public PageReference updateAll()
    {
        transient boolean needToRefresh;
        List<leadPlusTaskPlusContact> cleanRecords = new List<leadPlusTaskPlusContact>();
        for( leadPlusTaskPlusContact current :leadPlusTasks )
        {
            //status
            
            boolean updated = false;
            if(current.statusUpdate != 'None' && current.statusUpdate != 'No Answer')
            {
                //update status
                CampaignMember cm = [Select Id, Status From CampaignMember Where id = :current.MemberId limit 1];
                cm.status = current.statusUpdate;
                cm.AssignedDate__c = null;
                cm.AssignedTo__c = null;
                update cm;
                updated = true;
                needToRefresh = true;
            }
            

            if( current.statusUpdate == 'Had Conversation' || current.statusUpdate == 'Left Message'){
                //  Set task status to completed, to force isClosed to check
                current.t.Status = 'Completed';
                insert current.t;
                current.t.Status = current.statusUpdate;
                update current.t;
            }
            
            
            if (updated && current.statusUpdate != 'No Answer' )
            {
                //log a call
                current.t.Subject = 'Call--Campaign: '+this.getCampaignName();
                upsert current.t;
                updated = true;
                needToRefresh = true;  
            }
            
            
               
        if ( current.statusUpdate == 'No Answer' )
            {
               Campaign campaignObject = new Campaign();
               campaignObject = [SELECT id,Callbacks__c FROM Campaign WHERE Id= :camp LIMIT 1];
               String Callbacks = campaignObject.Callbacks__c;      
               CampaignMember m = [Select Id, Failed_Calls__c From CampaignMember Where id = :current.MemberId limit 1];
               NumberOfCalls = Integer.ValueOf(m.Failed_Calls__c);
               NumberOfCalls++;
                
               CampaignMember cm = [Select Id, Status From CampaignMember Where id = :current.MemberId limit 1];
               cm.status = current.statusUpdate;
               cm.AssignedDate__c = null;
               cm.AssignedTo__c = null;
               
               if (Callbacks == 'Never Callback' || Callbacks == null ) 
               {  
                cm.status = 'Never Answered';
                current.t.Subject = 'Call--Campaign: '+this.getCampaignName();
                upsert current.t;
                current.t.Status = 'Completed';
                upsert current.t;
                current.t.Status = 'Never Answered';
                update current.t;
               }                                      
                                 
               else {
                          
                           string call = Callbacks.substring(0,2).trim();
                           integer CallLimit = Integer.ValueOf(call); 
                           CallLimit++;
                           if ( NumberOfCalls == CallLimit ){// if at max callbacks
                            cm.status = 'Never Answered';
                            current.t.Subject = 'Call--Campaign: '+this.getCampaignName();
                            upsert current.t;
                            current.t.Status = 'Completed';
                            upsert current.t;
                            current.t.Status = 'Never Answered';
                            update current.t;
                            
                            }
                            else{
                            cm.status = 'No Answer';
                            current.t.Subject = 'Call--Campaign: '+this.getCampaignName();
                            upsert current.t;
                            current.t.Status = 'Completed';
                            upsert current.t;
                            current.t.Status = 'No Answer';
                            update current.t;
                    
                            } 
                        }
                        cm.Failed_Calls__c = NumberOfCalls;
                        update cm;
                        updated = true;
                        needToRefresh = true;
                            
                        
                     
               
        }    
                
            if (!updated)
            {
                cleanRecords.add(current);
            }
        }
        leadPlusTasks = cleanRecords;
        if(needToRefresh==true)
        {
            campaignRefresh();
            needToRefresh=false;
        }
        return null;
    }
    
    public void contactCounter()
    {
        if ( camp != null && camp.length( ) >3 ){
            //set some variable values
            hasCampaignID = true;           
            counter = [
                SELECT count() 
                FROM CampaignMember 
                WHERE AssignedDate__c = null 
                AND CampaignId = :camp 
                AND HasResponded=false
            ];
            fullCount = [
                SELECT count()
                FROM CampaignMember 
                WHERE CampaignId = :camp
            ];
        }
        else
        {
            counter = 0;
            fullCount = 0;         
        }
            
     }
            
   
    
    /**
    *Refresh campaign list
    *@return page reference
    */
    public PageReference campaignRefresh(){
        contactCounter();
        Map<String, String>ownerMap = new Map<String, String>();
        relevantLeads.clear(); leadPlusTasks.clear(); 
        cStatusMapIsSet = false;
        checkForExpiredAssignments();
        assignedToCounter = [
                SELECT count() 
                FROM CampaignMember 
                WHERE AssignedTo__c = :UserInfo.getUserId()
                AND CampaignId = :camp 
                AND HasResponded=false AND Status != 'No Answer'
            ];
     
        if ( camp != null && camp.length( ) >3 ){
            //set some variable values
            hasCampaignID = true;           
            try{
            if( assignedToCounter > 0){
               members = [select Id, ContactId, LeadId, Status, CampaignId, Campaign.Name,
                    Lead.Id, Lead.Salutation, Lead.Title, Lead.Name, Lead.Company, Lead.Phone, 
                    Lead.Street, Lead.State, Lead.PostalCode, Lead.Country, Lead.City, Lead.Fax, 
                    Lead.Email, Lead.OwnerId, Lead.Owner.FirstName, Lead.Owner.LastName, Lead.Owner.Id,
                    Contact.ID, Contact.AccountId, Contact.Salutation, Contact.Title, Contact.Name, 
                    Contact.Phone, Contact.MailingStreet, Contact.MailingState, Contact.MailingPostalCode, 
                    Contact.MailingCountry, Contact.MailingCity, Contact.Fax, Contact.Email, Contact.OwnerId,
                    Contact.Owner.FirstName, Contact.Owner.LastName, Contact.Owner.Id, Contact.Account.name, 
                    Contact.TargetX_SRMb__Gender__c, Contact.HomePhone, Contact.MobilePhone
                    from CampaignMember 
                    where AssignedTo__c = :UserInfo.getUserId() and CampaignId = :camp 
                    AND HasResponded=false
                    ORDER BY Status desc, lastModifiedDate asc LIMIT 1];
                    }
               else{
                   members = [select Id, ContactId, LeadId, Status, CampaignId, Campaign.Name,
                    Lead.Id, Lead.Salutation, Lead.Title, Lead.Name, Lead.Company, Lead.Phone, 
                    Lead.Street, Lead.State, Lead.PostalCode, Lead.Country, Lead.City, Lead.Fax, 
                    Lead.Email, Lead.OwnerId, Lead.Owner.FirstName, Lead.Owner.LastName, Lead.Owner.Id,
                    Contact.ID, Contact.AccountId, Contact.Salutation, Contact.Title, Contact.Name, 
                    Contact.Phone, Contact.MailingStreet, Contact.MailingState, Contact.MailingPostalCode, 
                    Contact.MailingCountry, Contact.MailingCity, Contact.Fax, Contact.Email, Contact.OwnerId,
                    Contact.Owner.FirstName, Contact.Owner.LastName, Contact.Owner.Id, Contact.Account.name, 
                    Contact.TargetX_SRMb__Gender__c, Contact.HomePhone, Contact.MobilePhone
                    from CampaignMember 
                    where AssignedDate__c = null and CampaignId = :camp 
                    and HasResponded=false 
                    ORDER BY Status desc, lastModifiedDate asc LIMIT 1];}
                    
            }catch( Exception e ){
                ApexPages.addMessages( e );
            }
            if( members.size() > 0 )            
            {
                transient CampaignMember updateMember = new CampaignMember();
                updateMember=members[0];
                updateMember.AssignedTo__c = UserInfo.getUserId();
                updateMember.AssignedDate__c = datetime.Now();
                update updateMember;
                thisCampaign = members[ 0 ].Campaign.Name;
            }
            else
                thisCampaign ='';
                    
                //loop through all leads, add relevent leads and their status
            for ( CampaignMember m : members ){
                leadPlusTaskPlusContact lpt = new leadPlusTaskPlusContact( m, getcStatusMap( camp ), camp );
                leadPlusTasks.add( lpt );
                ownerMap.put( lpt.ownerId, lpt.ownerFirstName + ' ' + lpt.ownerLastName );
            }
                
            //set owners
            owners = ownerMapToSelectOption( ownerMap );
            
        }
        return null;
    }
    
    /**
    *With a map of owners and return a list of select option
    *@param ownerMap
    *@return returnVal
    */
    private List<SelectOption> ownerMapToSelectOption( Map<String, String> ownerMap ){
        List<SelectOption> returnVal=new List<SelectOption>();
        Set<String> keys = new Set<String>();
        keys = ownerMap.keySet();
        returnVal.add( new SelectOption( 'None', 'None' ));
        for ( String s: keys ){
            returnVal.add( new SelectOption(s, ownerMap.get( s )));
        }
        
        return returnVal;
    }
    
  
    
    /**
    *Return a status map
    *@param cId
    *@return cStatusMap
    */
    public Map<String,String> getcStatusMap( string cId ){
        if( !cStatusMapIsSet ){
            CampaignMemberStatus[] cStatus = [ Select Label From CampaignMemberStatus where campaignId =: cId ]; 
            cStatusMap.clear();
            for ( CampaignMemberStatus s:cStatus )
                cStatusMap.put( s.Label, '' );
            cStatusMapIsSet = true;
        }  
        return cStatusMap;
    }
    
    /**
    *Return campaign items
    *@return options
    */
    public List<SelectOption> getcampaignItems(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption( '1', 'SELECT' ));
        for( Campaign c:getactiveCampaigns()){
            options.add( new SelectOption( c.ID, c.Name ));
        }
        return options;
    }
    /**
    *Return status items option list 
    *@return options
    */
    public List<Selectoption> getstatusItems(){
        List<SelectOption> options = new List<SelectOption>();
        options.add( new SelectOption( 'None', 'None' ));
        options.add( new SelectOption( 'No Answer', 'No Answer' ));
        options.add( new SelectOption( 'Left Message', 'Left Message' ));
        options.add( new SelectOption( 'Had Conversation', 'Had Conversation' ));
        if ( camp == null || camp == '1' ){
            return options;
            }
        else    {
            for ( String k : getcStatusMap( camp ).keySet())
                options.add( new SelectOption( k, k ));
            return options;
        }
             
    }

    
 
    /**
    *Return a list of campaigns options
    *@return activeCampaigns
    */
    public List<Campaign> getactiveCampaigns(){
        if( activeCampaigns == null ){
            activeCampaigns = [ Select Name, Id From Campaign where Type = 'Telemarketing' AND isActive = true order by name LIMIT 100];
        }
        return activeCampaigns;
    }
    
    /**
    *Return the name
    *@return callDownColumns.get('Name')
    */
    public Boolean getName(){
        return callDownColumns.get( 'Name' );
    }
    
    /**
    *Return the campaign name
    */
    public String getCampaignName(){
        if ( hasCampaignID ){
            return thisCampaign;
        } else{
            return 'All Leads';
        }   
    }
        
    /**
    *Return lead Plus Task
    */
    public List<leadPlusTaskPlusContact> getLeadPlusTasks(){
        return leadPlusTasks;   
    }


    public void checkForExpiredAssignments()
    {
        if ( camp != null && camp.length( ) >3 )
        {
            Campaign campObj = new Campaign();
            campObj = [SELECT id,CallerTimeout__c FROM Campaign WHERE Id= :camp LIMIT 1];
            String CallerTimeout = campObj.CallerTimeout__c;
            
            if(CallerTimeout != 'Never')
            {
                CampaignMember[] memToClear = new LIST<CampaignMember>();
                if (CallerTimeout == null)
                {   
                    
                    string defaultTimeout = '1 Hour';
                    string hourString = defaultTimeout.substring(0,2).trim();
                    integer diff = 0 - Integer.ValueOf(hourString);
                    transient datetime rightNow = datetime.now();
                    campObj.CallerTimeout__c = '1 Hour';
                    update campObj;
                    memToClear = [select Id from CampaignMember where AssignedDate__c < :rightNow.addHours(diff)];  }
                else if (CallerTimeout.contains('Hour')==true)
                {
                    string hourString = CallerTimeout.substring(0,2).trim();
                    integer diff = 0 - Integer.ValueOf(hourString);
                    transient datetime rightNow = datetime.now();
                    memToClear = [select Id from CampaignMember where AssignedDate__c < :rightNow.addHours(diff)];      
                }
                if(CallerTimeout == 'Nightly')
                {
                    transient date rightNow = datetime.now().date();
                    memToClear = [select Id from CampaignMember where AssignedDate__c < :rightNow];
                }
               
                if (memToClear.size()>0)
                {
                    for (CampaignMember tempMem : memToClear)
                    {
                        tempMem.AssignedDate__c = null;
                        tempMem.AssignedTo__c = null;
                    }
                    update memToClear;
                }
            }
        }
    }
          
    /**
    * Inner class to wrap Lead or Contact sobject.
    */
    public class leadPlusTaskPlusContact{
        //variable for each piece of the combined record
        private List<leadPlusTaskPlusContact>   leadPlusTasks;
        public Task t;
        public String memStatus      {get; set;}
        public Map<String, String> localCStatusMap;
        public string ID             {get; set;}
        public string NAME           {get; set;}
        public string TITLE          {get; set;}
        public string SALUTATION     {get; set;}
        public string PHONE          {get; set;}
        public string COMPANY        {get; set;}
        public boolean isAContact    {get; set;}
        public string cORl           {get; set;}
        public string statusUpdate   {get; set;}
        public string memberID       {get; set;}
        public string ADDRESS        {get; set;}
        public string EMAIL          {get; set;}
        public string FAX            {get; set;}
        public string ownerFirstName {get; set;}
        public string ownerLastName  {get; set;}
        public string ownerId        {get; set;}
        public string accountName    {get; set;}
        public string callType       {get; set;}
        public string gender         {get; set;}
        public string mobilePhone    {get; set;}
        public string homePhone      {get; set;}
        public string statusU        {get; set;}
        
    
        /**
        *Constructor
        *@param m is a campaign member
        *@param statusMap a map of atatuses
        *@param camp id of campaign
        */  
        public leadPlusTaskPlusContact( CampaignMember m, Map<String, String> statusMap, string camp  ){
        
        
            if ( m.Lead.id != null ){
                cORl = 'lead';
                //l=incomingLead;
                ID = m.Lead.Id;
                NAME = m.Lead.Name;
                TITLE = m.Lead.Title;
                SALUTATION=m.Lead.Salutation;
                PHONE = m.Lead.Phone;
                COMPANY = m.Lead.Company;
                if( m.Lead.Street != null ){
                    ADDRESS = m.Lead.Street + '<br>';
                    if(m.Lead.City != null){
                        ADDRESS +=m.Lead.City;
                    }
                    if(m.Lead.State != null){
                        ADDRESS += ', ' +m.Lead.State;
                    }
                    if(m.Lead.PostalCode != null){
                        ADDRESS += ', ' +m.Lead.PostalCode;
                    }
                    if(m.Lead.Country != null){
                        ADDRESS += '<br>'+m.Lead.Country;
                    }
                }   
                else
                    ADDRESS=' ';
                 
                    if(m.Lead.Email != null){
                        EMAIL = '<a href="mailto:' + m.Lead.Email+'">' + m.Lead.Email + ' </a>';    
                    }else{
                        EMAIL =' ';
                    }
                    FAX=m.Lead.Fax;
                    ownerFirstName = m.Lead.Owner.FirstName; ownerLastName = m.Lead.Owner.LastName; 
                    ownerId = m.Lead.OwnerId; 
            }else{
                cORl = 'contact';
           
                if( m.Contact.MailingStreet != null ){
                    ADDRESS = m.Contact.MailingStreet + '<br>';
                    if(m.Contact.MailingCity != null){
                        ADDRESS +=m.Contact.MailingCity;
                    }
                    if(m.Contact.MailingState != null){
                        ADDRESS += ', '+m.Contact.MailingState;
                    }
                    if(m.Contact.mailingPostalCode != null){
                        ADDRESS += ', '+m.Contact.mailingPostalCode;
                    }
                    if(m.Contact.MailingCountry != null){
                        ADDRESS += '<br>' + m.Contact.MailingCountry;
                    }
               }else{
                    ADDRESS = ' ';
               }
                
               ID               = m.Contact.Id;
               NAME             = m.Contact.Name;
               TITLE            = m.Contact.Title;
               SALUTATION       = m.Contact.Salutation; 
               PHONE            = m.Contact.Phone;
               gender           = m.Contact.TargetX_SRMb__Gender__c;
               mobilePhone      = m.Contact.MobilePhone;
               homePhone        = m.Contact.HomePhone;
              
              
               if(m.Contact.Email != null){
                    EMAIL = '<a href="mailto:' + m.Contact.Email + '">' + m.Contact.Email + '</a>';     
               }else{
                    EMAIL = ' ';
               }
               
               FAX              = m.Contact.Fax;
               ownerFirstName   = m.Contact.Owner.FirstName; ownerLastName = m.Contact.Owner.LastName; 
               ownerId          = m.Contact.OwnerId;
               if ( m.Contact.Account.name != null )
                    COMPANY = m.Contact.Account.name;
               else
                  COMPANY = '';
            }
            
            
            t = new Task();
            t.ActivityDate = System.today();
            t.WhoId = ID;
            
            t.Subject = '';
            t.Description = '';
            
             
                       
            if ( m.Lead.id == null ){
                t.WhatId = camp;
            }
            memberID = m.ID;
            memStatus = m.Status;
            localCStatusMap = statusMap;
            
        }

        /**
        *Return a task
        *@return t
        */
        public Task gett(){
            return t;
        }
        
        /**
        *Set the task propertie
        *@param tsk
        */
        public Void sett( Task tsk ){
            t = tsk;
        }
        
        public String getmemStatus(){
            return memStatus;
        }

           
        

        /**
        *Return a list of members status values
        */
        public List<SelectOption> getmemStatusValue(){
            List<SelectOption> options = new List<SelectOption>();
            if(memStatus == 'No Answer'){
            options.add( new SelectOption(memStatus, memStatus));
            options.add( new SelectOption( 'None', 'None' ));
            //options.add( new SelectOption( 'No Answer', 'No Answer' ));
            options.add( new SelectOption( 'Left Message', 'Left Message' ));
            options.add( new SelectOption( 'Had Conversation', 'Had Conversation' ));}
            
            else{options.add( new SelectOption( 'None', 'None' ));
            options.add( new SelectOption( 'No Answer', 'No Answer' ));
            options.add( new SelectOption( 'Left Message', 'Left Message' ));
            options.add( new SelectOption( 'Had Conversation', 'Had Conversation' ));}  
               
            return options;
        }
   /**
        *Return member status
        *@return memStatus
        */
        
        
        
    }
}