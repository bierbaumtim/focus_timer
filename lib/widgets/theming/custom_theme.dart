import 'package:flutter/widgets.dart';

import 'custom_theme_data.dart';

class CustomTheme extends InheritedWidget {
  const CustomTheme({
    super.key,
    required super.child,
    required this.data,
  });
  final CustomThemeData data;

  static CustomThemeData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomTheme>()?.data;
  }

  @override
  bool updateShouldNotify(CustomTheme oldWidget) =>
      oldWidget.data != data || oldWidget.child != child;
}
