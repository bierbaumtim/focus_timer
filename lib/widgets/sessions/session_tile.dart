import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import '../../models/session.dart';
import '../../state_models/current_session_model.dart';
import '../../state_models/session_model.dart';
import '../soft/soft_button.dart';
import '../soft/soft_container.dart';

class SessionTile extends StatelessWidget {
  final Session session;
  final int index;

  const SessionTile({
    Key key,
    @required this.session,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentSessionModel = Injector.get<CurrentSessionModel>();
    final sessionsModel = Injector.get<SessionsModel>();

    final theme = Theme.of(context);

    return Dismissible(
      key: ValueKey(session.uid),
      onDismissed: (_) => sessionsModel.removeSession(session),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: SoftContainer(
          radius: 15,
          child: ListTile(
            title: Text(
              'Session ${(index ?? 0) + 1}',
              style: theme.textTheme.subhead.copyWith(
                color: session.isCompleted
                    ? theme.textTheme.subhead.color.withOpacity(0.5)
                    : theme.textTheme.subhead.color,
              ),
            ),
            trailing: SoftButton(
              onTap: currentSessionModel.isBreak
                  ? null
                  : () {
                      if (currentSessionModel.currentSessionIndex == index) {
                        if (currentSessionModel.isTimerRunning) {
                          currentSessionModel.stopTimer();
                        } else {
                          currentSessionModel.restartTimer();
                        }
                      } else if (currentSessionModel.currentSessionIndex <
                          index) {
                        currentSessionModel.startSession(index);
                      }
                    },
              child: Padding(
                padding: const EdgeInsets.all(1.5),
                child: Icon(
                  session.isCompleted
                      ? Icons.check
                      : currentSessionModel.currentSessionIndex == index &&
                              currentSessionModel.isTimerRunning
                          ? Icons.pause
                          : Icons.play_arrow,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
