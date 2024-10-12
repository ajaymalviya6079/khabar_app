
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  /// Prevent creating instance
  MySharedPref._();

  /// Shared preferences instance
  static late SharedPreferences _sharedPreferences;

  /// Storage keys
  static const String _isLoginKey = 'isLogin';


  /// Initialize shared preferences
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  /// Save login status
  static Future<void> setLoginStatus(bool isLogin) =>
      _sharedPreferences.setBool(_isLoginKey, isLogin);

  /// Get login status
  static bool getLoginStatus() =>
      _sharedPreferences.getBool(_isLoginKey) ?? false;

  /// Clear all data from shared preferences
  static Future<void> clear() async => await _sharedPreferences.clear();
}




