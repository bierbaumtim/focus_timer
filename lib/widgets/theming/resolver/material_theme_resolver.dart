import 'package:flutter/material.dart';

import '../custom_theme_data.dart';
import 'theme_resolver_interface.dart';

class MaterialThemeResolver implements IThemeResolver {
  @override
  ResolvedTheme resolve(Brightness brightness) {
    final theme = ThemeData(brightness: brightness);
    final customTheme = CustomThemeData(
      brightness: brightness,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
      invertedDecoration: BoxDecoration(
        border: Border.all(
          color: theme.dividerColor,
        ),
      ),
    );

    return ResolvedTheme(theme, customTheme);
  }
}
