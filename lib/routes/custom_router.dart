import 'package:flutter/material.dart';
import 'package:flutter_template/routes/login_route.dart';
import 'package:flutter_template/routes/route_names.dart';
import 'package:flutter_template/routes/not_found_route.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginRoute());
    }
    return MaterialPageRoute(builder: (_) => NotFound());
  }
}
