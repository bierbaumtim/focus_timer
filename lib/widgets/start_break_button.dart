import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../constants/tween_constants.dart';
import '../state_models/current_session_model.dart';

class StartBreakButton extends StatelessWidget {
  final bool withAnimation;
  final bool extended;

  const StartBreakButton({
    super.key,
    this.withAnimation = true,
    this.extended = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Consumer<CurrentSessionModel>(
      builder: (context, model, child) => Icon(
        model.isTimerRunning ? Icons.pause : Icons.play_arrow,
      ),
    );

    if (extended) {
      child = FloatingActionButton.extended(
        heroTag: 'session_play_pause',
        onPressed: () =>
            context.read<CurrentSessionModel>().onStartBreakButtonTapped(),
        icon: child,
        label: Consumer<CurrentSessionModel>(
          builder: (context, model, child) => Text(
            model.isTimerRunning
                ? 'Pause Session'
                : model.timeRemaining > 0
                    ? 'Continue Session'
                    : 'Start Session',
          ),
        ),
      );
    } else {
      child = FloatingActionButton(
        heroTag: 'session_play_pause',
        onPressed: () =>
            context.read<CurrentSessionModel>().onStartBreakButtonTapped(),
        child: child,
      );
    }

    if (withAnimation) {
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
            child: child,
          ),
        ),
      );
    }

    return child;
  }
}
