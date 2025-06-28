import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _firstTimeKey = 'first_time';
  static const String _loggedInKey = 'logged_in';
  static const String _userIdKey = 'user_id';

  Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstTimeKey) ?? true;
  }

  Future<void> setFirstTimeComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstTimeKey, false);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  Future<void> setLoggedIn(bool value, {String? userId}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, value);
    if (userId != null) {
      await prefs.setString(_userIdKey, userId);
    } else {
      await prefs.remove(_userIdKey);
    }
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }
}