import 'package:flutter/material.dart';

import 'custom_container.dart';

/// {@template softbutton}
/// A Button implementing the Neomorphism design.
/// {@endtemplate}
class CustomButton extends StatefulWidget {
  /// The radius to apply to the [CustomButton]
  final double? radius;

  /// The callback to call when tapping the [CustomButton]
  final VoidCallback onTap;

  /// Widget placed inside the button
  final Widget child;

  /// {@macro softbutton}
  const CustomButton({
    super.key,
    required this.onTap,
    this.radius,
    required this.child,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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
      onTapCancel: () => setState(() => invertColor = false),
      child: CustomContainer(
        inverted: invertColor,
        radius: widget.radius,
        child: widget.child,
      ),
    );
  }
}
