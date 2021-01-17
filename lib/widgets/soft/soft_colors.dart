import 'package:flutter/material.dart';

/// Base color for light theme
final Color kSoftLightBackgroundColor = Colors.grey[300];

/// light color for the bottom shadow
final Color kSoftLightBottomShadowColor = Colors.grey[500];

/// light color for the top shadow
const Color kSoftLightTopShadowColor = Colors.white;

/// Base color for dark theme
final Color kSoftDarkBackgroundColor = Colors.grey[850];

/// Dark color for the bottom shadow
final Color kSoftDarkBottomShadowColor = Colors.grey[900];

/// Dark color for the top shadow
const Color kSoftDarkTopShadowColor = Color(0xFF393939); // Colors.grey[800];

/// Color for text in light theme
final Color kSoftLightTextColor = Colors.grey[800];

/// Color for text in dark theme
const Color kSoftDarkTextColor = Colors.white;

Color kSoftButtonColor({@required bool isDark}) {
  assert(isDark != null);

  return isDark ? kSoftDarkBackgroundColor : kSoftLightBackgroundColor;
}

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
