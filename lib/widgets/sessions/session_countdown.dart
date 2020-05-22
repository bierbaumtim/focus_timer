import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:stacked/stacked.dart';

import '../../state_models/current_session_model.dart';
import '../time/countdown_time.dart';

class SessionCountdown extends ViewModelWidget<CurrentSessionModel> {
  const SessionCountdown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, CurrentSessionModel model) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Stack(
        children: [
          if (model.isBreak || model.currentSession != null)
            const CountdownTime()
          else
            Align(
              alignment: Alignment.center,
              child: AutoSizeText(
                model.currentSessionIndex == -1
                    ? 'Start with your first session'
                    : 'All sessions done.',
                maxLines: 1,
                style: theme.textTheme.headline6.copyWith(
                  fontSize: 110,
                  shadows: [],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
