import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale; // null means follow system language

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}