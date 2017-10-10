trigger TX_MakeUniqueNickname on User (before insert) {

    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            // find matching users
            List<User> matchingUsers = TX_UniqueNicknameHelper.getMatchingUsers(Trigger.new);
            if(matchingUsers.size() != 0) {
                for(User u : Trigger.new) {
                    for(User matchingUser : matchingUsers) {
                        if(String.isNotBlank(u.CommunityNickname) 
                            && u.CommunityNickname.equals(matchingUser.CommunityNickname)) {
                            u.CommunityNickname = TX_UniqueNicknameHelper.getUniqueNickname(u);
                        }
                    }
                }
            }
        }
    }
}