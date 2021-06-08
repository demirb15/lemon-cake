import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SendMoney extends StatefulWidget {
  SendMoney({Key? key}) : super(key: key); //
  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context)!.sendMoney_navigationBar_title),
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
      body: _sendMoneyColumn(),
    );
  }

  Widget _sendMoneyColumn() {
    return Column(
      children: <Widget>[
        _sendingAccount(),
        _ibanField(),
        _recipentDetails(),
        Expanded(
          child: Container(),
        ),
        _sendMoneyButton(),
      ],
    );
  }

  Widget _sendingAccount() {
    return Container(
      child: Column(
        children: <Widget>[
          Text("data"),
          Text("asdsad"),
        ],
      ),
    );
  }

  var ibanEditingController =
      TextEditingController(text: "TR12 3456 7890 1234 5678 9012 34");
  var maskFormatter = new MaskTextInputFormatter(
      mask: 'TR## #### #### #### #### #### ##',
      filter: {"#": RegExp(r'[0-9]')});
  Widget _ibanField() {
    return Container(
      child: TextField(
        controller: ibanEditingController,
        inputFormatters: [maskFormatter],
      ),
    );
  }

  Widget _recipentDetails() {
    return Container();
  }

  Widget _sendMoneyButton() {
    return Container();
  }
}
