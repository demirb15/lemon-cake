import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Account extends StatefulWidget {
  Account({Key? key}) : super(key: key); //
  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          Text("asdasds"),
          Center(
            child: Image(image: AssetImage('assets/home/rocket.png')),
          ),
          Center(
            child: Image(image: AssetImage('assets/home/image.png')),
          ),
        ],
      ),
    );
  }
}
