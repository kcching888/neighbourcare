import 'package:flutter/material.dart';

class FontSizeProvider extends ChangeNotifier {
  double _scaleFactor = 1.0;
  bool _hasUserSetPreference = false;

  double get scaleFactor => _scaleFactor;

  /// Call this when the app initializes or on the first build
void initForScreenSize(double width) {
  if (!_hasUserSetPreference) {
    if (width < 480) {
      _scaleFactor = 1.40; // 40% boost for compact mobile screens
    } else if (width < 768) {
      _scaleFactor = 1.25; // Moderate boost for small tablets / phablets
    } else {
      _scaleFactor = 1.0;  // Standard for desktop/tablet landscape
    }
    notifyListeners();
  }
}

  void setScaleFactor(double newScale) {
    _scaleFactor = newScale;
    _hasUserSetPreference = true; // Lock in user manual override
    notifyListeners();
  }
}