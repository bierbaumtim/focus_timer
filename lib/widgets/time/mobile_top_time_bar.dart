import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../constants/tween_constants.dart';
import '../../state_models/current_session_model.dart';
import '../datetime/current_datetime_container.dart';
import '../soft/soft_container.dart';
import 'countdown_time.dart';

class MobileTopTimeBar extends StatelessWidget {
  const MobileTopTimeBar({
    Key key,
    this.alignment = Alignment.topCenter,
    this.padding,
  })  : assert(alignment != null),
        super(key: key);

  final Alignment alignment;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final currentSessionModel = Injector.get<CurrentSessionModel>();

    return Align(
      alignment: alignment ?? Alignment.topCenter,
      child: Padding(
        padding: padding ?? EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: ControlledAnimation(
          tween: MultiTrackTween([
            Track('opacity').add(
              const Duration(milliseconds: 650),
              fadeInTween,
            ),
            Track('translation').add(
              const Duration(milliseconds: 450),
              Tween<double>(
                begin: -50,
                end: 0,
              ),
              curve: Curves.easeInOut,
            ),
          ]),
          duration: const Duration(milliseconds: 1500),
          builder: (context, animation) => Opacity(
            opacity: animation['opacity'],
            child: Transform.translate(
              offset: Offset(0, animation['translation']),
              child: StateBuilder(
                models: [currentSessionModel],
                builder: (context, _) => Row(
                  mainAxisAlignment: currentSessionModel.isBreak ||
                          currentSessionModel.isTimerRunning
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 8),
                      child: CurrentDateTimeContainer(),
                    ),
                    if (currentSessionModel.isBreak ||
                        currentSessionModel.isTimerRunning)
                      Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 8),
                        child: SoftContainer(
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            child: CountdownTime(
                              isSmall: true,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
