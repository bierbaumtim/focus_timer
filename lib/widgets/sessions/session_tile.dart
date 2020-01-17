import 'package:flutter/material.dart';
import 'package:focus_timer/models/session.dart';
import 'package:focus_timer/state_models/session_model.dart';
import 'package:focus_timer/widgets/soft/soft_container.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SessionTile extends StatelessWidget {
  final Session session;

  const SessionTile({Key key, this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sessionsModel = Injector.get<SessionsModel>();

    return Dismissible(
      key: ValueKey(session.uid),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: SoftContainer(
          radius: 15,
          child: CheckboxListTile(
            value: false,
            onChanged: (_) => null,
            title: Text('Session ${session.position}'),
            activeColor: theme.accentColor,
            checkColor: theme.canvasColor,
          ),
        ),
      ),
      onDismissed: (_) => sessionsModel.removeSession(session),
    );
  }
}
