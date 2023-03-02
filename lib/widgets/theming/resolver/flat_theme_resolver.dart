import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_theme_data.dart';
import 'theme_resolver_interface.dart';

class FlatThemeResolver {
  ResolvedTheme resolve(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme =
        isDark ? const ColorScheme.dark() : const ColorScheme.light();

    final theme = ThemeData.from(colorScheme: colorScheme, useMaterial3: true);

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
