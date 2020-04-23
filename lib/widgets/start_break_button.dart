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

    return PlayAnimation(
      tween: MultiTween<String>()
        ..add(
          'opacity',
          fadeInTween,
          const Duration(milliseconds: 650),
        )
        ..add(
          'translation',
          Tween<double>(
            begin: 130,
            end: 0,
          ),
          const Duration(milliseconds: 450),
          Curves.easeInOut,
        ),
      duration: const Duration(milliseconds: 1500),
      delay: const Duration(milliseconds: 500),
      builder: (context, child, animation) => AnimatedOpacity(
        duration: const Duration(milliseconds: 0),
        opacity: animation.get('opacity'),
        child: Transform.translate(
          offset: Offset(
            0,
            animation.get('translation'),
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
