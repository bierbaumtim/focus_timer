import 'package:flutter/material.dart';

final Color kSoftLightBackgroundColor = Colors.grey[300];
final Color kSoftLightBottomShadowColor = Colors.grey[500];
final Color kSoftLightTopShadowColor = Colors.white;

final Color kSoftDarkBackgroundColor = Colors.grey[850];
final Color kSoftDarkBottomShadowColor = Colors.grey[900];
const Color kSoftDarkTopShadowColor = Color(0xFF393939); // Colors.grey[800];

final Color kSoftLightTextColor = Colors.grey[800];
final Color kSoftDarkTextColor = Colors.white;

Color kSoftButtonColor(bool isDark) =>
    isDark ? kSoftDarkBackgroundColor : kSoftLightBackgroundColor;

final LinearGradient kSoftLightGradient = LinearGradient(
  colors: <Color>[
    Colors.grey[200],
    Colors.grey[300],
    Colors.grey[400],
    Colors.grey[500],
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: const <double>[
    0.1,
    0.3,
    0.8,
    0.9,
  ],
);

final LinearGradient kSoftDarkGradient = LinearGradient(
  colors: <Color>[
    const Color(0xFF393939),
    Colors.grey[800],
    Colors.grey[850],
    Colors.grey[900],
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: const <double>[
    0.1,
    0.3,
    0.8,
    0.9,
  ],
);
