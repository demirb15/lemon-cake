import 'dart:convert';

import 'package:flutter_template/widgets/account_detail_items.dart';
import 'package:http/http.dart' as http;

import 'account_items.dart';

class HttpService {
  final String _jsonUrl = "https://rocketbank.commencis.com/";
  RegExp _reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  Future<http.Response> fetchAccount() {
    return http.get(Uri.parse('${_jsonUrl}accounts'));
  }

  Future<http.Response> fetchAccountDetails(int id) {
    return http.get(Uri.parse('${_jsonUrl}accountDetail?id=$id'));
  }

  Future<List<int>> getBalanceMonthly() async {
    var _httpResponse = await fetchAccount();
    var _body = jsonDecode(_httpResponse.body);
    String _monthlyBalances = _body["monthlyAvailableBalance"].toString();
    _monthlyBalances =
        _monthlyBalances.substring(1, _monthlyBalances.length - 1);
    List<String> _stringListBalances = _monthlyBalances.split(', ');
    List<int> _ret = _stringListBalances.map(int.parse).toList();
    //print(_stringListBalances);
    return _ret;
  }

  Future<List<AccountItems>> getBalanceItems() async {
    var _httpResponse = await fetchAccount();
    Iterable _body = jsonDecode(_httpResponse.body)["items"] as List;
    List<AccountItems> _accountItems = List<AccountItems>.from(
        _body.map((model) => AccountItems.fromJson(model)));

    return _accountItems;
  }

  Future<String> getBalance() async {
    var _httpResponse = await fetchAccount();
    var _body = jsonDecode(_httpResponse.body);
    String _fullBalanceString = _body["availableBalance"].toString();
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
    String _balance = _whole + ',' + _decimal;
    _balance += " " + _body["availableBalanceCurrency"].toString();
    return _balance;
  }

  Future<AccountDetailItems> getAccountDetails(int id) async {
    var _httpResponse = await fetchAccountDetails(id);
    var _body = jsonDecode(_httpResponse.body);
    AccountDetailItems _accountDetailItem = AccountDetailItems.fromJson(_body);
    return _accountDetailItem;
  }

  Future<void> updateBalance(int id, double amount) async {
    /*final _url = Uri.parse("${_jsonUrl}accountDetail?id=$id");
    final headers = {"Content-type": "application/json"};
    final json = '{"amount": "$amount"}';
    await http.patch(_url, headers: headers, body: json);*/
  }
}
