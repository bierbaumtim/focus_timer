import 'package:dartx/dartx.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../extensions/num_extensions.dart';
import '../models/session.dart';
import '../repositories/interfaces/sessions_repository_interface.dart';
import 'session_settings_model.dart';

class SessionsModel extends StatesRebuilder {
  final ISessionsRepository storageRepository;
  final SessionSettingsModel sessionSettingsModel;

  double get _sessionDuration => sessionSettingsModel.sessionsDuration;

  SessionsModel(this.storageRepository, this.sessionSettingsModel) {
    loadSessions();
  }

  List<Session> _sessions;

  List<Session> get sessions => _sessions;

  void addSession(Session newSession, {int duration, int position}) {
    final session =
        newSession ?? Session.create(duration ?? _sessionDuration.toInt());
    if (position != null && position.isBetween(0, _sessions.lastIndex)) {
      _sessions.insert(position, session);
    } else {
      _sessions.add(session);
    }
    storageRepository.saveSession(session);
    if (hasObservers) {
      rebuildStates();
    }
  }

  void updateSession(Session session) {
    _sessions = _sessions
        .map<Session>((s) => s.uid == session.uid ? session : s)
        .toList();
    storageRepository.updateSession(session);
    if (hasObservers) {
      rebuildStates();
    }
  }

  void removeSession(Session session) {
    _sessions.removeWhere((s) => s.uid == session.uid);
    storageRepository.removeSession(session);
    if (hasObservers) {
      rebuildStates();
    }
  }

  void reorderSession(int oldIndex, int newIndex) {
    final oldSession = _sessions.removeAt(oldIndex);
    _sessions.insert(newIndex, oldSession);
    if (hasObservers) {
      rebuildStates();
    }
  }

  void loadSessions() {
    _sessions = storageRepository.loadSessions();
    if (_sessions == null || _sessions.isEmpty) {
      _sessions = List<Session>.generate(
        12,
        (index) => Session.create(_sessionDuration.toInt()),
      );
      storageRepository.saveSessions(_sessions);
    }
  }
}
