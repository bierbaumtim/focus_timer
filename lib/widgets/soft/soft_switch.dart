import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:focus_timer/widgets/soft/soft_container.dart';

class SoftSwitch extends StatefulWidget {
  final Widget activeChild;
  final Widget deactiveChild;
  final ValueChanged<bool> onChanged;
  final bool value;

  const SoftSwitch({
    Key key,
    this.activeChild,
    this.deactiveChild,
    this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  _SoftSwitchState createState() => _SoftSwitchState();
}

class _SoftSwitchState extends State<SoftSwitch> with TickerProviderStateMixin {
  AnimationController alignmentController;
  Tween alignmentTween;
  Animation alignmentAnimation;

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
    alignmentController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37.5,
      width: 75,
      child: SoftContainer(
        radius: 10,
        inverted: true,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: GestureDetector(
            onTap: () {
              if (alignmentController.isCompleted) {
                alignmentController.reverse();
              } else {
                alignmentController.forward();
              }
              if (widget.onChanged != null) {
                widget.onChanged(!widget.value);
              }
            },
            child: Align(
              alignment: Alignment(alignmentAnimation.value, 0),
              child: SizedBox(
                height: 32.5,
                width: 33.5,
                child: SoftContainer(
                  radius: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Center(
                      child: AnimatedCrossFade(
                        firstChild: IconTheme(
                          data: IconThemeData(
                            color: Theme.of(context).textTheme.body1.color,
                            size: 20,
                          ),
                          child: widget.activeChild,
                        ),
                        secondChild: IconTheme(
                          data: IconThemeData(
                            color: Theme.of(context).textTheme.body1.color,
                            size: 20,
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
