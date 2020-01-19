import 'package:dartx/dartx.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'package:focus_timer/extensions/num_extensions.dart';
import 'package:focus_timer/models/session.dart';
import 'package:focus_timer/repositories/sessions_repository.dart';

class SessionsModel extends StatesRebuilder {
  final SessionsRepository storageRepository;

  SessionsModel(this.storageRepository) {
    loadSessions();
  }

  List<Session> sessions;

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
    storageRepository.updateSession(session);
    rebuildStates();
  }

  void removeSession(Session session) {
    sessions.removeWhere((s) => s.uid == session.uid);
    storageRepository.removeSession(session);
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
