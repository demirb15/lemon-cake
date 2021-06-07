import 'package:flutter/material.dart';
import 'package:flutter_template/routes/account_detail_route.dart';
import 'package:flutter_template/routes/account_route.dart';
import 'package:flutter_template/routes/filter_route.dart';
import 'package:flutter_template/routes/home_route.dart';
import 'package:flutter_template/routes/login_route.dart';
import 'package:flutter_template/routes/not_found_route.dart';
import 'package:flutter_template/routes/send_money_route.dart';
import 'package:flutter_template/routes/sms_otp_route.dart';

//route names
const String homeRoute = 'homeRoute';
const String loginRoute = 'loginRoute';
const String smsOtpRoute = 'smsOtpRoute';
const String accountRoute = 'accountRoute';
const String filterRoute = 'filterRoute';
const String accountDetailsRoute = 'accountDetailsRoute';
const String sendMoneyRoute = 'sendMoney';
const String notFoundRoute = 'notFound';

//router that navigates to other pages
class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    //print(settings.arguments);
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case loginRoute:
        return MaterialPageRoute(
            builder: (_) => LoginRoute(), settings: settings);
      case smsOtpRoute:
        return MaterialPageRoute(builder: (_) => SmsOtp(), settings: settings);
      case accountRoute:
        return MaterialPageRoute(builder: (_) => Account(), settings: settings);
      case filterRoute:
        return MaterialPageRoute(builder: (_) => Filter(), settings: settings);
      case accountDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => AccountDetails(), settings: settings);
      case sendMoneyRoute:
        return MaterialPageRoute(
            builder: (_) => SendMoney(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => NotFound(), settings: settings);
    }
  }
}
