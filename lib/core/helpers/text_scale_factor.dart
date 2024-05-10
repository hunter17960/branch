import 'package:flutter/material.dart';

class ScaleSize {
  static double textScaleFactorLandscape(BuildContext context,
      {double maxTextScaleFactor = 1.2}) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1400) {
      double val = 2;
      return val;
    } else if (width > 1000) {
      double val = 1.6;
      return val;
    } else if (width < 800) {
      double val = 0.8;
      return val;
    } else {
      return 1;
    }
  }

  static double textScaleFactorPortrait(BuildContext context,
      {double maxTextScaleFactor = 1.2}) {
    final width = MediaQuery.of(context).size.width;
    if (width > 600) {
      double val = 1.6;
      return val;
    } else {
      return 1;
    }
  }
}
