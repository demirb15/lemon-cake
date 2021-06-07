class AccountItems {
  late String id;
  late String name;
  late int amount;
  late String currency;

  AccountItems(
      {required this.id,
      required this.name,
      required this.amount,
      required this.currency});

  AccountItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    return data;
  }
}
