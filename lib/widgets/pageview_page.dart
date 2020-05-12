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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Theme(
      data: useComplemtaryTheme
          ? (isDark ? lightTheme : darkTheme)
          : Theme.of(context),
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
