import 'package:flutter/material.dart';

extension TextStyleX on TextStyle {
  TextStyle colorWithOpacity(double opacity) => copyWith(
        color: color.withOpacity(opacity),
      );
}
