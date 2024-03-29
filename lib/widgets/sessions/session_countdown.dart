import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

import '../../state_models/current_session_model.dart';
import '../time/countdown_time.dart';

class SessionCountdown extends StatelessWidget {
  const SessionCountdown({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<CurrentSessionModel>(
      builder: (context, model, child) => Stack(
        children: <Widget>[
          if (model.isTimerRunning || model.isTimerPaused)
            child!
          else if (model.currentSessionIndex == -1)
            Center(
              child: SimpleTime(
                duration: model.sessionDuration,
              ),
            )
          else
            Center(
              child: AutoSizeText(
                'All sessions done.',
                maxLines: 1,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 110,
                ),
              ),
            )
        ],
      ),
      child: const CountdownTime(),
    );
  }
}
