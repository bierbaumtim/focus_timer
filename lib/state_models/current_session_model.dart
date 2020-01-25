import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../extensions/num_extensions.dart';
import '../models/session.dart';
import 'session_model.dart';

class CurrentSessionModel extends StatesRebuilder {
  final SessionsModel sessionsModel;

  List<Session> get sessions => sessionsModel.sessions;

  Session currentSession;
  bool isBreak, allSessionsCompleted, isRunning;
  int currentDuration, currentSessionIndex;

  Timer _timer;

  CurrentSessionModel(this.sessionsModel) {
    isBreak = false;
    isRunning = false;
    allSessionsCompleted = false;
    currentSessionIndex = -1;
    currentDuration = 0;
  }

  void startBreak() {
    final index = sessions.indexOf(currentSession);
    final session = currentSession.copyWith(
      isCompleted: true,
    );
    sessionsModel.updateSession(session);
    _timer?.cancel();
    if (index < sessions.lastIndex) {
      isBreak = true;
      currentDuration =
          index % 5 != 0 ? 5.minutes.inSeconds : 25.minutes.inSeconds;
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => _decreaseDurationByOne(),
      );
    } else {
      isBreak = false;
    }
    isRunning = false;
    rebuildStates();
  }

  void startSession([int index = -1]) {
    if (sessions.isNotEmpty && !isBreak) {
      if (index.isBetween(0, sessions.length - 1)) {
        currentSession = sessions.elementAt(index);
        currentSessionIndex = index;
      } else if (currentSessionIndex == -1) {
        currentSession = sessions.first;
        currentSessionIndex = 0;
      } else if (currentSessionIndex + 1 <= sessions.lastIndex) {
        currentSessionIndex++;
        currentSession = sessions.elementAt(currentSessionIndex);
      }
      currentDuration = currentSession?.duration ?? 0;
      isRunning = true;
      _timer?.cancel();
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => _decreaseDurationByOne(),
      );
    }
    isBreak = false;
    rebuildStates();
  }

  void updateCurrentSession(Session session) {
    if (currentSession.uid == session.uid) {
      currentSession = session;
      rebuildStates();
    }
  }

  void stopTimer() {
    _timer?.cancel();
    isRunning = false;
    rebuildStates();
  }

  void restartTimer() {
    _timer?.cancel();
    _decreaseDurationByOne();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => _decreaseDurationByOne(),
    );
    isRunning = true;
    rebuildStates();
  }

  /// Handles a tick by the [Timer]
  ///
  /// When the duration is over and
  /// [isBreak] is true it's starts
  /// the next session otherwise
  /// the next break.
  void _decreaseDurationByOne() {
    currentDuration -= 1;
    if (currentDuration <= 0) {
      currentDuration = 0;
      _timer.cancel();
      if (isBreak) {
        startSession();
      } else {
        startBreak();
      }
    } else {
      rebuildStates();
    }
  }

  /// Disposes the models
  ///
  /// Cancel every listeners and timer.
  void dispose() {
    _timer.cancel();
  }
}
