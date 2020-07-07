import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:wakelock/wakelock.dart';

import 'session_settings_model.dart';

class CurrentSessionModel extends ChangeNotifier {
  final SessionSettingsModel sessionSettingsModel;

  double get _shortBreakDuration => sessionSettingsModel.shortBreakDuration;
  double get _longBreakDuration => sessionSettingsModel.longBreakDuration;
  int get _sessionDuration => sessionSettingsModel.sessionsDuration.toInt();
  int get _sessionUntilBreak => sessionSettingsModel.sessionUntilBreak;
  int get _maxSessionAmount => 12;

  bool isBreak, isSession, isTimerRunning;
  int currentDuration, currentSessionIndex;

  Timer _timer;

  CurrentSessionModel(this.sessionSettingsModel)
      : assert(sessionSettingsModel != null) {
    isBreak = false;
    isTimerRunning = false;
    isSession = false;
    currentSessionIndex = -1;
    currentDuration = 0;
  }

  void startBreak() {
    _timer?.cancel();
    if (currentSessionIndex < _maxSessionAmount) {
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
    notifyListeners();
  }

  void startSession() {
    if (currentSessionIndex < _maxSessionAmount) {
      currentDuration = _sessionDuration;
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
    notifyListeners();
  }

  void stopTimer() {
    if (isSession && isTimerRunning) {
      _disableWakelock();
      _timer?.cancel();
      isTimerRunning = false;
      notifyListeners();
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
      notifyListeners();
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
            currentSessionIndex++;
            if (currentSessionIndex <= _maxSessionAmount) {
              currentDuration = _sessionDuration;
              isSession = true;
            } else {
              isSession = false;
              isTimerRunning = false;
              _timer?.cancel();
              break;
            }
          } else {
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
      notifyListeners();
    }
  }

  /// Disposes the models
  ///
  /// Cancel every listeners and timer.
  @override
  void dispose() {
    _disableWakelock();
    _timer.cancel();
    super.dispose();
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
