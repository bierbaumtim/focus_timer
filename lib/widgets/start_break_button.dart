import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../constants/tween_constants.dart';
import '../state_models/current_session_model.dart';
import 'soft/soft_button.dart';

class StartBreakButton extends StatelessWidget {
  const StartBreakButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentSessionModel = Injector.get<CurrentSessionModel>();

    return ControlledAnimation(
      tween: MultiTrackTween([
        Track('opacity').add(
          const Duration(milliseconds: 650),
          fadeInTween,
        ),
        Track('translation').add(
          const Duration(milliseconds: 450),
          Tween<double>(
            begin: 130,
            end: 0,
          ),
          curve: Curves.easeInOut,
        ),
      ]),
      duration: const Duration(milliseconds: 1500),
      delay: const Duration(milliseconds: 500),
      builder: (context, animation) => Opacity(
        opacity: animation['opacity'],
        child: Transform.translate(
          offset: Offset(
            0,
            animation['translation'],
          ),
          child: SoftButton(
            radius: 15,
            onTap: () {
              if (currentSessionModel.isTimerRunning) {
                currentSessionModel.stopTimer();
              } else {
                currentSessionModel.restartTimer();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: StateBuilder<CurrentSessionModel>(
                models: [currentSessionModel],
                watch: (_) => currentSessionModel.isTimerRunning,
                builder: (context, _) => Icon(
                  currentSessionModel.isTimerRunning
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 36,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
