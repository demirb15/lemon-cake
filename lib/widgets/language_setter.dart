import 'package:flutter/cupertino.dart';
import 'package:flutter_template/l10n/L10n.dart';

import '../main.dart';

class LanguageSwitch {
  void switchLanguage(BuildContext context, var con) {
    var _index = L10n.all
        .indexWhere((element) => element.languageCode == con.languageCode);
    Locale temp = L10n.all[_index];
    StartUpApp.setLocale(context, temp);
  }
}
