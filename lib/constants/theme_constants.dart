import 'package:flutter/material.dart';

import '../widgets/soft/soft_colors.dart';

List<Shadow> lightTextShadow = <Shadow>[
  Shadow(
    color: Colors.grey[500],
    offset: const Offset(5.0, 5.0),
    blurRadius: 15.0,
  ),
  Shadow(
    color: Colors.white,
    offset: const Offset(-5.0, -5.0),
    blurRadius: 15.0,
  ),
];

List<Shadow> darkTextShadow = <Shadow>[
  Shadow(
    color: Colors.grey[900],
    offset: const Offset(5.0, 5.0),
    blurRadius: 15.0,
  ),
  Shadow(
    color: Colors.grey[800],
    offset: const Offset(-5.0, -5.0),
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
        title: lightTextStyle,
        subtitle: lightTextStyle,
        subhead: lightTextStyle,
        button: lightTextStyle,
        caption: lightTextStyle,
        overline: lightTextStyle,
        headline: lightTextStyle,
        body1: lightTextStyle,
        body2: lightTextStyle,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: kSoftLightTextColor,
        activeTickMarkColor: kSoftLightTextColor,
        thumbColor: kSoftLightTextColor,
        inactiveTrackColor: kSoftLightTextColor.withAlpha(0x1f),
        disabledInactiveTrackColor: kSoftLightTextColor.withAlpha(0x1f),
        inactiveTickMarkColor: kSoftLightTextColor.withAlpha(0x8a),
        overlayColor: kSoftLightTextColor.withAlpha(0x1f),
      ),
    );

ThemeData get darkTheme => ThemeData(
      brightness: Brightness.dark,
      accentColor: kSoftDarkTextColor,
      iconTheme: IconThemeData(
        color: kSoftDarkTextColor,
      ),
      textTheme: TextTheme(
        title: darkTextStyle,
        subtitle: darkTextStyle,
        subhead: darkTextStyle,
        button: darkTextStyle,
        caption: darkTextStyle,
        overline: darkTextStyle,
        headline: darkTextStyle,
        body1: darkTextStyle,
        body2: darkTextStyle,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: kSoftDarkTextColor,
        activeTickMarkColor: kSoftDarkTextColor,
        thumbColor: kSoftDarkTextColor,
        disabledInactiveTrackColor: kSoftDarkTextColor.withAlpha(0x1f),
        inactiveTrackColor: kSoftDarkTextColor.withAlpha(0x1f),
        inactiveTickMarkColor: kSoftDarkTextColor.withAlpha(0x8a),
        overlayColor: kSoftDarkTextColor.withAlpha(0x1f),
      ),
    );

TextStyle lightTextStyle = TextStyle(
  shadows: lightTextShadow,
  color: kSoftLightTextColor,
  fontFamily: 'Consolas',
);

TextStyle darkTextStyle = TextStyle(
  shadows: darkTextShadow,
  color: kSoftDarkTextColor,
  fontFamily: 'Consolas',
);
