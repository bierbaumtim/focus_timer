import 'package:flutter/material.dart';

import '../../../constants/theme_constants.dart';
import '../custom_theme_data.dart';
import 'theme_resolver_interface.dart';

class NeomorphismThemeResolver implements IThemeResolver {
  @override
  ResolvedTheme resolve(Brightness brightness) {
    final theme = brightness == Brightness.dark ? darkTheme : lightTheme;
    final customTheme = CustomThemeData(brightness: brightness);

    return ResolvedTheme(theme, customTheme);
  }
}
