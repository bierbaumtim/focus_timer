import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class CustomThemeData with Diagnosticable {
  final BoxDecoration decoration;
  final BoxDecoration invertedDecoration;

  const CustomThemeData({
    required this.decoration,
    required this.invertedDecoration,
  });
}
