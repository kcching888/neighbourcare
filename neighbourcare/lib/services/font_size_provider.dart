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

  // Inside FontSizeProvider class in lib/services/font_size_provider.dart

void initForScreenSize(double screenWidth) {
  if (screenWidth < 600) {
    _scaleFactor = 0.9;
  } else if (screenWidth > 1200) {
    _scaleFactor = 1.1;
  } else {
    _scaleFactor = 1.0;
  }
  notifyListeners();
}
}

