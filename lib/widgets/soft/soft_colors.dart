import 'package:flutter/material.dart';

final kSoftLightBackgroundColor = Colors.grey[300];
final kSoftLightBottomShadowColor = Colors.grey[500];
final kSoftLightTopShadowColor = Colors.white;

final kSoftDarkBackgroundColor = Colors.grey[850];
final kSoftDarkBottomShadowColor = Colors.grey[900];
final kSoftDarkTopShadowColor = Colors.grey[800];

final kSoftLightTextColor = Colors.grey[800];
final kSoftDarkTextColor = Colors.white;

Color kSoftButtonColor(isDark) =>
    isDark ? kSoftDarkBackgroundColor : kSoftLightBackgroundColor;
