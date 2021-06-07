import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('tr'),
  ];
}

class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;
  final String symbol;

  Language(this.id, this.flag, this.name, this.languageCode, this.symbol);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "en", "EN"),
      Language(2, "🇹🇷", "Turkish", "tr", "TR"),
    ];
  }
}
