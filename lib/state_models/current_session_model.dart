import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:wakelock/wakelock.dart';

import 'session_settings_model.dart';

class CurrentSessionModel extends ChangeNotifier {
  final SessionSettingsModel sessionSettingsModel;

  double get _shortBreakDuration => sessionSettingsModel.shortBreakDuration;
  double get _longBreakDuration => sessionSettingsModel.longBreakDuration;
  int get sessionDuration => sessionSettingsModel.sessionsDuration.toInt();
  int get _sessionUntilBreak => sessionSettingsModel.sessionUntilBreak;
  int get _maxSessionAmount => 12;
  int get _calculateBreakDuration =>
      isLongBreak ? _shortBreakDuration.toInt() : _longBreakDuration.toInt();

  late bool isBreak, isSession;
  late int currentSessionIndex;

  bool get isTimerRunning => _timer.isActive;
  bool get isTimerPaused => _timer.isPaused;
  bool get isLongBreak =>
      currentSessionIndex > 0 && currentSessionIndex % _sessionUntilBreak == 0;

  int get timeRemaining => _timer.timeRemaining;

  late AdvancedTimer _timer;

  CurrentSessionModel(this.sessionSettingsModel) {
    isBreak = false;
    isSession = false;
    currentSessionIndex = -1;
    _timer = AdvancedTimer(
      onFinished: _onTimerFinished,
      onTick: notifyListeners,
    );
    sessionSettingsModel.addListener(
      refresh,
    );
  }

  void refresh() {
    notifyListeners();
  }

  void onStartBreakButtonTapped() {
    if (isTimerRunning) {
      pauseTimer();
    } else if (currentSessionIndex < 0) {
      startSession();
    } else {
      restartTimer();
    }
  }

  void _startBreak() {
    _timer.stop();
    if (currentSessionIndex < _maxSessionAmount) {
      isBreak = true;
      Wakelock.enable();
      _timer.start(_calculateBreakDuration);
    } else {
      isBreak = false;
      Wakelock.disable();
    }
    isSession = false;
    notifyListeners();
  }

  void startSession() {
    currentSessionIndex++;
    if (currentSessionIndex < _maxSessionAmount) {
      isSession = true;
      Wakelock.enable();
      _timer.start(sessionDuration);
    }
    isBreak = false;
    notifyListeners();
  }

  void pauseTimer() {
    if (isSession && isTimerRunning) {
      Wakelock.disable();
      _timer.pause();
      notifyListeners();
    }
  }

  void restartTimer() {
    if (isSession && !isTimerRunning) {
      Wakelock.enable();
      _timer.resume();
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
        final tempCurrentDuation = _timer.timeRemaining;
        _timer.timeRemaining -= remainingTime;
        remainingTime -= tempCurrentDuation;
        if (_timer.timeRemaining <= 0) {
          if (isBreak) {
            isBreak = false;
            currentSessionIndex++;
            if (currentSessionIndex <= _maxSessionAmount) {
              _timer.timeRemaining = sessionDuration;
              isSession = true;
            } else {
              isSession = false;
              _timer.stop();
              break;
            }
          } else {
            _timer.timeRemaining =
                _calculateBreakDuration - _timer.timeRemaining;
            isSession = false;
            isBreak = true;
          }
        } else {
          break;
        }
      }
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

  /// Handles a tick by the [Timer]
  ///
  /// When the duration is over and
  /// [isBreak] is true it's starts
  /// the next session otherwise
  /// the next break.
  Future<void> _onTimerFinished() async {
    if (isBreak) {
      startSession();
    } else {
      _startBreak();
    }
  }

  /// Disposes the models
  ///
  /// Cancel every listeners and timer.
  @override
  void dispose() {
    sessionSettingsModel.removeListener(refresh);
    Wakelock.disable();
    _timer.stop();
    super.dispose();
  }
}

class AdvancedTimer {
  final VoidCallback onFinished;
  final VoidCallback onTick;

  Timer? _timer;

  late bool _isPaused;
  late int _timeRemaining;

  AdvancedTimer({
    required this.onFinished,
    required this.onTick,
  }) {
    _isPaused = false;
    _timeRemaining = 0;
  }

  bool get isActive => _timer?.isActive ?? false;
  bool get isPaused => _isPaused;
  int get timeRemaining => _timeRemaining;

  set timeRemaining(int duration) {
    if (duration > 0) {
      timeRemaining = duration;
    }
  }

  void _handleTick() {
    _timeRemaining--;
    onTick();
    if (_timeRemaining <= 0) {
      _timer!.cancel();
      onFinished();
    }
  }

  void start(int duration) {
    _timeRemaining = duration;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _handleTick(),
    );
  }

  void pause() {
    _timer?.cancel();
    _isPaused = true;
  }

  void resume() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _handleTick(),
    );
    _isPaused = false;
  }

  void stop() {
    _timer?.cancel();
    _timeRemaining = 0;
  }
}
