import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/l10n/L10n.dart';
import 'package:flutter_template/routes/route_names.dart';
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

  Future<Locale> getLocale() async {
    final _prefs = await SharedPreferences.getInstance();
    String _languageCode = _prefs.getString("languageCode") ?? 'en';
    return Locale(_languageCode);
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
