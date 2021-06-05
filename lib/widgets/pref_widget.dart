import 'package:shared_preferences/shared_preferences.dart';

class CustomPref {
  late final _prefs;
  Future<void> setLoginStatus(bool isLoggedIn) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool("isLoggedIn", isLoggedIn);
  }

  Future<bool> getLoginStatus() async {
    _prefs = await SharedPreferences.getInstance();
    bool _loginStatus = _prefs.getBool("isLoggedIn") ?? false;
    return _loginStatus;
  }

  Future<void> setUsername(String username) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("username", username);
  }

  Future<String> getUsername() async {
    _prefs = await SharedPreferences.getInstance();
    String _username = _prefs.getString("username") ?? "";
    return _username;
  }

  Future<void> setOtpStatus(bool isValidOtp) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool("isOtpValid", isValidOtp);
  }

  Future<bool> getOtpStatus() async {
    _prefs = await SharedPreferences.getInstance();
    bool _isOtpValid = _prefs.getBool("isLoggedIn") ?? false;
    return _isOtpValid;
  }

  Future<void> clearPref() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.clear();
  }
}
