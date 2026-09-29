import 'package:flutter/material.dart';

class FontSizeProvider extends ChangeNotifier {
  double _scaleFactor = 1.0; // 1.0 = Normal, 1.15 = Large, 1.3 = Extra Large

  double get scaleFactor => _scaleFactor;

  void setScaleFactor(double factor) {
    if (_scaleFactor != factor) {
      _scaleFactor = factor;
      notifyListeners();
    }
  }
}