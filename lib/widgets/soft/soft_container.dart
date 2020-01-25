import 'package:flutter/material.dart';

import 'package:focus_timer/widgets/soft/soft_decorations.dart';

class SoftContainer extends StatelessWidget {
  final Widget child;
  final double radius;
  final bool useDarkTheme;
  final bool inverted;
  BoxConstraints constraints;

  SoftContainer({
    Key key,
    double width,
    double height,
    this.radius,
    this.child,
    this.useDarkTheme,
    this.inverted = false,
    BoxConstraints constraints,
  })  : constraints = (width != null || height != null)
            ? constraints?.tighten(width: width, height: height) ??
                BoxConstraints.tightFor(width: width, height: height)
            : constraints,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      constraints: constraints,
      decoration: inverted
          ? kSoftInvertedDecoration(useDarkTheme ?? isDark, radius)
          : kSoftDecoration(useDarkTheme ?? isDark, radius),
      child: child,
    );
  }
}
