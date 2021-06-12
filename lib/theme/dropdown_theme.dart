import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'appColors.dart';

class DropDownTheme {
  static ThemeData dropDownTheme(BuildContext context) {
    return (StartUpApp.getTheme(context) == "dark")
        ? ThemeData(
            canvasColor: AppColors.twilight,
            textTheme: Theme.of(context)
                .textTheme
                .apply(displayColor: Colors.white, bodyColor: Colors.white),
          )
        : ThemeData(
            canvasColor: Colors.white,
            textTheme: Theme.of(context).textTheme.apply(
                displayColor: Colors.white, bodyColor: AppColors.fuchsiaBlue),
          );
  }
}
