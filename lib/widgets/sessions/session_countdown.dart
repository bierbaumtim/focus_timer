import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

import '../../state_models/current_session_model.dart';
import '../time/countdown_time.dart';

class SessionCountdown extends StatelessWidget {
  const SessionCountdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Consumer<CurrentSessionModel>(
        builder: (context, model, child) => Stack(
          children: <Widget>[
            if (model.isTimerRunning || model.isTimerPaused)
              child!
            else
              Center(
                child: AutoSizeText(
                  model.currentSessionIndex == -1
                      ? 'Start with your first session'
                      : 'All sessions done.',
                  maxLines: 1,
                  style: theme.textTheme.headline6!.copyWith(
                    fontSize: 110,
                  ),
                ),
              ),
          ],
        ),
        child: const CountdownTime(),
      ),
    );
  }
}
