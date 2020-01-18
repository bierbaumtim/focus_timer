import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import '../../state_models/session_model.dart';

class SessionCountdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessionsModel = Injector.get<SessionsModel>();
    final theme = Theme.of(context);

    return StateBuilder<SessionsModel>(
      models: [
        sessionsModel,
      ],
      onRebuildState: (context, _) => print('update StateBuilder'),
      builder: (context, _) {
        final children = <Widget>[];

        if (sessionsModel.isBreak) {
          children.add(
            CountdownTime(
              key: const PageStorageKey('countdown_break'),
              duration: sessionsModel.breakDuration,
              onTimerFinished: () {
                sessionsModel.startSession();
              },
            ),
          );
        } else if (sessionsModel.currentSession != null) {
          children.add(
            CountdownTime(
              key: const PageStorageKey('countdown_session'),
              duration: sessionsModel.currentSession.duration,
              onTimerFinished: () {
                sessionsModel.startBreak();
              },
            ),
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

class CountdownTime extends StatefulWidget {
  final int duration;
  final VoidCallback onTimerFinished;

  const CountdownTime({
    Key key,
    this.duration,
    this.onTimerFinished,
  }) : super(key: key);

  @override
  _CountdownTimeState createState() => _CountdownTimeState();
}

class _CountdownTimeState extends State<CountdownTime> {
  Timer timer;
  int duration;

  @override
  void initState() {
    super.initState();
    setupTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!timer.isActive) {
      setupTimer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void setupTimer() {
    duration = widget.duration;
    timer = Timer.periodic(const Duration(seconds: 1), _decreaseTimer);
  }

  void _decreaseTimer(Timer t) {
    duration -= 1;
    if (duration <= 0) {
      duration = 0;
      timer.cancel();
      widget.onTimerFinished?.call();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.center,
      child: AutoSizeText(
        timeToString,
        maxLines: 1,
        style: theme.textTheme.title.copyWith(
          fontSize: 110,
          shadows: [],
        ),
      ),
    );
  }

  String get timeToString {
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
