import 'package:flutter/material.dart';

import 'soft_decorations.dart';

class SoftButton extends StatefulWidget {
  final bool useDarkTheme;
  final double radius;
  final VoidCallback onTap;
  final Widget child;

  const SoftButton({
    Key key,
    this.child,
    this.useDarkTheme,
    this.onTap,
    this.radius,
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
                widget.useDarkTheme ?? isDark,
                widget.radius,
              )
            : kSoftDecoration(
                widget.useDarkTheme ?? isDark,
                widget.radius,
              ),
        child: widget.child,
      ),
    );
  }
}
