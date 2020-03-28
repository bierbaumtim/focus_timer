import 'dart:async';
import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:wakelock/wakelock.dart';

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
  int get _sessionUntilBreak => sessionSettingsModel.sessionUntilBreak;

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
      currentDuration = _calculateBreakDuration(currentSessionIndex);
      _enableWakelock();
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => _decreaseDurationByOne(),
      );
    } else {
      isBreak = false;
      _disableWakelock();
    }
    isSession = false;
    isTimerRunning = true;
    if (hasObservers) {
      rebuildStates();
    }
  }

  void startSession([int index = -1]) {
    if (sessions.isNotEmpty) {
      getNextSession(index);
      currentDuration = currentSession?.duration ?? 0;
      isTimerRunning = true;
      isSession = true;
      _enableWakelock();
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
      _disableWakelock();
      _timer?.cancel();
      isTimerRunning = false;
      if (hasObservers) {
        rebuildStates();
      }
    }
  }

  void restartTimer() {
    if (isSession && !isTimerRunning) {
      _enableWakelock();
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

  void handleElapsedTimeInBackground(int elapsedSeonds) {
    var remainingTime = elapsedSeonds;
    while (remainingTime >= 0) {
      if (!isTimerRunning) {
        break;
      }
      if (isBreak || isSession) {
        final tempCurrentDuation = currentDuration;
        currentDuration -= remainingTime;
        remainingTime -= tempCurrentDuation;
        if (currentDuration <= 0) {
          if (isBreak) {
            isBreak = false;
            getNextSession();
            if (currentSession != null) {
              currentDuration = currentSession.duration;
              isSession = true;
            } else {
              isSession = false;
              isTimerRunning = false;
              _timer?.cancel();
              break;
            }
          } else {
            sessionsModel.updateSession(
              currentSession.copyWith(
                isCompleted: true,
              ),
            );
            currentDuration =
                _calculateBreakDuration(currentSessionIndex) - currentDuration;
            isSession = false;
            isBreak = true;
          }
        } else {
          break;
        }
      }
      print(currentDuration);
    }
  }

  /// Session
  /// currentDuration: 15min
  /// tempCurrentDuration: 15min
  /// elapsedSeconds: 16min
  /// remainingTime: 16min
  /// breakDuration: 5min
  ///
  /// currentDuration berechnen:
  /// currentDuration: 15 - 16 = -1

  int _calculateBreakDuration(int index) {
    if (index <= 0) {
      return _shortBreakDuration.toInt();
    } else {
      return index % _sessionUntilBreak != 0
          ? _shortBreakDuration.toInt()
          : _longBreakDuration.toInt();
    }
  }

  void getNextSession([int index = -1]) {
    if (index.isBetween(0, sessions.length - 1)) {
      currentSession = sessions.elementAt(index);
      currentSessionIndex = index;
    } else if (currentSessionIndex == -1) {
      currentSession = sessions.first;
      currentSessionIndex = 0;
    } else if (currentSessionIndex + 1 <= sessions.lastIndex) {
      currentSessionIndex++;
      currentSession = sessions.elementAt(currentSessionIndex);
    } else {
      currentSession = null;
      currentSessionIndex = sessions.length;
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
    _disableWakelock();
    _timer.cancel();
  }

  void _enableWakelock() {
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        Wakelock.enable();
      }
    }
  }

  void _disableWakelock() {
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        Wakelock.disable();
      }
    }
  }
}
