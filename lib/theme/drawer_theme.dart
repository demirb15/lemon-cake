import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'appColors.dart';

class DrawerThemes {
  static ThemeData drawerTheme(BuildContext context) {
    return (StartUpApp.getTheme(context) == "dark")
        ? ThemeData(
            canvasColor: AppColors.twilight,
            switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.all(Colors.white),
              trackColor: MaterialStateProperty.all(Colors.white),
              overlayColor: MaterialStateProperty.all(Colors.white),
            ),
            textTheme: Theme.of(context)
                .textTheme
                .apply(displayColor: Colors.white, bodyColor: Colors.white),
          )
        : ThemeData(
            canvasColor: Colors.white,
            switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.all(Colors.white),
              overlayColor: MaterialStateProperty.all(Colors.white),
            ),
            textTheme: Theme.of(context).textTheme.apply(
                displayColor: Colors.white, bodyColor: AppColors.fuchsiaBlue),
          );
  }
}
