import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/widgets/pref_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'custom_router.dart';

class Filter extends StatefulWidget {
  Filter({Key? key}) : super(key: key); //
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String _theme = "dark";
  _FilterState() {
    CustomPref().getLoginStatus().then((value) {
      if (!value) Navigator.pushNamed(context, loginRoute);
    });
    CustomPref().getOtpStatus().then((value) {
      if (!value) Navigator.pushNamed(context, loginRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final _arguments = ModalRoute.of(context)!.settings.arguments as Map;
    //print(_arguments["id"]);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.filter_navigationBar_title),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 15.0),
                child: Container(
                  width: 400,
                  height: 400,
                  color: Colors.red,
                )),
          ),
        ],
      ),
    );
  }
}
