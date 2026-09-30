import 'package:flutter/material.dart';

class FontSizeProvider extends ChangeNotifier {
  double _scaleFactor = 1.0;
  bool _hasUserSetPreference = false;

  double get scaleFactor => _scaleFactor;

  /// Call this when the app initializes or on the first build
  void initForScreenSize(double width) {
    // Only auto-adjust if the user hasn't manually selected a font scale yet
    if (!_hasUserSetPreference) {
      if (width < 600) {
        _scaleFactor = 1.25; // Default to larger font on mobile
      } else {
        _scaleFactor = 1.0;  // Standard font on desktop/tablet
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