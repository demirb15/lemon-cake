import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      ),
      body: Container(),
    );
  }
}
