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
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginRoute());
      case smsOtpRoute:
        return MaterialPageRoute(builder: (_) => SmsOtp());
      case accountRoute:
        return MaterialPageRoute(builder: (_) => Account());
      case filterRoute:
        return MaterialPageRoute(builder: (_) => Filter());
      case accountDetailsRoute:
        return MaterialPageRoute(builder: (_) => AccountDetails());
      case sendMoneyRoute:
        return MaterialPageRoute(builder: (_) => SendMoney());
      default:
        return MaterialPageRoute(builder: (_) => NotFound());
    }
  }
}
