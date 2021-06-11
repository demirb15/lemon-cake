import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter_template/theme/appColors.dart';
import 'package:flutter_template/widgets/account_detail_items.dart';
import 'package:flutter_template/widgets/http_service.dart';
import 'package:flutter_template/widgets/success_fail_promt.dart';

class SendMoney extends StatefulWidget {
  SendMoney({Key? key}) : super(key: key); //
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  late bool _isInitilized;
  late String countryCode;
  _SendMoneyState() {
    _isInitilized = false;
  }
  late AccountDetailItems _accountDetailItems;
  String _accountType = "";
  bool _blured = false;
  late int id;
  @override
  Widget build(BuildContext context) {
    if (!_isInitilized) {
      final _arguments = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {
        _accountType = _arguments['accountType'] as String;
        id = _arguments['id'];
        HttpService().getAccountDetails(id).then((value) {
          _accountDetailItems = value;
          _amountPlaceHolder = '${_accountDetailItems.currency}';
        });
      });
      StartUpApp.getCountryCode(context).then((value) {
        setState(() {
          countryCode = value;
          _isInitilized = true;
        });
      });
    }
    return !_isInitilized
        ? Scaffold()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                  AppLocalizations.of(context)!.sendMoney_navigationBar_title),
              centerTitle: true,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Container(
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Image.asset('assets/send_money/icBack.png'),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            body: Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                _sendMoneyColumn(),
                bluredContent(),
              ],
            ),
          );
  }

  Widget bluredContent() {
    if (_blured) {
      return Positioned.fill(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 2.0,
            sigmaY: 2.0,
          ),
          child: Column(
            children: [
              Expanded(child: Container()),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(40),
                      child: Text(
                        isSuccess
                            ? AppLocalizations.of(context)!
                                .sendMoney_successPrompt_success
                            : AppLocalizations.of(context)!
                                .sendMoney_failurePrompt_fail,
                        style: TextStyle(
                          color: AppColors.darkPeriwinkle,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    SuccessFailPrompt().imageStack(isSuccess),
                    isSuccess ? _successButton() : _successButton(),
                    !isSuccess ? _successButton() : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container();
  }

  bool isSuccess = false;
  Widget _successButton() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        constraints: BoxConstraints.expand(
            width: double.infinity,
            height: 50 * MediaQuery.of(context).size.height / 830),
        child: CupertinoButton(
          child: Text(
            AppLocalizations.of(context)!
                .sendMoney_successPrompt_backToEarth_button_title,
          ),
          onPressed: () {
            setState(() {
              _blured = false;
            });
          },
          color: AppColors.darkPeriwinkle,
          disabledColor: AppColors.darkPeriwinkle,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }

  TextStyle _textStyleMain(double fontsize) {
    return TextStyle(
      fontSize: fontsize,
      color: Colors.white,
    );
  }

  TextStyle _textStyleSecond(double fontsize) {
    return TextStyle(
      fontSize: fontsize,
      color: AppColors.seafoamBlue,
    );
  }

  Widget _sendMoneyColumn() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 64, left: 30, right: 30),
          alignment: Alignment.topLeft,
          child: Text(
            AppLocalizations.of(context)!.sendMoney_sending_account,
            style: _textStyleSecond(16),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5, left: 30, right: 30),
          alignment: Alignment.topLeft,
          child: Text(
            "$_accountType",
            style: _textStyleMain(24),
          ),
        ),
        _ibanField(),
        _recipentDetails(),
        _amountField(),
        Expanded(
          child: Container(),
        ),
        _buttonDecoration(_sendMoneyButton()),
      ],
    );
  }

  var ibanEditingController = TextEditingController();

  Widget _ibanField() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: TextField(
        controller: ibanEditingController,
        decoration: InputDecoration(
          labelText: "IBAN",
          labelStyle: _textStyleSecond(16),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[ 0-9]')),
        ],
        onChanged: (_) {
          setState(() {
            String temp = '$countryCode$_';
            temp = temp.replaceAll(new RegExp(r"\s+"), "");

            var buffer = new StringBuffer();
            for (int i = 0; i < temp.length; i++) {
              buffer.write(temp[i]);
              var nonZeroIndex = i + 1;
              if (nonZeroIndex % 4 == 0 && nonZeroIndex != temp.length) {
                buffer.write(' ');
              }
            }
            temp = buffer.toString();
            ibanEditingController = TextEditingController(text: temp);
            ibanEditingController.selection = TextSelection.fromPosition(
                TextPosition(offset: ibanEditingController.text.length));
          });
        },
      ),
    );
  }

  var recipentDetailcontroler = TextEditingController();
  Widget _recipentDetails() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: TextField(
        controller: recipentDetailcontroler,
        decoration: InputDecoration(
          labelText:
              "${AppLocalizations.of(context)!.sendMoney_recipient_name_and_surname}",
          labelStyle: _textStyleSecond(16),
        ),
      ),
    );
  }

  String _amountPlaceHolder = "";
  var amountFieldControler = TextEditingController();
  Widget _amountField() {
    return Padding(
      padding: EdgeInsets.all(30),
      child: TextField(
        controller: amountFieldControler,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[.0-9]')),
        ],
        onChanged: (_) {
          setState(() {
            if ('.'.allMatches(_).length <= 1) {
              amountFieldControler =
                  TextEditingController(text: '$_ $_amountPlaceHolder');
              amountFieldControler.selection = TextSelection.fromPosition(
                  TextPosition(offset: amountFieldControler.text.length - 3));
            } else {
              String temp = _.substring(0, _.length - 1);

              amountFieldControler =
                  TextEditingController(text: '$temp $_amountPlaceHolder');
              amountFieldControler.selection = TextSelection.fromPosition(
                  TextPosition(offset: amountFieldControler.text.length - 3));
            }
          });
        },
        decoration: InputDecoration(
          labelText: "${AppLocalizations.of(context)!.sendMoney_amount}",
          labelStyle: _textStyleSecond(16),
        ),
      ),
    );
  }

  Widget _buttonDecoration(Widget w) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        constraints: BoxConstraints.expand(
            width: double.infinity,
            height: 50 * MediaQuery.of(context).size.height / 830),
        child: w,
      ),
    );
  }

  Widget _sendMoneyButton() {
    return CupertinoButton(
      child: Text(
        AppLocalizations.of(context)!.sendMoney_send_money_button_title,
      ),
      onPressed: () {
        String iban = ibanEditingController.text;
        String recipentDetails = recipentDetailcontroler.text;
        String amount = amountFieldControler.text.split(' ')[0];
        late var _amount;
        if (amount.isNotEmpty) _amount = double.parse(amount);
        // TODO: uncomment to have update json server
        // HttpService().updateBalance(id, _amount);

        bool temp =
            iban.isNotEmpty && recipentDetails.isNotEmpty && amount.isNotEmpty;
        if (temp) {
          if (_amount > double.parse(_accountDetailItems.amount)) temp = false;
          setState(() {
            isSuccess = temp;
            _blured = true;
          });
        }
      },
      color: AppColors.darkPeriwinkle,
      disabledColor: AppColors.darkPeriwinkle,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    );
  }
}
