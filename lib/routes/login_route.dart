import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/theme/theme.dart';
import 'package:flutter/cupertino.dart';

class LoginRoute extends StatefulWidget {
  @override
  LoginRouteState createState() {
    return LoginRouteState();
  }
}

class LoginRouteState extends State<LoginRoute> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: AppTheme.light(context),
      darkTheme: AppTheme.dark(context),
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('tr', ''), // Spanish, no country code
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.app_title,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key); //
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login_appbarr_title),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 15.0),
              child: _loginColumn(),
            ),
          ),
        ],
      ),
    );
  }

  Column _loginColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          fit: StackFit.passthrough,
          children: [
            Image(
              image: AssetImage('assets/login/stars.png'),
              fit: BoxFit.fitWidth,
            ),
            Positioned(
                top: 85,
                left: 23,
                right: 157,
                child: Image(image: AssetImage('assets/login/balloonBig.png'))),
            Positioned(
                top: 110,
                left: 180,
                right: 31,
                child:
                    Image(image: AssetImage('assets/login/balloonSmall.png'))),
            Positioned(
                top: 154,
                left: 106,
                right: 109,
                child: Image(image: AssetImage('assets/login/rocket.png'))),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        _paddingTextField(_usernameTextField()),
        _paddingTextField(_passwordTextField()),
        _loginButton(),
      ],
    );
  }

  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        constraints:
            BoxConstraints.expand(width: double.infinity, height: 50.0),
        child: CupertinoButton(
          child: Text(AppLocalizations.of(context)!.login_login_button_title),
          onPressed: _loginButtonPressed,
          color: Color.fromARGB(255, 115, 106, 184),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }

  void _loginButtonPressed() {
    //TODO implement button pressed
  }
  Padding _paddingTextField(Widget widget) {
    return Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 35.0, right: 35.0),
        child: widget);
  }

  InputDecoration _textFormFieldDecoration(
      BuildContext context, String labelText) {
    return InputDecoration(
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor)),
      labelText: labelText,
      labelStyle: Theme.of(context).textTheme.bodyText2,
    );
  }

  Widget _usernameTextField() {
    return TextFormField(
      autofocus: true,
      decoration: _textFormFieldDecoration(context,
          AppLocalizations.of(context)!.login_username_textfield_placeholder),
      onChanged: (value) {},
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: _textFormFieldDecoration(context,
          AppLocalizations.of(context)!.login_password_textfield_placeholder),
      onChanged: (value) {},
      obscureText: true,
    );
  }
}
