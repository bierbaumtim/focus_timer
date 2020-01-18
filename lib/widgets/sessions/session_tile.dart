import 'package:flutter/material.dart';

import 'package:focus_timer/models/session.dart';
import 'package:focus_timer/state_models/session_model.dart';
import 'package:focus_timer/widgets/soft/soft_button.dart';
import 'package:focus_timer/widgets/soft/soft_container.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

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
    final sessionsModel = Injector.get<SessionsModel>();

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
            title: Text('Session ${index ?? ''}'),
            trailing: SoftButton(
              child: Padding(
                padding: const EdgeInsets.all(1.5),
                child: Icon(Icons.play_arrow),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
