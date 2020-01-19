import 'dart:async';

import 'package:focus_timer/models/session.dart';
import 'package:focus_timer/state_models/session_model.dart';
import 'package:focus_timer/extensions/num_extensions.dart';

import 'package:dartx/dartx.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class CurrentSessionModel extends StatesRebuilder {
  final SessionsModel sessionsModel;

  List<Session> get sessions => sessionsModel.sessions;

  Session currentSession;
  bool isBreak, allSessionsCompleted, isRunning;
  int currentDuration, currentSessionIndex;

  Timer timer;

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
    timer?.cancel();
    if (index < sessions.lastIndex) {
      isBreak = true;
      currentDuration =
          index % 5 != 0 ? 5.minutes.inSeconds : 25.minutes.inSeconds;
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => decreaseDurationByOne(),
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
      timer?.cancel();
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => decreaseDurationByOne(),
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
    timer?.cancel();
    isRunning = false;
    rebuildStates();
  }

  void restartTimer() {
    timer?.cancel();
    decreaseDurationByOne();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => decreaseDurationByOne(),
    );
    isRunning = true;
    rebuildStates();
  }

  void decreaseDurationByOne() {
    currentDuration -= 1;
    if (currentDuration <= 0) {
      currentDuration = 0;
      timer.cancel();
      if (isBreak) {
        startSession();
      } else {
        startBreak();
      }
    } else {
      rebuildStates();
    }
  }

  void dispose() {
    timer.cancel();
  }
}
