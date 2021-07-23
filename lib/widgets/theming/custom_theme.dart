import 'package:flutter/widgets.dart';

import 'custom_theme_data.dart';

class CustomTheme extends InheritedWidget {
  const CustomTheme({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);
  final CustomThemeData data;

  static CustomThemeData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomTheme>()?.data;
  }

  @override
  bool updateShouldNotify(CustomTheme oldWidget) =>
      oldWidget.data != data || oldWidget.child != child;
}
