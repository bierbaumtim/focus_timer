import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:focus_timer/widgets/time/countdown_time.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:focus_timer/state_models/current_session_model.dart';

import '../../state_models/session_model.dart';

class SessionCountdown extends StatelessWidget {
  const SessionCountdown({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentSessionModel = Injector.get<CurrentSessionModel>();
    final theme = Theme.of(context);

    return StateBuilder<SessionsModel>(
      models: [
        currentSessionModel,
      ],
      disposeModels: false,
      builder: (context, _) {
        final children = <Widget>[];

        if (currentSessionModel.isBreak ||
            currentSessionModel.currentSession != null) {
          children.add(
            const CountdownTime(),
          );
        } else {
          children.add(
            Align(
              alignment: Alignment.center,
              child: AutoSizeText(
                'All sessions done.',
                maxLines: 1,
                style: theme.textTheme.title.copyWith(
                  fontSize: 110,
                  shadows: [],
                ),
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Stack(
            children: children,
          ),
        );
      },
    );
  }
}
