import 'package:flutter/material.dart';

import 'package:focus_timer/constants/theme_constants.dart';

class Page extends StatelessWidget {
  final bool useComplemtaryTheme;
  final Widget child;

  const Page({
    Key key,
    this.useComplemtaryTheme = false,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final background = useComplemtaryTheme
        ? (isDark ? lightTheme.canvasColor : darkTheme.canvasColor)
        : theme.canvasColor;

    return Theme(
      data: useComplemtaryTheme ? (isDark ? lightTheme : darkTheme) : theme,
      child: Container(
        color: background,
        child: child,
      ),
    );
  }
}
