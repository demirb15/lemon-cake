import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/routes/custom_router.dart';
import 'package:flutter_template/theme/appColors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          Center(
            child: Image(image: AssetImage('assets/home/rocket.png')),
          ),
          Center(
            child: Image(image: AssetImage('assets/home/image.png')),
          ),
          Positioned(
            bottom: 50,
            left: 50,
            right: 50,
            child: CupertinoButton(
              color: AppColors.darkPeriwinkle,
              child: Text("Move to Login"),
              onPressed: () {
                Navigator.pushNamed(context, loginRoute);
              },
            ),
          )
        ],
      ),
    );
  }
}
