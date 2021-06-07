import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/l10n/L10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter_template/theme/appColors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_template/widgets/pref_widget.dart';
import 'custom_router.dart';

class LoginRoute extends StatefulWidget {
  LoginRoute({Key? key}) : super(key: key); //
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  _LoginRouteState() {
    getUsername().then((value) {
      usernameController.text = value;
      if (value != '') _rememberMeSwitchVar = true;
    });
  }
  Future<String> getUsername() async {
    final _prefs = await SharedPreferences.getInstance();
    String _username = _prefs.getString("username") ?? "";
    return _username;
  }

  bool _rememberMeSwitchVar = false;

  String username = '';
  String password = '';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Locale _locale = Localizations.localeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.login_navigationBar_title),
        centerTitle: true,
        leading: Container(),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: DropdownButton<Language>(
              underline: SizedBox(),
              icon: Text("${_locale.languageCode}".toUpperCase()),
              onChanged: (_) {
                _switchLanguage(_);
              },
              items: Language.languageList().map(
                (Language lang) {
                  return DropdownMenuItem<Language>(
                      value: lang,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            lang.name,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Text(lang.flag),
                        ],
                      ));
                },
              ).toList(),
            ),
          )
        ],
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
        _rememberMeSwitch(),
        _loginButton(),
      ],
    );
  }

  void _switchLanguage(_) {
    Locale temp = Locale(_!.languageCode);
    StartUpApp.setLocale(context, temp);
  }

  Widget _rememberMeSwitch() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        constraints:
            BoxConstraints.expand(width: double.infinity, height: 50.0),
        child: SwitchListTile(
          title:
              Text(AppLocalizations.of(context)!.login_rememberMe_label_text),
          activeTrackColor: Color.fromRGBO(128, 117, 211, 1),
          value: _rememberMeSwitchVar,
          onChanged: (bool value) {
            setState(() {
              _rememberMeSwitchVar = value;
            });
          },
        ),
      ),
    );
  }

  var _onpressed;
  var _buttonTextColor = Colors.white24;
  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
      child: Container(
        constraints: BoxConstraints.expand(
            width: double.infinity,
            height: 50 * MediaQuery.of(context).size.height / 830),
        child: CupertinoButton(
          child: Text(
            AppLocalizations.of(context)!.login_login_button_title,
            style: TextStyle(color: _buttonTextColor),
          ),
          onPressed: _onpressed,
          color: AppColors.darkPeriwinkle,
          disabledColor: AppColors.darkPeriwinkle,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }

  void _loginButtonPressed() {
    username = usernameController.text;
    password = passwordController.text;
    //TODO: Set login cred to http call
    //TODO: Remove remove clear pref for remember me switch
    if (username == 'testuser' && password == '655321') {
      if (_rememberMeSwitchVar) {
        CustomPref().setUsername(username);
      } else {
        CustomPref().clearPref();
      }
      CustomPref().setLoginStatus(true);
      Navigator.pushReplacementNamed(context, smsOtpRoute);
    }
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
      controller: usernameController,
      autofocus: true,
      onTap: () {
        usernameController = new TextEditingController();
      },
      decoration: _textFormFieldDecoration(context,
          AppLocalizations.of(context)!.login_username_text_field_placeholder),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
      ],
      onChanged: (value) {},
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.number,
      decoration: _textFormFieldDecoration(context,
          AppLocalizations.of(context)!.login_password_text_field_placeholder),
      inputFormatters: <TextInputFormatter>[
        LengthLimitingTextInputFormatter(6),
        FilteringTextInputFormatter.digitsOnly
      ],
      onChanged: (value) {
        if (value.length == 6) {
          setState(
            () {
              _buttonTextColor = Colors.white;
              _onpressed = _loginButtonPressed;
            },
          );
        } else {
          setState(() {
            _buttonTextColor = Colors.white24;
            _onpressed = null;
          });
        }
      },
      obscureText: true,
    );
  }
}
