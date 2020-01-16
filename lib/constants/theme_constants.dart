import 'package:flutter/material.dart';

import 'package:focus_timer/widgets/soft/soft_colors.dart';

List<Shadow> lightTextShadow = <Shadow>[
  Shadow(
    color: Colors.grey[500],
    offset: Offset(5.0, 5.0),
    blurRadius: 15.0,
  ),
  Shadow(
    color: Colors.white,
    offset: Offset(-5.0, -5.0),
    blurRadius: 15.0,
  ),
];

List<Shadow> darkTextShadow = <Shadow>[
  Shadow(
    color: Colors.grey[900],
    offset: Offset(5.0, 5.0),
    blurRadius: 15.0,
  ),
  Shadow(
    color: Colors.grey[800],
    offset: Offset(-5.0, -5.0),
    blurRadius: 15.0,
  ),
];

ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      canvasColor: kSoftLightBackgroundColor,
      accentColor: kSoftLightTextColor,
      iconTheme: IconThemeData(
        color: kSoftLightTextColor,
      ),
      textTheme: TextTheme(
        title: TextStyle(
          shadows: lightTextShadow,
          color: kSoftLightTextColor,
        ),
      ),
    );

ThemeData get darkTheme => ThemeData(
      brightness: Brightness.dark,
      accentColor: kSoftDarkTextColor,
      iconTheme: IconThemeData(
        color: kSoftDarkTextColor,
      ),
      textTheme: TextTheme(
        title: TextStyle(
          shadows: darkTextShadow,
          color: kSoftDarkTextColor,
        ),
      ),
    );
