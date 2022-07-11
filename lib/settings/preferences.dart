import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static List<String> _lastSearch = [];

  static String? _idDevicePushNotificationToken = '';
  static String _apiTokenBearer = '';
  static int _idWishList = -1;

  static String _language = 'es';
  static bool _isDarkMode = false;

  static bool _skipTutorial = false;
  //static int _digit = 2;

  static String _email = "";
  static String _password = "";

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static List<String> get lastSearch {
    return _prefs.getStringList('lastSearch') ?? _lastSearch;
  }

  static set setStringList(List<String> value) {
    _lastSearch = value;
    _prefs.setStringList('lastSearch', value);
  }

  static String? get idDevicePushNotificationToken {
    return _prefs.getString('idDevicePushNotificationToken') ?? _idDevicePushNotificationToken;
  }

  static set idDevicePushNotificationToken(String? value) {
    _idDevicePushNotificationToken = value;
    _prefs.setString('idDevicePushNotificationToken', value!);
  }

  static String get apiTokenBearer {
    return _prefs.getString('apiToken') ?? _apiTokenBearer;
  }

  static set apiTokenBearer(String value) {
    _apiTokenBearer = value;
    _prefs.setString('apiToken', value);
  }

  static int get idWishList {
    return _prefs.getInt('idWishList') ?? _idWishList;
  }

  static set idWishList(int value) {
    _idWishList = value;
    _prefs.setInt('idWishList', value);
  }

  static String get language {
    return _prefs.getString('language') ?? _language;
  }

  static set language(String value) {
    _language = value;
    _prefs.setString('language', value);
  }

  static bool get isDarkMode {
    return _prefs.getBool('isDarkMode') ?? _isDarkMode;
  }

  static set isDarkMode(bool value) {
    _isDarkMode = value;
    _prefs.setBool('isDarkMode', value);
  }

  static bool get skipTutorial {
    return _prefs.getBool('skipTutorial') ?? _skipTutorial;
  }

  static set skipTutorial(bool value) {
    _skipTutorial = value;
    _prefs.setBool('skipTutorial', value);
  }

  static String get email {
    return _prefs.getString('email') ?? _email;
  }

  static set email(String value) {
    _email = value;
    _prefs.setString('email', value);
  }

  static String get password {
    return _prefs.getString('password') ?? _password;
  }

  static set password(String value) {
    _password = value;
    _prefs.setString('password', value);
  }
}
