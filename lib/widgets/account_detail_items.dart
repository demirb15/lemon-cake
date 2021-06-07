class AccountDetailItems {
  late String id;
  late String name;
  late String amount;
  late String currency;
  late String customerName;
  late String customerLastName;
  late String customerCity;
  late String customerCountry;
  late String accountNo;
  late String iban;

  AccountDetailItems(
      {required this.id,
      required this.name,
      required this.amount,
      required this.currency,
      required this.customerName,
      required this.customerLastName,
      required this.customerCity,
      required this.customerCountry,
      required this.accountNo,
      required this.iban});

  AccountDetailItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    currency = json['currency'];
    customerName = json['customerName'];
    customerLastName = json['customerLastName'];
    customerCity = json['customerCity'];
    customerCountry = json['customerCountry'];
    accountNo = json['accountNo'];
    iban = json['iban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['customerName'] = this.customerName;
    data['customerLastName'] = this.customerLastName;
    data['customerCity'] = this.customerCity;
    data['customerCountry'] = this.customerCountry;
    data['accountNo'] = this.accountNo;
    data['iban'] = this.iban;
    return data;
  }
}
