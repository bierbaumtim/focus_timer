import 'package:flutter/material.dart';

import '../theming/custom_theme.dart';

/// {@template softcontainer}
/// A Container which implements the Neomorphism design.
///
/// It's the root widget for widgets which also implements Neomorphism design
/// {@endtemplate}
class CustomContainer extends StatelessWidget {
  /// The [child] contained by the container.
  final Widget? child;

  /// The radius to apply to the [container].
  final double? radius;

  /// Indicates if the depth effect is inverted.
  final bool inverted;

  ///The constraints to apply to the [child].
  final BoxConstraints? constraints;

  /// {@macro softcontainer}
  CustomContainer({
    super.key,
    double? width,
    double? height,
    this.radius,
    this.child,
    this.inverted = false,
    BoxConstraints? constraints,
  }) : constraints = (width != null || height != null)
            ? constraints?.tighten(width: width, height: height) ??
                BoxConstraints.tightFor(width: width, height: height)
            : constraints;

  @override
  Widget build(BuildContext context) {
    final customTheme = CustomTheme.of(context);
    var decoration =
        inverted ? customTheme?.invertedDecoration : customTheme?.decoration;

    if (radius != null) {
      decoration = decoration?.copyWith(
        borderRadius: BorderRadius.circular(radius!),
      );
    }

    return Container(
      constraints: constraints,
      decoration: decoration,
      child: Material(
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        child: child,
      ),
    );
  }
}
