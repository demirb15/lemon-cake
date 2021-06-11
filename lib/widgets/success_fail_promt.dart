import 'package:flutter/material.dart';
import 'package:flutter_template/theme/appColors.dart';

class SuccessFailPrompt {
  Widget imageStack(bool isSuccess) {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        Center(
          child: isSuccess
              ? Image.asset('assets/send_money/success/bgRokcetStars.png')
              : Image.asset('assets/send_money/fail/bgRokcetStars.png'),
        ),
        Container(
          padding: EdgeInsets.only(top: 55, bottom: 55),
          child: Row(
            children: [
              Expanded(child: Container()),
              Container(
                child: Container(
                  decoration: BoxDecoration(
                    color: isSuccess ? AppColors.seafoamBlue : Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  child: isSuccess
                      ? Image.asset(
                          'assets/send_money/success/darkThemeIconsCheck.png')
                      : Image.asset(
                          'assets/send_money/fail/darkThemeIconsExclamation.png'),
                ),
              ),
              Container(
                width: 30,
              ),
              Container(
                child: isSuccess
                    ? Image.asset('assets/send_money/success/rocket.png')
                    : Image.asset('assets/send_money/fail/rocket.png'),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ],
    );
  }
}
