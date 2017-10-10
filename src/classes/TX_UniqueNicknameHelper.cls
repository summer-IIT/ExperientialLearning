public class TX_UniqueNicknameHelper {

    public static List<User> getMatchingUsers(List<User> triggerNew) {
        Set<String> nicknames = new Set<String>();
        for(User u : triggerNew) {
            nicknames.add(u.CommunityNickname);
        }
        return [
            select Id, CommunityNickname 
            from User 
            where CommunityNickname IN :nicknames
        ];
    }
    
    // there is unique check on username as well, so we reliably fallback on this
    public static String getUniqueNickname(User u) {
        String username = u.Username;
        String[] parts = username.split('@');
        if(parts.size() == 2) {
            return parts[0] + '_' + parts[1];
        } else {
            return parts[0] + '_' + Datetime.now().getTime();
        }
    }
}