import 'package:flutter/material.dart';

import '../settings/theme_switch.dart';

class SoftAppBar extends StatelessWidget {
  const SoftAppBar({
    Key? key,
    this.centerWidget,
    this.titleStyle,
    this.height = kToolbarHeight,
  }) : super(key: key);

  final TextStyle? titleStyle;
  final double height;
  final Widget? centerWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final topPadding = MediaQuery.of(context).padding.top;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        color: theme.canvasColor,
        height: height,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, topPadding + 8, 24, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Focus Timer',
                style: titleStyle ?? theme.textTheme.headline6!,
              ),
              if (centerWidget != null) Expanded(child: centerWidget!),
              ThemeSwitch(),
            ],
          ),
        ),
      ),
    );
  }
}
