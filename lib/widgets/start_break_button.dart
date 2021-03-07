import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:provider/provider.dart';

import '../constants/tween_constants.dart';
import '../state_models/current_session_model.dart';
import 'soft/soft_button.dart';

class StartBreakButton extends StatelessWidget {
  const StartBreakButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlayAnimation(
      tween: MultiTween<String>()
        ..add(
          'opacity',
          fadeInTween,
          const Duration(milliseconds: 450),
        )
        ..add(
          'translation',
          Tween<double>(
            begin: 130,
            end: 0,
          ),
          const Duration(milliseconds: 350),
          Curves.easeInOut,
        ),
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 250),
      builder: (context, child, MultiTweenValues<String> animation) =>
          AnimatedOpacity(
        duration: const Duration(),
        opacity: animation.get('opacity') as double,
        child: Transform.translate(
          offset: Offset(
            0,
            animation.get('translation') as double,
          ),
          child: SoftButton(
            radius: 15,
            onTap: () =>
                context.read<CurrentSessionModel>().onStartBreakButtonTapped(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Consumer<CurrentSessionModel>(
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
