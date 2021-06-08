import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/theme/appColors.dart';
import 'package:flutter_template/widgets/account_detail_items.dart';
import 'package:flutter_template/widgets/http_service.dart';
import 'package:flutter_template/widgets/pref_widget.dart';
import 'package:flutter_template/widgets/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share/share.dart';
import 'custom_router.dart';

class AccountDetails extends StatefulWidget {
  AccountDetails({Key? key}) : super(key: key); //
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

late AccountDetailItems _accountDetailItem;
Color _secondaryTextColor = AppColors.seafoamBlue;

class _AccountDetailsState extends State<AccountDetails> {
  _AccountDetailsState() {
    HttpService().getAccountDetails(4);
    CustomPref().getLoginStatus().then((value) {
      if (!value) Navigator.pushNamed(context, loginRoute);
    });
    CustomPref().getOtpStatus().then((value) {
      if (!value) Navigator.pushNamed(context, loginRoute);
    });
  }

  bool _initilized = false;
  String _accountType = "";
  @override
  Widget build(BuildContext context) {
    if (!_initilized) {
      final _arguments = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {
        _accountType = _arguments['accountType'] as String;
        _accountType = _accountType.capitalize();
      });
      HttpService().getAccountDetails(_arguments['id']).then((value) {
        setState(() {
          _accountDetailItem = value;
          _initilized = true;
        });
      });
    }
    return !_initilized
        ? Scaffold()
        : Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!
                  .accountDetail_navigationBar_title),
              centerTitle: true,
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Container(
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Image.asset('assets/account_details/icBack.png'),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            body: _accountDetailColumn(),
          );
  }

  Widget _accountDetailColumn() {
    return Column(
      children: <Widget>[
        _userProfileRow(),
        _accountProfileRow(),
        _balanceRow(),
        _ibanRow(),
        Expanded(child: Container()),
        _sendMoneyButton(),
      ],
    );
  }

  Widget _userProfileRow() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Image.asset(
                      'assets/account_details/iconsAvatarPlaceholder.png'),
                  //TODO: add button to change user image,
                ],
              )),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      '${_accountDetailItem.customerName} ${_accountDetailItem.customerLastName}',
                      style: TextStyle(
                        color: _secondaryTextColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '${_accountDetailItem.customerCity}, ${_accountDetailItem.customerCountry}',
                      style: TextStyle(
                        //color: _secondaryTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Column _twoElementColumn(Widget w1, Widget w2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: w1,
        ),
        Container(
          child: w2,
        ),
      ],
    );
  }

  Widget _accountProfileRow() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: _twoElementColumn(
                Text(
                  '${AppLocalizations.of(context)!.accountDetail_account_name}',
                  style: TextStyle(
                    //color: _secondaryTextColor,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '$_accountType',
                  style: TextStyle(
                    color: _secondaryTextColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: _twoElementColumn(
                Text(
                  '${AppLocalizations.of(context)!.accountDetail_account_number}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${_accountDetailItem.accountNo}',
                  style: TextStyle(
                    fontSize: 16,
                    color: _secondaryTextColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _balanceRow() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: _twoElementColumn(
                Text(
                  '${AppLocalizations.of(context)!.accountDetail_available_balance}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${_accountDetailItem.amount}',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ibanRow() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Row(
        children: <Widget>[
          _twoElementColumn(
            Text(
              "IBAN",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '${_accountDetailItem.iban}',
              style: TextStyle(
                fontSize: 20,
                color: _secondaryTextColor,
              ),
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            icon: Image.asset('assets/account_details/iconsShare.png'),
            onPressed: () {
              Share.share('${_accountDetailItem.iban}');
            },
          ),
        ],
      ),
    );
  }

  Widget _sendMoneyButton() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        constraints: BoxConstraints.expand(
            width: double.infinity,
            height: 50 * MediaQuery.of(context).size.height / 830),
        child: CupertinoButton(
          child: Text(
            AppLocalizations.of(context)!.accountDetail_send_money_button_title,
          ),
          onPressed: () {
            Navigator.pushNamed(context, sendMoneyRoute);
          },
          color: AppColors.darkPeriwinkle,
          disabledColor: AppColors.darkPeriwinkle,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
