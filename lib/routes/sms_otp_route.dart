import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/theme/appColors.dart';
import 'package:flutter_template/widgets/pref_widget.dart';

import '../main.dart';
import 'custom_router.dart';

class SmsOtp extends StatefulWidget {
  SmsOtp({Key? key}) : super(key: key); //
  @override
  _SmsOtpState createState() => _SmsOtpState();
}

class _SmsOtpState extends State<SmsOtp> {
  int _timeLeftInSeconds = 300;
  bool _timeOut = false;
  String _timeLeftStr = '';
  _SmsOtpState() {
    CustomPref().getLoginStatus().then((value) {
      if (!value)
        Navigator.of(context).pushNamedAndRemoveUntil(
            loginRoute, (Route<dynamic> route) => false);
    });
    startTimer();
  }
  String _theme = "dark";
  @override
  Widget build(BuildContext context) {
    _theme = StartUpApp.getTheme(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.otp_navigationBar_title),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset('assets/otp/$_theme/icBack.png'),
              onPressed: () {
                _timer.cancel();
                Navigator.pushReplacementNamed(context, loginRoute);
              },
            );
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 15.0),
              child: _otpColumn(),
            ),
          ),
        ],
      ),
    );
  }

  String _phoneNumber = "555 555 55 55";
  Column _otpColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 50, left: 100, right: 110),
          child: Text(
            AppLocalizations.of(context)!.otp_login_with_sms_otp,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(89, 201, 179, 1),
              fontSize: 32,
              fontFamily: 'RaleWay',
            ),
          ),
        ),
        Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 45),
              child: Card(
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                    minHeight: 350,
                    maxWidth: double.infinity,
                    maxHeight: double.infinity,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 35,
              top: 25 + 45,
              right: 35,
              child: Text(
                "${AppLocalizations.of(context)!.otp_message_prompt}$_phoneNumber",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 130 + 45, left: 35, right: 35),
              child: _timeLeftRow(),
            ),
            _timeOutWidget(),
            Positioned(
              top: 262,
              left: 40,
              child: _animatedTimerBar(),
            ),
            Positioned(
              top: 262,
              right: 40,
              child: _animatedTimerBarWhite(),
            ),
            _animatedtimerIcon(),
            _codeField(),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        _loginButton(),
      ],
    );
  }

  var _onpressed;
  var _buttonTextColor = Colors.white24;
  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        constraints:
            BoxConstraints.expand(width: double.infinity, height: 50.0),
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
    String _codeInput = codeFieldController.text;

    if (_codeInput == '1111' && _timer.isActive) {
      _timer.cancel();
      CustomPref().setOtpStatus(true);
      Navigator.pushReplacementNamed(context, accountRoute);
    }
  }

  bool _fooBar = false;
  AnimatedContainer _animatedTimerBarWhite() {
    return AnimatedContainer(
      height: 1,
      width: _fooBar ? MediaQuery.of(context).size.width - 80 : 1,
      color: Colors.white70,
      alignment: _fooBar ? Alignment.center : AlignmentDirectional.topCenter,
      curve: Curves.linear,
      duration: Duration(seconds: _timeLeftInSeconds),
    );
  }

  AnimatedContainer _animatedTimerBar() {
    return AnimatedContainer(
      height: 3,
      width: _fooBar ? 1 : MediaQuery.of(context).size.width - 80,
      color: AppColors.seafoamBlue,
      alignment: _fooBar ? Alignment.center : AlignmentDirectional.topCenter,
      curve: Curves.linear,
      duration: Duration(seconds: _timeLeftInSeconds),
    );
  }

  AnimatedPositioned _animatedtimerIcon() {
    return AnimatedPositioned(
      child: Image.asset("assets/otp/$_theme/barProgressCiricle.png"),
      duration: Duration(seconds: _timeLeftInSeconds),
      right: !_fooBar ? 35 : MediaQuery.of(context).size.width - 50,
      top: 256,
    );
  }

  late Timer _timer;

  void startTimer() {
    //_fooBar = true;
    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_timeLeftInSeconds == 0) {
          setState(() {
            timer.cancel();
            _timeOut = true;
          });
        } else {
          setState(() {
            if (!_fooBar) _fooBar = true;
            _timeLeftInSeconds--;
            int _min = (_timeLeftInSeconds / 60).truncate();
            int _sec = (_timeLeftInSeconds % 60).truncate();
            _timeLeftStr = "$_min:$_sec";
          });
        }
      },
    );
  }

  Row _timeLeftRow() {
    return Row(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppLocalizations.of(context)!.otp_remaining_duration,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text("$_timeLeftStr"),
        ),
      ],
    );
  }

  TextEditingController codeFieldController = TextEditingController();
  Padding _codeField() {
    return Padding(
      padding: const EdgeInsets.only(top: 290, left: 35.0, right: 35.0),
      child: TextFormField(
        controller: codeFieldController,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor),
          ),
          labelText: AppLocalizations.of(context)!.otp_password,
          labelStyle: Theme.of(context).textTheme.bodyText2,
        ),
        onChanged: (value) {
          if (value.length == 4) {
            setState(() {
              _buttonTextColor = Colors.white;
              _onpressed = _loginButtonPressed;
            });
          } else
            setState(() {
              _onpressed = null;
            });
        },
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
        ],
      ),
    );
  }

  Widget _timeOutWidget() {
    if (_timeOut)
      return AlertDialog(
        title: Text("Time Out"),
        titleTextStyle: TextStyle(
          fontSize: 36,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, accountRoute);
            },
            child: Text(
              "Go Back to login",
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      );
    return Container();
  }
}
