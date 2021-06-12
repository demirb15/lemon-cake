import 'package:flutter/material.dart';
import 'package:flutter_template/l10n/L10n.dart';
import 'package:flutter_template/widgets/language_setter.dart';

class LanguagePicker {
  Widget dropDownLanguagePicker(BuildContext context) {
    Locale _locale = Localizations.localeOf(context);
    var index = Language.languageList()
        .indexWhere((element) => element.languageCode == _locale.languageCode);
    Language lang = Language.languageList()[index];
    return DropdownButton<Language>(
      underline: SizedBox(),
      icon: Text("${lang.languageCode}".toUpperCase()),
      onChanged: (_) {
        LanguageSwitch().switchLanguage(context, _);
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
                        //color: Colors.black,
                        ),
                  ),
                  Text(lang.flag),
                ],
              ));
        },
      ).toList(),
    );
  }
}
