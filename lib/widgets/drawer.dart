import 'package:flutter/material.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter_template/theme/drawer_theme.dart';
import 'package:flutter_template/widgets/language_dropdown.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppDrawer {
  Widget sharedDrawer(BuildContext context) {
    return Theme(
      data: DrawerThemes.drawerTheme(context),
      child: Drawer(
        child: ListView(
          children: <Widget>[
            _languageRow(context),
            _switchTheme(context),
          ],
        ),
      ),
    );
  }

  Widget _languageRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: [
          Text(AppLocalizations.of(context)!.drawer_pickLanguage),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: LanguagePicker().dropDownLanguagePicker(context),
          ),
        ],
      ),
    );
  }

  Widget _switchTheme(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: SwitchListTile(
          title: Text(AppLocalizations.of(context)!.drawer_darkThemeSwitch),
          activeTrackColor: Color.fromRGBO(128, 117, 211, 1),
          value: (StartUpApp.getTheme(context) == "dark"),
          onChanged: (bool value) {
            StartUpApp.switchTheme(context);
          },
        ),
      ),
    );
  }
}
