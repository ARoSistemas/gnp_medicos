import 'dart:math' as math;

import 'package:flutter/widgets.dart';

enum ScaleAxis {
  width,
  height,
}

extension ResponsiveSizeExtension on BuildContext {
  static const int _designReference = 375;
  static const double _lowerLimit = 0.9;
  static const double _upperLimit = 1.2;

  double scale(double px, {ScaleAxis axis = ScaleAxis.width}) {
    final Size size = MediaQuery.of(this).size;
    final double dimension = axis == ScaleAxis.width ? size.width : size.height;
    return (dimension / _designReference).clamp(_lowerLimit, _upperLimit) * px;
  }

  /// Returns a percentage of the screen width.
  ///
  /// **Parameters**:
  /// - `percent` (double): The percentage of the width.
  ///
  /// **Returns**:
  /// - `double`: The calculated width.
  double pWidth(double percent, {double? width, double? pxMin, double? pxMax}) {
    final double widthTmp = width ?? MediaQuery.of(this).size.width;

    if (pxMin != null && pxMax != null) {
      return (widthTmp * percent / 100).clamp(pxMin, pxMax);
    }
    return widthTmp * percent / 100;
  }

  /// Returns a percentage of the screen height.
  ///
  /// **Parameters**:
  /// - `percent` (double): The percentage of the height.
  ///
  /// **Returns**:
  /// - `double`: The calculated height.
  double pHeight(
    double percent, {
    double? height,
    double? pxMin,
    double? pxMax,
  }) {
    final double heightTmp = height ?? MediaQuery.of(this).size.height;

    if (pxMin != null && pxMax != null) {
      return (heightTmp * percent / 100).clamp(pxMin, pxMax);
    }
    return heightTmp * percent / 100;
  }

  /// Returns a percentage of the diagonal screen measurement.
  ///
  /// **Parameters**:
  /// - `percent` (double): The percentage of the diagonal measurement.
  ///
  /// **Returns**:
  /// - `double`:
  /// The calculated text size based on the diagonal screen measurement.
  double pText(double percent, {Size? size, double? pxMin, double? pxMax}) {
    final Size sizeTmp = size ?? MediaQuery.of(this).size;
    final double diagonal = math.sqrt(
      math.pow(sizeTmp.width, 2) + math.pow(sizeTmp.height, 2),
    );

    if (pxMin != null && pxMax != null) {
      return (diagonal * (percent / 10) / 100).clamp(pxMin, pxMax);
    }

    return diagonal * ((percent / 10) / 100);
  }
}
