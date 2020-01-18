import 'package:dartx/dartx.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:focus_timer/extensions/num_extensions.dart';
import 'package:focus_timer/models/session.dart';
import 'package:focus_timer/repositories/sessions_repository.dart';

class SessionsModel extends StatesRebuilder {
  final SessionsRepository storageRepository;

  SessionsModel(this.storageRepository) {
    isBreak = false;
    allSessionsCompleted = false;
    breakDuration = 5.minutes.inSeconds;
    currentSessionIndex = -1;
    loadSessions();
  }

  List<Session> sessions;
  Session currentSession;
  bool isBreak, allSessionsCompleted;
  int breakDuration, currentSessionIndex;

  void addSession(Session newSession, {int duration, int position}) {
    final session =
        newSession ?? Session.create(duration ?? 5.minutes.inSeconds);
    if (position != null && position.isBetween(0, sessions.lastIndex)) {
      sessions.insert(position, session);
    } else {
      sessions.add(session);
    }
    storageRepository.saveSession(session);
    rebuildStates();
  }

  void updateSession(Session session) {
    sessions = sessions
        .map<Session>((s) => s.uid == session.uid ? session : s)
        .toList();
    if (currentSession.uid == session.uid) {
      currentSession = session;
    }
    storageRepository.updateSession(session);
    rebuildStates();
  }

  void removeSession(Session session) {
    sessions.removeWhere((s) => s.uid == session.uid);
    storageRepository.removeSession(session);
    rebuildStates();
  }

  void startBreak() {
    final index = sessions.indexOf(currentSession);
    isBreak = true;
    breakDuration = index % 5 == 0 ? 5.minutes.inSeconds : 25.minutes.inSeconds;
    rebuildStates();
  }

  void startSession() {
    if (sessions.isNotEmpty) {
      if (currentSessionIndex == -1) {
        currentSession = sessions.first;
        currentSessionIndex = 0;
      } else if (currentSessionIndex + 1 <= sessions.lastIndex) {
        currentSessionIndex += 1;
        currentSession = sessions.elementAt(currentSessionIndex);
      }
    }
    isBreak = false;
    rebuildStates();
  }

  void reorderSession(int oldIndex, int newIndex) {
    final oldSession = sessions.removeAt(oldIndex);
    sessions.insert(newIndex, oldSession);
    rebuildStates();
  }

  void _saveEdits() {
    storageRepository.saveSessions(sessions);
  }

  void loadSessions() => sessions = storageRepository.loadSessions();
}
