//An apex page controller that exposes the site login functionality

 /*global with sharing class TX_CommunitiesLoginController {
    public String password { get; set; }
    public String username { get; set; }
    
    public TX_CommunitiesLoginController () {}
   
    // Code we will invoke on page load.
    global PageReference forwardToAuthPage() {
        String startUrl = System.currentPageReference().getParameters().get('startURL');
        if(startUrl == null) { startUrl = ''; }
        startUrl = Pattern.matches('(?i)tx_communitieslogin', startUrl) ? '' : startUrl;
        String displayType = System.currentPageReference().getParameters().get('display');
        // return Network.forwardToAuthPage(startUrl, displayType);
        return new PageReference(Site.getBaseUrl() + '/TX_SiteLogin?startURL=' + EncodingUtil.urlEncode(startUrl,'UTF-8'));
    }
}
*/
/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
  
  global with sharing class TX_CommunitiesLoginController {
   
    public String email {get; set;}
    public String password {get; set;}
    
    public TX_CommunitiesLoginController(TargetX_Base.TX_CommunitiesBase controller) {}
    global TX_CommunitiesLoginController() {}

     global PageReference forwardToAuthPage() {
        String startUrl = System.currentPageReference().getParameters().get('startURL');
       if(startUrl == null) { startUrl = ''; }
       startUrl = Pattern.matches('(?i)tx_communitieslogin', startUrl) ? '' : startUrl;
        String displayType = System.currentPageReference().getParameters().get('display');
        return Network.forwardToAuthPage(startUrl, displayType);
        return new PageReference(Site.getBaseUrl() + '/TX_SiteLogin?startURL=' + EncodingUtil.urlEncode(startUrl,'UTF-8'));
    }
     

   /* global PageReference RedirectToLogin()

    {

    return new PageReference( '/apex/TX_CommunitiesLogin');

 // 'StudentLogin' is the name of the VF Page for login that is created below 

    }*/

    public PageReference loginUser()

    {

    return Site.login(email, password,'/TX_CommunitiesHome');
    }

  //'NeedSupport'  is the Page to which we will be redirected after Login 

    }