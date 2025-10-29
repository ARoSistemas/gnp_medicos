import 'package:flutter/material.dart';

extension FontSizeExtension on BuildContext {
  static const int const1 = 375;
  static const double lowerLimit = 0.9;
  static const double upperLimit = 1.2;

  double fontSize(double px) {
    final double scale = (MediaQuery.of(this).size.width / const1).clamp(
      lowerLimit,
      upperLimit,
    );
    return px * scale;
  }
}
