import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MonthService {
  late var _currentMonth;
  MonthService() {
    _currentMonth = DateTime.now().month;
  }
  String getMonth(BuildContext context, int i) {
    String _ret = "";
    switch (i) {
      case 1:
        _ret = AppLocalizations.of(context)!.month_1;
        break;
      case 2:
        _ret = AppLocalizations.of(context)!.month_2;
        break;
      case 3:
        _ret = AppLocalizations.of(context)!.month_3;
        break;
      case 4:
        _ret = AppLocalizations.of(context)!.month_4;
        break;
      case 5:
        _ret = AppLocalizations.of(context)!.month_5;
        break;
      case 6:
        _ret = AppLocalizations.of(context)!.month_6;
        break;
      case 7:
        _ret = AppLocalizations.of(context)!.month_7;
        break;
      case 8:
        _ret = AppLocalizations.of(context)!.month_8;
        break;
      case 9:
        _ret = AppLocalizations.of(context)!.month_9;
        break;
      case 10:
        _ret = AppLocalizations.of(context)!.month_10;
        break;
      case 11:
        _ret = AppLocalizations.of(context)!.month_11;
        break;
      case 12:
        _ret = AppLocalizations.of(context)!.month_12;
        break;
    }
    return _ret;
  }

  List<String> lastMonths(BuildContext context) {
    int _motnh6 = (_currentMonth + 6) % 12;
    List<String> _temp = [];
    for (var i = 0; i <= 6; i++) {
      switch ((_motnh6 + i) % 12) {
        case 1:
          _temp.add(AppLocalizations.of(context)!.month_1);
          break;
        case 2:
          _temp.add(AppLocalizations.of(context)!.month_2);
          break;
        case 3:
          _temp.add(AppLocalizations.of(context)!.month_3);
          break;
        case 4:
          _temp.add(AppLocalizations.of(context)!.month_4);
          break;
        case 5:
          _temp.add(AppLocalizations.of(context)!.month_5);
          break;
        case 6:
          _temp.add(AppLocalizations.of(context)!.month_6);
          break;
        case 7:
          _temp.add(AppLocalizations.of(context)!.month_7);
          break;
        case 8:
          _temp.add(AppLocalizations.of(context)!.month_8);
          break;
        case 9:
          _temp.add(AppLocalizations.of(context)!.month_9);
          break;
        case 10:
          _temp.add(AppLocalizations.of(context)!.month_10);
          break;
        case 11:
          _temp.add(AppLocalizations.of(context)!.month_11);
          break;
        case 12:
          _temp.add(AppLocalizations.of(context)!.month_12);
          break;
      }
    }
    return _temp;
  }
}
