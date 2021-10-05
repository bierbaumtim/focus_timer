import 'package:flutter/material.dart';

import '../custom_theme_data.dart';

class ResolvedTheme {
  final ThemeData theme;
  final CustomThemeData customTheme;

  const ResolvedTheme(this.theme, this.customTheme);
}
