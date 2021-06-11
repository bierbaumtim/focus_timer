import 'package:flutter/material.dart';

import '../custom_theme_data.dart';

// ignore: one_member_abstracts
abstract class IThemeResolver {
  ResolvedTheme resolve(Brightness brightness);
}

class ResolvedTheme {
  final ThemeData theme;
  final CustomThemeData customTheme;

  const ResolvedTheme(this.theme, this.customTheme);
}
