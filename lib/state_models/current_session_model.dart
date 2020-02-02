import 'dart:async';

import 'package:dartx/dartx.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../extensions/num_extensions.dart';
import '../models/session.dart';
import 'session_model.dart';
import 'session_settings_model.dart';

class CurrentSessionModel extends StatesRebuilder {
  final SessionsModel sessionsModel;
  final SessionSettingsModel sessionSettingsModel;

  List<Session> get sessions => sessionsModel.sessions;

  double get _shortBreakDuration => sessionSettingsModel.shortBreakDuration;
  double get _longBreakDuration => sessionSettingsModel.longBreakDuration;

  Session currentSession;
  bool isBreak, isSession, allSessionsCompleted, isTimerRunning;
  int currentDuration, currentSessionIndex;

  Timer _timer;

  CurrentSessionModel(this.sessionsModel, this.sessionSettingsModel)
      : assert(sessionSettingsModel != null),
        assert(sessionsModel != null) {
    isBreak = false;
    isTimerRunning = false;
    isSession = false;
    allSessionsCompleted = false;
    currentSessionIndex = -1;
    currentDuration = 0;
  }

  void startBreak() {
    final session = currentSession.copyWith(
      isCompleted: true,
    );
    sessionsModel.updateSession(session);
    _timer?.cancel();
    if (currentSessionIndex < sessions.lastIndex) {
      isBreak = true;
      if (currentSessionIndex == 0) {
        currentDuration = _shortBreakDuration.toInt();
      } else {
        currentDuration = currentSessionIndex % 5 != 0
            ? _shortBreakDuration.toInt()
            : _longBreakDuration.toInt();
      }
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => _decreaseDurationByOne(),
      );
    } else {
      isBreak = false;
    }
    isSession = false;
    isTimerRunning = true;
    if (hasObservers) {
      rebuildStates();
    }
  }

  void startSession([int index = -1]) {
    if (sessions.isNotEmpty) {
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
      isTimerRunning = true;
      isSession = true;
      _timer?.cancel();
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => _decreaseDurationByOne(),
      );
    }
    isBreak = false;
    if (hasObservers) {
      rebuildStates();
    }
  }

  void updateCurrentSession(Session session) {
    if (currentSession.uid == session.uid) {
      currentSession = session;
      if (hasObservers) {
        rebuildStates();
      }
    }
  }

  void stopTimer() {
    if (isSession && isTimerRunning) {
      _timer?.cancel();
      isTimerRunning = false;
      if (hasObservers) {
        rebuildStates();
      }
    }
  }

  void restartTimer() {
    if (isSession && !isTimerRunning) {
      _timer?.cancel();
      _decreaseDurationByOne();
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => _decreaseDurationByOne(),
      );
      isTimerRunning = true;
      if (hasObservers) {
        rebuildStates();
      }
    }
  }

  /// Handles a tick by the [Timer]
  ///
  /// When the duration is over and
  /// [isBreak] is true it's starts
  /// the next session otherwise
  /// the next break.
  void _decreaseDurationByOne() async {
    currentDuration -= 1;
    if (currentDuration < 0) {
      currentDuration = 0;
      _timer.cancel();
      await Future.delayed(const Duration(milliseconds: 500));
      _timer.cancel();
      if (isBreak) {
        startSession();
      } else {
        startBreak();
      }
    } else {
      if (hasObservers) {
        rebuildStates();
      }
    }
  }

  /// Disposes the models
  ///
  /// Cancel every listeners and timer.
  void dispose() {
    _timer.cancel();
  }
}
