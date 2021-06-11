import "package:flutter/material.dart";

import "appColors.dart";

class AppTheme {
  static ThemeData light(BuildContext context) {
    return ThemeData(
      cardColor: AppColors.paleGrey,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColors.softBlue,
      dividerColor: AppColors.softBlue,
      accentColor: AppColors.darkGreyBlueTwo,
      dialogBackgroundColor: AppColors.paleGrey,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
        textTheme: TextTheme(
          headline6: TextStyle(
              color: AppColors.darkPeriwinkle,
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.softBlue,
        disabledColor: AppColors.softBlue,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(Colors.white),
        trackColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(Colors.white),
      ),
      textTheme: Theme.of(context)
          .textTheme
          .apply(displayColor: Colors.black, bodyColor: Colors.black),
    );
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
      cardColor: AppColors.twilight,
      scaffoldBackgroundColor: AppColors.dark,
      primaryColor: AppColors.darkPeriwinkle,
      dividerColor: AppColors.seafoamBlue,
      accentColor: AppColors.darkPeriwinkleTwo,
      dialogBackgroundColor: AppColors.twilight,
      appBarTheme: AppBarTheme(
        color: AppColors.darkGreyBlueTwo,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.darkPeriwinkle,
        disabledColor: AppColors.darkPeriwinkle,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(Colors.white),
        trackColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(Colors.white),
      ),
      textTheme: Theme.of(context)
          .textTheme
          .apply(displayColor: Colors.white, bodyColor: Colors.white),
    );
  }

  static of(BuildContext context) {}
}
