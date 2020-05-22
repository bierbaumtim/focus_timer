import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

import '../constants/tween_constants.dart';
import '../state_models/current_session_model.dart';
import 'soft/soft_button.dart';

class StartBreakButton extends StatelessWidget {
  const StartBreakButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              final currentSessionModel = context.read<CurrentSessionModel>();
              if (currentSessionModel.isTimerRunning) {
                currentSessionModel.stopTimer();
              } else {
                currentSessionModel.restartTimer();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ViewModelBuilder<CurrentSessionModel>.reactive(
                viewModelBuilder: () => context.read<CurrentSessionModel>(),
                disposeViewModel: false,
                builder: (context, model, child) => Icon(
                  model.isTimerRunning ? Icons.pause : Icons.play_arrow,
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
