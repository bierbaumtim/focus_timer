import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:focus_timer/state_models/current_session_model.dart';
import 'package:focus_timer/state_models/session_model.dart';
import 'package:focus_timer/utils/time_utils.dart';

class CountdownTime extends StatelessWidget {
  final bool isSmall;

  const CountdownTime({Key key, this.isSmall = false}) : super(key: key);

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
          maxFontSize: isSmall ? 20 : double.infinity,
        ),
      ),
    );
  }
}
