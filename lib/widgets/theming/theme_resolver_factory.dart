import '../../helper/enums.dart';
import 'resolver/flat_theme_resolver.dart';
import 'resolver/material_theme_resolver.dart';
import 'resolver/neomorphism_theme_resolver.dart';
import 'resolver/theme_resolver_interface.dart';

class ThemeResolverFactory {
  static IThemeResolver create(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.neomorphism:
        return NeomorphismThemeResolver();
      case ThemeType.flat:
        return FlatThemeResolver();
      case ThemeType.material:
      default:
        return MaterialThemeResolver();
    }
  }
}
