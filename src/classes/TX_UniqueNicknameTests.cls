@IsTest(SeeAllData=false)
public class TX_UniqueNicknameTests {
    
    @TestSetup
    public static void setupData() {
        Account acc = new Account(
            Name='Test Account'
        );
        insert acc;
        Contact con1 = new Contact(
            FirstName='John',
            LastName='Smith',
            Email='john.smith@gmail.com',
            AccountId=acc.Id
        );
        insert con1;
        
        String profileId = [select Id from Profile where Name='Customer Community Login User'].Id;
        String nickname = 'puser000'+System.currentTimeMillis();        
        User u1 = new User(
            ProfileId = profileId,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = nickname+'@amamama.com',
            CompanyName = 'TEST',
            ContactId=con1.Id,
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert u1;
    }

    @isTest
    public static void shouldMakeUniqueNickname() {
        Account acc = [select Id from Account where Name = 'Test Account'];
        Contact con1 = [select Id from Contact where Name = 'John Smith'];
        String profileId = [select Id from Profile where Name='Customer Community Login User'].Id;
        Contact con2 = new Contact(
            FirstName='John',
            LastName='Smith2',
            Email='john.smith2@gmail.com',
            AccountId=acc.Id
        );
        insert con2;
        
        String nickname = [select CommunityNickname from User WHERE ContactId = :con1.Id].CommunityNickname;
        String nickname2 = 'puser001'+System.currentTimeMillis();
        User u2 = new User(
            ProfileId = profileId,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = nickname2+'@amamama.com',
            CommunityNickname=nickname,
            CompanyName = 'TEST',
            ContactId=con2.Id,
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert u2;
        System.assert(nickname2 + '_amamama.com' == [select CommunityNickname from User where Id = :u2.Id].CommunityNickname);
    }
}