import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../soft/soft_decorations.dart';

@immutable
class CustomThemeData with Diagnosticable {
  final BoxDecoration decoration;
  final BoxDecoration invertedDecoration;

  factory CustomThemeData({
    Brightness? brightness,
    BoxDecoration? decoration,
    BoxDecoration? invertedDecoration,
  }) {
    final isDark = (brightness ?? Brightness.light) == Brightness.dark;
    final boxDecoration = decoration ?? kSoftDecoration(isDark: isDark);
    final invertedBoxDecoration =
        invertedDecoration ?? kSoftInvertedDecoration(isDark: isDark);

    return CustomThemeData.raw(
      decoration: boxDecoration,
      invertedDecoration: invertedBoxDecoration,
    );
  }

  const CustomThemeData.raw({
    required this.decoration,
    required this.invertedDecoration,
  });
}
