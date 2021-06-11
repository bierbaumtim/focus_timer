import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../theming/custom_theme.dart';
import 'soft_container.dart';

/// {@template softswitch}
/// A Switch which implements the Neomorphism design
/// {@endtemplate}
class SoftSwitch extends StatefulWidget {
  /// The widget to display when this switch is on.
  ///
  /// This property must not be null.
  final Widget activeChild;

  /// The widget to display when this switch is off.
  ///
  /// This property must not be null.
  final Widget deactiveChild;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  final ValueChanged<bool>? onChanged;

  /// Whether this switch is on or off.
  ///
  /// This property must not be null.
  final bool value;

  /// {@macro softswitch}
  const SoftSwitch({
    Key? key,
    required this.activeChild,
    required this.deactiveChild,
    this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  _SoftSwitchState createState() => _SoftSwitchState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      FlagProperty(
        'value',
        value: value,
        ifTrue: 'on',
        ifFalse: 'off',
        showName: true,
      ),
    );
    properties.add(
      ObjectFlagProperty<ValueChanged<bool>>(
        'onChanged',
        onChanged,
        ifNull: 'disabled',
      ),
    );
  }
}

class _SoftSwitchState extends State<SoftSwitch> with TickerProviderStateMixin {
  late AnimationController alignmentController;
  late Tween<double> alignmentTween;
  late Animation<double> alignmentAnimation;

  @override
  void initState() {
    super.initState();
    alignmentController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    );
    if (widget.value) {
      alignmentController.forward();
    }
    alignmentTween = Tween<double>(begin: -1, end: 1);
    alignmentAnimation = alignmentTween.animate(alignmentController);
  }

  @override
  void didUpdateWidget(SoftSwitch oldWidget) {
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        alignmentController.forward();
      } else {
        alignmentController.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final decoration = CustomTheme.of(context);
    final borderHeight = (decoration?.decoration.border?.bottom.width ?? 0) * 2;

    return SizedBox(
      width: 75 + borderHeight,
      child: GestureDetector(
        onTap: () {
          if (alignmentController.isCompleted) {
            alignmentController.reverse();
          } else {
            alignmentController.forward();
          }
          if (widget.onChanged != null) {
            widget.onChanged!(!widget.value);
          }
        },
        child: SoftContainer(
          radius: 10,
          inverted: true,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: AnimatedBuilder(
              animation: alignmentAnimation,
              builder: (context, child) => Align(
                alignment: Alignment(alignmentAnimation.value, 0),
                child: child,
              ),
              child: SizedBox(
                width: 33.5 + borderHeight,
                child: SoftContainer(
                  radius: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Center(
                      child: AnimatedCrossFade(
                        firstChild: IconTheme(
                          data: IconThemeData(
                            color: Theme.of(context).textTheme.bodyText2!.color,
                            size: 18,
                          ),
                          child: widget.activeChild,
                        ),
                        secondChild: IconTheme(
                          data: IconThemeData(
                            color: Theme.of(context).textTheme.bodyText2!.color,
                            size: 18,
                          ),
                          child: widget.deactiveChild,
                        ),
                        crossFadeState: widget.value
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: kThemeAnimationDuration,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
