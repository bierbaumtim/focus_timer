import 'package:flutter/material.dart';
import 'package:focus_timer/widgets/soft/soft_shadows.dart';

import 'soft_colors.dart';

class SoftContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final double radius;
  final bool useDarkTheme;

  const SoftContainer({
    Key key,
    this.width,
    this.height,
    this.radius,
    this.child,
    this.useDarkTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: (useDarkTheme ?? isDark)
            ? kSoftDarkBackgroundColor
            : kSoftLightBackgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(radius ?? 40),
        ),
        boxShadow: <BoxShadow>[
          kSoftBottomContainerShadow((useDarkTheme ?? isDark)),
          kSoftTopContainerShadow((useDarkTheme ?? isDark)),
        ],
      ),
      child: child,
    );
  }
}
