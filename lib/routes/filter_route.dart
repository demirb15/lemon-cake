import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/theme/appColors.dart';
import 'package:flutter_template/widgets/month_ser.dart';
import 'package:flutter_template/widgets/pref_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/widgets/currency.dart';
import 'custom_router.dart';

class Filter extends StatefulWidget {
  Filter({Key? key}) : super(key: key); //
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<bool> _currencyIsActive = [];
  List<Widget> _currencyToggleList = [];
  int _activeIndex = 0;
  _FilterState() {
    _startTime = DateTime.now();
    _endTime = DateTime.now();

    for (var i = 0; i < Currency().currencies().length; i++) {
      _currencyIsActive.add(false);
      _currencyToggleList.add(Container());
    }

    CustomPref().getLoginStatus().then((value) {
      if (!value)
        Navigator.of(context).pushNamedAndRemoveUntil(
            loginRoute, (Route<dynamic> route) => false);
    });
    CustomPref().getOtpStatus().then((value) {
      if (!value)
        Navigator.of(context).pushNamedAndRemoveUntil(
            loginRoute, (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _arguments = ModalRoute.of(context)!.settings.arguments as Map;
    if (_activeIndex == 0 && !_reseted) {
      _activeIndex = _arguments['index'];
    }
    _currencyIsActive[_activeIndex] = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.filter_navigationBar_title),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Container(
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Image.asset('assets/filter/icClose.png'),
                    Image.asset('assets/filter/darkThemeIconsCross.png'),
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
      body: Stack(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15.0),
              child: _filterColumn(),
            ),
          ),
        ],
      ),
    );
  }

  Column _filterColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 30, bottom: 30),
          child: Text(
            AppLocalizations.of(context)!.filter_currency,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        _currencyFilter(),
        Expanded(child: Container()),
        Container(
          padding: EdgeInsets.only(bottom: 30),
          child: Center(
            child: Text(
              "Date",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
        _selectDate(),
        Expanded(child: Container()),
        TextButton(
          onPressed: () {
            setState(() {
              _startTime = DateTime.now();
              _endTime = DateTime.now();
              setToggleActive(0);
            });
          },
          child: Text("clean filters"),
        ),
        _saveFilterButton(),
      ],
    );
  }

  Widget _expandedCell(Widget w) {
    return Expanded(
      child: Center(
        child: w,
      ),
    );
  }

  Future<DateTime> _datePicker(BuildContext context) async {
    final DateTime pickedDate = (await showDatePicker(
            context: context,
            initialDate: _startTime,
            firstDate: DateTime(2015),
            lastDate: DateTime.now())) ??
        DateTime.now();
    return pickedDate;
  }

  Widget _expandedColumn(Widget w1, Widget w2) {
    return Expanded(
      child: Column(
        children: [
          _expandedCell(w1),
          _expandedCell(w2),
        ],
      ),
    );
  }

  late DateTime _startTime;
  late DateTime _endTime;
  Widget _startDatePicker() {
    return Row(
      children: [
        _dateDecorator(_startTime),
        Expanded(
          child: Container(
            height: 1,
          ),
        ),
        IconButton(
          icon: Image.asset('assets/filter/darkThemeIconsCalendar.png'),
          onPressed: () {
            setState(() {
              _datePicker(context).then((value) => _startTime = value);
            });
          },
        ),
      ],
    );
  }

  Widget _endDatePicker() {
    return Row(
      children: [
        _dateDecorator(_endTime),
        Expanded(
          child: Container(
            height: 1,
          ),
        ),
        IconButton(
          icon: Image.asset('assets/filter/darkThemeIconsCalendar.png'),
          onPressed: () {
            setState(() {
              _datePicker(context).then((value) => _endTime = value);
            });
          },
        ),
      ],
    );
  }

  Widget _datePickerDecoration(Widget _datepicker) {
    return Container(
      width: 180 * MediaQuery.of(context).size.width / 480,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 1,
          ),
          Expanded(child: _datepicker),
          Container(
            width: 8,
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget _dateDecorator(DateTime _date) {
    final String _month = MonthService().getMonth(context, _date.month);
    return Text("$_month ${_date.day}, ${_date.year}");
  }

  Widget _selectDate() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Container(
        child: Row(
          children: [
            _expandedColumn(
              Text(
                AppLocalizations.of(context)!.filter_date_startDate,
                style: TextStyle(fontSize: 24),
              ),
              _datePickerDecoration(_startDatePicker()),
            ),
            _expandedColumn(
              Text(
                AppLocalizations.of(context)!.filter_date_startDate,
                style: TextStyle(fontSize: 24),
              ),
              _datePickerDecoration(_endDatePicker()),
            ),
          ],
        ),
        height: 200 * MediaQuery.of(context).size.height / 830,
        decoration: BoxDecoration(
          color: AppColors.twilight,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        constraints: BoxConstraints(
          maxWidth: double.infinity,
        ),
      ),
    );
  }

  Widget _saveFilterButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
      child: Container(
        constraints: BoxConstraints.expand(
            width: double.infinity,
            height: 50 * MediaQuery.of(context).size.height / 830),
        child: CupertinoButton(
          child: Text(
            AppLocalizations.of(context)!.filter_save,
          ),
          onPressed: () {
            var index = _currencyIsActive.indexOf(true);
            String _curr = Currency().currencies()[index];
            Navigator.popAndPushNamed(context, accountRoute,
                arguments: {'currency': _curr});
          },
          color: AppColors.darkPeriwinkle,
          disabledColor: AppColors.darkPeriwinkle,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }

  bool _reseted = false;
  void setToggleActive(int index) {
    setState(() {
      _activeIndex = index;
      _reseted = true;
      for (var i = 0; i < Currency().currencies().length; i++) {
        _currencyIsActive[i] = false;
      }
      _currencyIsActive[index] = true;
    });
  }

  Widget _currencyFilter() {
    List<Widget> _retList = [];
    final _lenght = Currency().currencies().length;
    for (var i = 0; i < _lenght; i++) {
      _retList.add(
        Container(
          width: (MediaQuery.of(context).size.width - 40) / _lenght,
          height: 40 * MediaQuery.of(context).size.height / 830,
          padding: EdgeInsets.only(left: 3, right: 3),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
              backgroundColor: _currencyIsActive[i]
                  ? AppColors.darkPeriwinkle
                  : AppColors.dark,
              side: BorderSide(
                width: 2,
                color: AppColors.darkPeriwinkle,
              ),
            ),
            child: Text(Currency().currencies()[i], textAlign: TextAlign.right),
            onPressed: () {
              setToggleActive(i);
              _activeIndex = i;
            },
          ),
        ),
      );
    }
    setState(() {
      _currencyToggleList = _retList;
    });
    return Container(
      padding: EdgeInsets.only(top: 24, left: 15, right: 15),
      child: Row(
        children: _currencyToggleList,
      ),
    );
  }
}
