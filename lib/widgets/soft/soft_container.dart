import 'package:flutter/material.dart';

import 'soft_decorations.dart';

/// {@template softcontainer}
/// A Container which implements the Neomorphism design.
///
/// It's the root widget for widgets which also implements Neomorphism design
/// {@endtemplate}
class SoftContainer extends StatelessWidget {
  /// The [child] contained by the container.
  final Widget child;

  /// The radius to apply to the [container].
  final double radius;

  /// Forces the Widget to use dark decoration.
  final bool useDarkTheme;

  /// Indicates if the depth effect is inverted.
  final bool inverted;

  ///The constraints to apply to the [child].
  final BoxConstraints constraints;

  /// {@macro softcontainer}
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
          ? kSoftInvertedDecoration(
              isDark: useDarkTheme ?? isDark,
              radius: radius,
            )
          : kSoftDecoration(
              isDark: useDarkTheme ?? isDark,
              radius: radius,
            ),
      child: child,
    );
  }
}
