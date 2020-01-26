import 'package:flutter/material.dart';

import 'soft_decorations.dart';

/// {@template softbutton}
/// A Button implementing the Neomorphism design.
/// {@endtemplate}
class SoftButton extends StatefulWidget {
  /// Forces the Button to use dark decorations
  final bool useDarkTheme;

  /// The radius to apply to the [SoftButton]
  final double radius;

  /// The callback to call when tapping the [SoftButton]
  final VoidCallback onTap;

  /// Widget placed inside the button
  final Widget child;

  /// {@macro softbutton}
  const SoftButton({
    Key key,
    this.useDarkTheme,
    this.onTap,
    this.radius,
    this.child,
  }) : super(key: key);

  @override
  _SoftButtonState createState() => _SoftButtonState();
}

class _SoftButtonState extends State<SoftButton> {
  bool invertColor;

  @override
  void initState() {
    super.initState();
    invertColor = false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (details) => setState(() => invertColor = !invertColor),
      onTapUp: (details) => setState(() => invertColor = !invertColor),
      onTap: widget.onTap,
      child: Container(
        decoration: invertColor
            ? kSoftInvertedDecoration(
                isDark: widget.useDarkTheme ?? isDark,
                radius: widget.radius,
              )
            : kSoftDecoration(
                isDark: widget.useDarkTheme ?? isDark,
                radius: widget.radius,
              ),
        child: widget.child,
      ),
    );
  }
}
