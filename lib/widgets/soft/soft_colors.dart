import 'package:flutter/material.dart';

final Color kSoftLightBackgroundColor = Colors.grey[300];
final Color kSoftLightBottomShadowColor = Colors.grey[500];
final Color kSoftLightTopShadowColor = Colors.white;

final Color kSoftDarkBackgroundColor = Colors.grey[850];
final Color kSoftDarkBottomShadowColor = Colors.grey[900];
final Color kSoftDarkTopShadowColor = Color(0xFF393939); // Colors.grey[800];

final Color kSoftLightTextColor = Colors.grey[800];
final Color kSoftDarkTextColor = Colors.white;

Color kSoftButtonColor(bool isDark) =>
    isDark ? kSoftDarkBackgroundColor : kSoftLightBackgroundColor;
