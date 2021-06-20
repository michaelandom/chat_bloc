import 'package:shared_preferences/shared_preferences.dart';

class HSharedPreference {
  static const KEY_FIRST_TIME = "FIRST_TIME";
  static const USER_STATES = "USER_STATES";
  static const USER_NAME = "USER_NAME";
  static const LOCALE = "LOCALE";
  static const THEME = "THEME";

  Future<bool> set(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is String) {
      return prefs.setString(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    } else if (value is List) {
      return prefs.setStringList(key, value);
    } else {
      return prefs.setString(key, value.toString());
    }
  }

  dynamic get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (key == "LIST_CONTACTS" || key == "LIST_RECENT_CITIES") {
      return prefs.getStringList(key);
    }
    return prefs.get(key);
  }
}

class GetHSPInstance {
  static HSharedPreference hSharedPreference = HSharedPreference();
}
