import 'package:flutter/widgets.dart';

import 'custom_theme_data.dart';

class CustomTheme extends InheritedWidget {
  CustomTheme({
    Key? key,
    required this.child,
    required this.data,
  }) : super(key: key, child: child);

  final Widget child;
  final CustomThemeData data;

  static CustomThemeData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomTheme>()?.data;
  }

  @override
  bool updateShouldNotify(CustomTheme oldWidget) =>
      oldWidget.data != data || oldWidget.child != child;
}
