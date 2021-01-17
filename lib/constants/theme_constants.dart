import 'package:flutter/material.dart';

import '../widgets/soft/soft_colors.dart';

List<Shadow> lightTextShadow = <Shadow>[
  Shadow(
    color: Colors.grey[500],
    offset: const Offset(5.0, 5.0),
    blurRadius: 10.0,
  ),
  const Shadow(
    color: Colors.white,
    offset: Offset(-5.0, -5.0),
    blurRadius: 10.0,
  ),
];

List<Shadow> darkTextShadow = <Shadow>[
  Shadow(
    color: Colors.grey[900],
    offset: const Offset(5.0, 5.0),
    blurRadius: 10.0,
  ),
  Shadow(
    color: Colors.grey[800],
    offset: const Offset(-5.0, -5.0),
    blurRadius: 10.0,
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
        headline6: lightTextStyle,
        subtitle2: lightTextStyle,
        subtitle1: lightTextStyle,
        button: lightTextStyle,
        caption: lightTextStyle,
        overline: lightTextStyle,
        headline5: lightTextStyle,
        bodyText2: lightTextStyle,
        bodyText1: lightTextStyle,
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
      iconTheme: const IconThemeData(
        color: kSoftDarkTextColor,
      ),
      textTheme: TextTheme(
        headline6: darkTextStyle,
        subtitle2: darkTextStyle,
        subtitle1: darkTextStyle,
        button: darkTextStyle,
        caption: darkTextStyle,
        overline: darkTextStyle,
        headline5: darkTextStyle,
        bodyText2: darkTextStyle,
        bodyText1: darkTextStyle,
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
