import 'package:flutter/material.dart';

import '../constants/theme_constants.dart';

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

    return Theme(
      data: useComplemtaryTheme ? (isDark ? lightTheme : darkTheme) : theme,
      child: Builder(
        builder: (context) => Container(
          color: Theme.of(context).canvasColor,
          child: SafeArea(
            child: child,
          ),
        ),
      ),
    );
  }
}
