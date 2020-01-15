import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import '../../state_models/session_model.dart';

class SessionCountdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionsModel = Injector.get<SessionsModel>();

    return StateBuilder(
      models: [
        sessionsModel,
      ],
      builder: (context, _) {
        if (sessionsModel.isPause) {
        } else {
          return Text('');
        }
      },
    );
  }
}
