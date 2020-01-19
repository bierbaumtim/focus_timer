import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:focus_timer/state_models/current_session_model.dart';

import '../../state_models/session_model.dart';

class SessionCountdown extends StatelessWidget {
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

        if (currentSessionModel.isBreak) {
          children.add(
            const CountdownTime(),
          );
        } else if (currentSessionModel.currentSession != null) {
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

class CountdownTime extends StatelessWidget {
  const CountdownTime({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentSessionModel = Injector.get<CurrentSessionModel>();

    return StateBuilder<SessionsModel>(
      models: [
        currentSessionModel,
      ],
      builder: (context, _) => Align(
        alignment: Alignment.center,
        child: AutoSizeText(
          timeToString(currentSessionModel.currentDuration),
          maxLines: 1,
          style: theme.textTheme.title.copyWith(
            fontSize: 110,
            shadows: [],
          ),
        ),
      ),
    );
  }

  String timeToString(int duration) {
    var timeString = '';
    final hours = (duration / 3600).truncate();
    if (hours > 0) {
      timeString += hours.toString().padLeft(2, '0');
      timeString += ':';
    }

    final minutes = ((duration % 3600) / 60).truncate();
    if (minutes > 0) {
      timeString += minutes.toString().padLeft(2, '0');
      timeString += ':';
    }

    final seconds = ((duration % 3600) % 60).truncate();
    return timeString += seconds.toString().padLeft(2, '0');
  }
}
