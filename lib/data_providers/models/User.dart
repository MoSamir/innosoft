import 'package:innosoft/resources/ApiParseKeys.dart';

class User {
  int userId;

  String userMail, firstName, lastName, avatar;

  User(
      {this.lastName, this.firstName, this.userId, this.avatar, this.userMail});

  static List<User> fromListJson(List<dynamic> usersList) {
    List<User> users = [];
    for (int i = 0; i < usersList.length; i++)
      users.add(fromJson(usersList[i]));
    return users;
  }

  static User fromJson(Map<String, dynamic> userMap) {
    return User(
      lastName: userMap[ApiParseKeys.USER_LAST_NAME] ?? '',
      firstName: userMap[ApiParseKeys.USER_FIRST_NAME] ?? '',
      avatar: userMap[ApiParseKeys.USER_AVATAR] ?? '',
      userMail: userMap[ApiParseKeys.USER_MAIL] ?? '',
      userId: int.parse((userMap[ApiParseKeys.USER_ID] ?? 0).toString()),
    );
  }
}
