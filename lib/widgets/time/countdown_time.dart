import 'package:flip_panel/flip_panel.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../state_models/current_session_model.dart';
import '../../state_models/session_model.dart';
import '../../utils/time_utils.dart';

class CountdownTime extends StatelessWidget {
  final bool isSmall;
  final bool useDigitalClock;

  const CountdownTime({
    Key key,
    this.isSmall = false,
    this.useDigitalClock = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentSessionModel = Injector.get<CurrentSessionModel>();

    return StateBuilder<SessionsModel>(
      models: [
        currentSessionModel,
      ],
      builder: (context, _) => Center(
        child: _SimpleTime(
          duration: currentSessionModel.currentDuration,
          isSmall: isSmall,
        ),
      ),
    );
  }
}

class _DigitalTime extends StatelessWidget {
  final int duration;

  const _DigitalTime({Key key, @required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 64,
      child: FlipClock.countdown(
        duration: Duration(seconds: duration),
        digitColor: theme.textTheme.headline6.color,
        backgroundColor: theme.canvasColor,
        digitSize: theme.textTheme.headline6.fontSize,
      ),
    );
  }
}

class _SimpleTime extends StatelessWidget {
  final int duration;
  final bool isSmall;

  const _SimpleTime({
    Key key,
    @required this.duration,
    this.isSmall = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      timeToString(duration),
      maxLines: 1,
      style: Theme.of(context).textTheme.headline6.copyWith(
        fontSize: 110,
        shadows: [],
      ),
      maxFontSize: isSmall ? 20 : double.infinity,
    );
  }
}
