import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/l10n/L10n.dart';
import 'package:flutter_template/theme/theme.dart';
import 'package:flutter_template/routes/custom_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(StartUpApp());
}

class StartUpApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _StartUpAppState state =
        context.findAncestorStateOfType<_StartUpAppState>()!;
    state.setLocale(locale);
  }

  static void clearPref(BuildContext context) {
    _StartUpAppState state =
        context.findAncestorStateOfType<_StartUpAppState>()!;
    state.clearPref();
  }

  static void setOtpStatus(BuildContext context, bool isOtpValid) {
    _StartUpAppState state =
        context.findAncestorStateOfType<_StartUpAppState>()!;
    state.setOtpStatus(isOtpValid);
  }

  static bool getOtpStatus(BuildContext context) {
    _StartUpAppState state =
        context.findAncestorStateOfType<_StartUpAppState>()!;
    bool statusOTP = false;
    state.getOtpStatus().then((value) {
      statusOTP = value;
    });
    return statusOTP;
  }

  static bool getLogin(BuildContext context) {
    _StartUpAppState state =
        context.findAncestorStateOfType<_StartUpAppState>()!;
    bool loginStatus = false;
    state.getLoginStatus().then((value) {
      loginStatus = value;
    });
    return loginStatus;
  }

  static void setLogin(BuildContext context, bool isLoggedIn) {
    _StartUpAppState state =
        context.findAncestorStateOfType<_StartUpAppState>()!;
    state.setLoginStatus(isLoggedIn);
  }

  static String getUsername(BuildContext context) {
    _StartUpAppState state =
        context.findAncestorStateOfType<_StartUpAppState>()!;
    String _username = '';
    state.getUsername().then((value) {
      _username = value;
    });
    return _username;
  }

  static void setUsername(BuildContext context, String username) {
    _StartUpAppState state =
        context.findAncestorStateOfType<_StartUpAppState>()!;
    state.setUsername(username);
  }

  @override
  _StartUpAppState createState() => _StartUpAppState();
}

class _StartUpAppState extends State<StartUpApp> {
  Locale _locale = L10n.all.first;
  Future<void> setLocale(Locale locale) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("languageCode", locale.languageCode);
    setState(() {
      _locale = locale;
    });
  }

  Future<String> getUsername() async {
    final _prefs = await SharedPreferences.getInstance();
    String _username = _prefs.getString("username") ?? "";
    return _username;
  }

  Future<void> setOtpStatus(bool isValidOtp) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool("isOtpValid", isValidOtp);
  }

  Future<bool> getOtpStatus() async {
    final _prefs = await SharedPreferences.getInstance();
    bool _isOtpValid = _prefs.getBool("isLoggedIn") ?? false;
    return _isOtpValid;
  }

  Future<void> setLoginStatus(bool isLoggedIn) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool("isLoggedIn", isLoggedIn);
  }

  Future<bool> getLoginStatus() async {
    final _prefs = await SharedPreferences.getInstance();
    bool _loginStatus = _prefs.getBool("isLoggedIn") ?? false;
    return _loginStatus;
  }

  Future<Locale> getLocale() async {
    final _prefs = await SharedPreferences.getInstance();
    String _languageCode = _prefs.getString("languageCode") ?? 'en';
    return Locale(_languageCode);
  }

  Future<void> setUsername(String username) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("username", username);
  }

  Future<void> clearPref() async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.clear();
  }

  void loadPref() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    loadPref();
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: AppTheme.light(context),
      darkTheme: AppTheme.dark(context),
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      locale: _locale,
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.app_title,
      onGenerateRoute: CustomRouter.allRoutes,
      initialRoute: loginRoute,
    );
  }
}
