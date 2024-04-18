import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static String userIDKey = 'USER_ID_KEY';

  /// save user id
  Future<bool> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIDKey, userId);
  }

  /// get user id
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIDKey);
  }
}
