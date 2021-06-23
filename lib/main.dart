import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/l10n/L10n.dart';
import 'package:flutter_template/theme/theme.dart';
import 'package:flutter_template/routes/custom_router.dart';
import 'package:flutter_template/widgets/pref_widget.dart';
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

  static Future<String> getCountryCode(BuildContext context) async {
    _StartUpAppState state =
        context.findAncestorStateOfType<_StartUpAppState>()!;
    Locale temp = await state.getLocale();

    return temp.countryCode.toString();
  }

  static void switchTheme(BuildContext context) {
    _StartUpAppState state =
        context.findAncestorStateOfType<_StartUpAppState>()!;
    state.switchTheme();
  }

  static String getTheme(BuildContext context) {
    _StartUpAppState state =
        context.findAncestorStateOfType<_StartUpAppState>()!;
    String _temp = "";
    _temp = state.currentTheme();
    return _temp;
  }

  @override
  _StartUpAppState createState() => _StartUpAppState();
}

class _StartUpAppState extends State<StartUpApp> {
  Locale _locale = L10n.all.first;
  ThemeMode _theme = ThemeMode.system;
  _StartUpAppState() {
    loadPref();
    CustomPref().setLoginStatus(false);
    CustomPref().setOtpStatus(false);
  }
  Future<void> setLocale(Locale locale) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString("languageCode", locale.languageCode);
    setState(() {
      _locale = locale;
    });
  }

  Future<Locale> getLocale() async {
    final _prefs = await SharedPreferences.getInstance();

    String _languageCode = _prefs.getString("languageCode") ?? 'en';
    var _index =
        L10n.all.indexWhere((element) => element.languageCode == _languageCode);
    Locale temp = L10n.all[_index];
    return temp;
  }

  String currentTheme() {
    if (_theme == ThemeMode.dark) return "dark";
    return "light";
  }

  Future<String> getTheme() async {
    final _prefs = await SharedPreferences.getInstance();
    String _themeString = _prefs.getString("theme") ?? 'light';
    return _themeString;
  }

  Future<void> switchTheme() async {
    final _prefs = await SharedPreferences.getInstance();
    String _themeString = _prefs.getString("theme") ?? 'light';
    String _newTheme = (_themeString == "dark") ? "light" : "dark";
    await _prefs.setString("theme", _newTheme);
    setState(() {
      if (_newTheme == "dark")
        _theme = ThemeMode.dark;
      else
        _theme = ThemeMode.light;
    });
  }

  void loadPref() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    getTheme().then((value) {
      setState(() {
        this._theme = (value == "dark") ? ThemeMode.dark : ThemeMode.light;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _theme,
      theme: AppTheme.light(context),
      darkTheme: AppTheme.dark(context),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
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
