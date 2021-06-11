import 'package:flutter/material.dart';

import 'soft_container.dart';

/// {@template softbutton}
/// A Button implementing the Neomorphism design.
/// {@endtemplate}
class SoftButton extends StatefulWidget {
  /// The radius to apply to the [SoftButton]
  final double? radius;

  /// The callback to call when tapping the [SoftButton]
  final VoidCallback onTap;

  /// Widget placed inside the button
  final Widget child;

  /// {@macro softbutton}
  const SoftButton({
    Key? key,
    required this.onTap,
    this.radius,
    required this.child,
  }) : super(key: key);

  @override
  _SoftButtonState createState() => _SoftButtonState();
}

class _SoftButtonState extends State<SoftButton> {
  late bool invertColor;

  @override
  void initState() {
    super.initState();
    invertColor = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => setState(() => invertColor = !invertColor),
      onTapUp: (details) => setState(() => invertColor = !invertColor),
      onTap: widget.onTap,
      child: SoftContainer(
        inverted: invertColor,
        radius: widget.radius,
        child: widget.child,
      ),
    );
  }
}
