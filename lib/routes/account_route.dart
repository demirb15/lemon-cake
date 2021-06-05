import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter_template/theme/appColors.dart';
import 'package:flutter_template/widgets/account_items.dart';
import 'package:flutter_template/widgets/month_ser.dart';
import 'package:flutter_template/widgets/pref_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'custom_router.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {
  Account({Key? key}) : super(key: key); //
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String _theme = "dark";
  _AccountState() {
    _monthlyBalances = [];
    _setBalance();
    _setMontlyBalance();
    CustomPref().getLoginStatus().then((value) {
      if (!value) Navigator.pushNamed(context, loginRoute);
    });
    CustomPref().getOtpStatus().then((value) {
      if (!value) Navigator.pushNamed(context, loginRoute);
    });
  }
  Future<http.Response> fetchAccount() {
    return http.get(Uri.parse('https://rocketbank.commencis.com/accounts'));
  }

  RegExp _reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  void _setMontlyBalance() {
    fetchAccount().then((value) {
      var _temp = jsonDecode(value.body);
      String _fullMonthlyBalances = _temp["monthlyAvailableBalance"].toString();

      _fullMonthlyBalances =
          _fullMonthlyBalances.substring(1, _fullMonthlyBalances.length - 1);
      List<String> _stringListBalances = _fullMonthlyBalances.split(', ');

      setState(() {
        _monthlyBalances = _stringListBalances.map(int.parse).toList();
        _isGraphLoaded = true;
      });
    });
  }

  void _setBalance() {
    fetchAccount().then((value) {
      var _temp = jsonDecode(value.body);
      String _fullBalanceString = _temp["availableBalance"].toString();
      List<String> _parts = _fullBalanceString.split(",");
      late String _whole, _decimal;
      if (_parts.length == 1) {
        _whole = _parts[0];
        _decimal = "00";
      } else {
        _whole = _parts[0];
        _decimal = _parts[1];
      }
      _whole = _whole.replaceAllMapped(_reg, (match) => '${match[1]},');
      _whole = _whole.replaceAll(',', '.');
      setState(() {
        _balance = _whole + ',' + _decimal;
        _balance += " " + _temp["availableBalanceCurrency"].toString();
        _isBalanceLoaded = true;
      });
    });
  }

  //Function _deliminatorFunc = (Match match) => '${match[1]},';
  String _balance = '';
  bool _isBalanceLoaded = false;
  bool _isGraphLoaded = false;
  late List<int> _monthlyBalances;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.account_navigationBar_title),
        centerTitle: true,
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset(
                    'assets/accounts/$_theme/darkThemeIconsFilter.png'),
                onPressed: () {
                  Navigator.pushNamed(context, filterRoute);
                },
              );
            },
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset(
                  'assets/accounts/$_theme/darkThemeIconsSignOut.png'),
              onPressed: () {
                CustomPref().setLoginStatus(false);
                CustomPref().setOtpStatus(false);
                Navigator.pushNamed(context, loginRoute);
              },
            );
          },
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 15.0),
              child: _accountColumn(),
            ),
          ),
        ],
      ),
    );
  }

  Column _accountColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.only(top: 30, left: 15, right: 15),
          child: Container(
            constraints: BoxConstraints(
              minWidth: double.infinity, //TODO
            ),
            child: _slidingCards(),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 16),
          child: Row(
            children: [
              Expanded(
                child: Container(),
              ),
              _pageinatorAnimation(_pageActive),
              Container(
                width: 4,
              ),
              _pageinatorAnimation(!_pageActive),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(
                color: Color.fromRGBO(198, 196, 204, 1),
              ),
            ),
            child: Row(
              children: <Widget>[
                Image.asset('assets/accounts/$_theme/darkThemeIconsSearch.png'),
                _searchField(),
              ],
            ),
          ),
        ),
        _itemList(),
        CupertinoButton(
          child: Text("${StartUpApp.getTheme(context)}"),
          onPressed: () {
            StartUpApp.switchTheme(context);
            Navigator.pushNamed(context, accountRoute);
          },
        ),
      ],
    );
  }

  TextEditingController _searchFieldControler = TextEditingController();
  Flexible _searchField() {
    return Flexible(
      child: TextField(
        controller: _searchFieldControler,
      ),
    );
  }

  Center _centeredCircularProgressBar() {
    return Center(
      child: SizedBox(
        height: 50.0,
        width: 50.0,
        child: CircularProgressIndicator(),
      ),
    );
  }

  List<Widget> _monthListText(BuildContext context, TextStyle textStyle,
      {double spacing: 0.0}) {
    List<Widget> _tempMonthsList = [Expanded(child: Container())];

    List<String> _t = MonthService().lastMonths(context);
    for (var i = 0; i < 6; i++) {
      _tempMonthsList.add(
        Container(
            padding: EdgeInsets.only(left: spacing),
            child: Text(
              _t[i],
              style: textStyle,
            )),
      );
    }
    return _tempMonthsList;
  }

  List<Widget> _graphBars(int upperlimit, double spacing) {
    List<Widget> _ret = [
      Expanded(
        child: Container(),
      )
    ];
    double _barHeight;
    for (var i = 0; i < 6; i++) {
      _barHeight = (MediaQuery.of(context).size.width *
          0.4 *
          (_monthlyBalances[i]) /
          upperlimit);
      _ret.add(
        Container(
          padding: EdgeInsets.only(left: spacing),
          child: Column(
            children: [
              Container(
                width: 28,
                height: MediaQuery.of(context).size.width * 0.4 - _barHeight,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.darkPeriwinkle,
                  borderRadius: BorderRadius.all(
                    Radius.circular(2),
                  ),
                ),
                width: 24,
                height: _barHeight,
              ),
              /**/
            ],
          ),
        ),
      );
    }
    return _ret;
  }

  Widget _itemList() {
    return Padding(
      padding: EdgeInsets.only(top: 8, left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.twilight,
          border: Border.all(
            color: Color.fromRGBO(198, 196, 204, 1),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: _itemTiles(),
      ),
    );
  }

  Widget _tileButton(int id, String name, String amount, String currency) {
    return CupertinoButton(
      color: AppColors.twilight,
      onPressed: () {
        Navigator.pushNamed(context, accountDetailsRoute,
            arguments: {'id': id});
      },
      child: Row(
        children: [
          Container(
            child: Column(
              children: <Widget>[
                Text(name),
                Text("$amount $currency"),
              ],
            ),
          ),
          Expanded(child: Container()),
          Container(
            child: Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                Container(),
                Padding(
                  padding: EdgeInsets.only(left: 1, top: 1),
                  child: Image.asset(
                      "assets/accounts/$_theme/darkThemeIconsChevron.png"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 1, top: 1),
                  child: Image.asset(
                      "assets/accounts/$_theme/darkThemeIconsChevron_2.png"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 1, top: 1),
                  child: Image.asset(
                      "assets/accounts/$_theme/darkThemeIconsChevron_3.png"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 1, top: 1),
                  child: Image.asset(
                      "assets/accounts/$_theme/darkThemeIconsChevron_4.png"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 1, top: 1),
                  child: Image.asset(
                      "assets/accounts/$_theme/darkThemeIconsChevron_5.png"),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 1, top: 1),
                  child: Image.asset(
                      "assets/accounts/$_theme/darkThemeIconsChevron_6.png"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _list = [];

  Widget _itemTiles() {
    List<Widget> _listTemp = [];
    fetchAccount().then(
      (value) {
        Iterable _temp = jsonDecode(value.body)["items"] as List;
        List<AccountItems> _accountItems = List<AccountItems>.from(
            _temp.map((model) => AccountItems.fromJson(model)));
        for (var i = 0; i < _accountItems.length; i++) {
          if (_searchFieldControler.text != "") {
            if (!_accountItems[i].name.contains(_searchFieldControler.text))
              continue;
          }
          _listTemp.add(_tileButton(
              int.parse(_accountItems[i].id),
              "${_accountItems[i].name}",
              "${_accountItems[i].amount}",
              "${_accountItems[i].currency}"));
        }
        setState(() {
          _list = _listTemp;
        });
      },
    );

    return Column(
      children: _list,
    );
  }

  Widget _graph() {
    //print();
    int _max =
        _monthlyBalances.reduce((curr, next) => curr > next ? curr : next);
    int _digit = "$_max".length;
    num _upperLimit = pow(10, _digit);
    if (_upperLimit / 2 > _max) _upperLimit = _upperLimit / 2;

    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            child: Text("Last 6 months", textAlign: TextAlign.left),
          ),
        ),
        Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    child: Text("${(_upperLimit / 1000).round()}K"),
                  ),
                  Container(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColors.darkPeriwinkle,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.20),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    child: Text("${(_upperLimit / 2000).round()}K"),
                  ),
                  Container(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: AppColors.darkPeriwinkle,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.40),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: _graphBars(_upperLimit.toInt(), 25),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: _monthListText(
              context,
              TextStyle(fontSize: 16),
              spacing: 25,
            ),
          ),
        )
      ],
    );
  }

  Widget _pageinatorAnimation(bool _fooBar) {
    return AnimatedContainer(
      width: _fooBar ? 24 : 8,
      height: _fooBar ? 4 : 2,
      child: Container(
        padding: EdgeInsets.only(right: 100),
        color: AppColors.seafoamBlue,
      ),
      duration: Duration(milliseconds: 500),
      curve: Curves.bounceInOut,
    );
  }

  Widget _availableBalance() {
    if (_pageActive)
      return Card(
        child: Container(
          child: _isBalanceLoaded
              ? Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      //padding: EdgeInsets.only(top: 100),
                      child: Text(
                        AppLocalizations.of(context)!.account_available_balance,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        _balance,
                        style: TextStyle(
                          fontSize: 36,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                )
              : _centeredCircularProgressBar(),
          constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: 200,
            maxHeight: 400,
          ),
        ),
      );
    else
      return Card();
  }

  Widget _balanceGraph() {
    if (!_pageActive)
      return Container(
        child: _isGraphLoaded ? _graph() : _centeredCircularProgressBar(),
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: MediaQuery.of(context).size.width * 0.5,
        ),
      );
    else
      return Card();
  }

  bool _pageActive = true;
  CarouselController _slidingCardControler = new CarouselController();

  CarouselSlider _slidingCards() {
    return CarouselSlider(
      carouselController: _slidingCardControler,
      options: CarouselOptions(
        height: MediaQuery.of(context).size.width * 0.50,
        enableInfiniteScroll: false,
        onScrolled: (value) {
          setState(() {
            if (value!.round() == 0)
              _pageActive = true;
            else
              _pageActive = false;
          });
        },
        initialPage: 0,
      ),
      items: [
        _availableBalance(),
        _balanceGraph(),
      ],
    );
  }
}
