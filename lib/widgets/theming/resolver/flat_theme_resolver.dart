import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../custom_theme_data.dart';
import 'theme_resolver_interface.dart';

class FlatThemeResolver {
  ResolvedTheme resolve(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final theme = isDark ? _kDarkTheme : _kLightTheme;
    final customTheme = CustomThemeData(
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark
              ? CupertinoColors.secondarySystemGroupedBackground.darkColor
              : CupertinoColors.systemGroupedBackground.color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
        color: isDark
            ? CupertinoColors.secondarySystemGroupedBackground.darkColor
            : CupertinoColors.systemGroupedBackground.color,
      ),
      invertedDecoration: BoxDecoration(
        border: Border.all(
          color: isDark
              ? CupertinoColors.secondarySystemGroupedBackground.darkColor
              : CupertinoColors.systemGroupedBackground.color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    return ResolvedTheme(theme, customTheme);
  }
}

final _kDarkTextColor = Colors.grey[200];
final _kLighTextColor = Colors.grey[850];

final _baseDarkTheme = ThemeData.dark();

ThemeData get _kDarkTheme {
  final defaultTextTheme =
      Typography.material2018(platform: defaultTargetPlatform).black;

  return _baseDarkTheme.copyWith(
    scaffoldBackgroundColor: Colors.black,
    canvasColor: Colors.black,
    colorScheme: _baseDarkTheme.colorScheme.copyWith(
      secondary: _kDarkTextColor,
    ),
    iconTheme: IconThemeData(
      color: _kDarkTextColor,
    ),
    textTheme: defaultTextTheme.apply(
      bodyColor: _kDarkTextColor,
      displayColor: _kDarkTextColor,
      fontFamily: 'Consolas',
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: _kDarkTextColor,
      activeTickMarkColor: _kDarkTextColor,
      thumbColor: _kDarkTextColor,
      disabledInactiveTrackColor: _kDarkTextColor?.withAlpha(0x1f),
      inactiveTrackColor: _kDarkTextColor?.withAlpha(0x1f),
      inactiveTickMarkColor: _kDarkTextColor?.withAlpha(0x8a),
      overlayColor: _kDarkTextColor?.withAlpha(0x1f),
    ),
  );
}

final _baseLightTheme = ThemeData.light();

ThemeData get _kLightTheme {
  final defaultTextTheme =
      Typography.material2018(platform: defaultTargetPlatform).white;

  return _baseLightTheme.copyWith(
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    colorScheme: _baseLightTheme.colorScheme.copyWith(
      secondary: _kLighTextColor,
    ),
    iconTheme: IconThemeData(
      color: _kLighTextColor,
    ),
    textTheme: defaultTextTheme.apply(
      bodyColor: _kLighTextColor,
      displayColor: _kLighTextColor,
      fontFamily: 'Consolas',
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: _kLighTextColor,
      activeTickMarkColor: _kLighTextColor,
      thumbColor: _kLighTextColor,
      disabledInactiveTrackColor: _kLighTextColor?.withAlpha(0x1f),
      inactiveTrackColor: _kLighTextColor?.withAlpha(0x1f),
      inactiveTickMarkColor: _kLighTextColor?.withAlpha(0x8a),
      overlayColor: _kLighTextColor?.withAlpha(0x1f),
    ),
  );
}
