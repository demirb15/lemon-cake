import 'package:flutter/material.dart';
//import 'package:flutter_template/theme/theme.dart';
import 'routes/login_route.dart';

void main() {
  runApp(StartUpApp());
}

class StartUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginRoute(),
    );
  }
}
