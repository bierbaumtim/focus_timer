import 'package:dartx/dartx.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../extensions/num_extensions.dart';
import '../repositories/interfaces/sessions_repository_interface.dart';
import 'session_settings_model.dart';

class SessionsModel extends ChangeNotifier {
  final ISessionsRepository storageRepository;
  final SessionSettingsModel sessionSettingsModel;

  double get _sessionDuration => sessionSettingsModel.sessionsDuration;

  SessionsModel(this.storageRepository, this.sessionSettingsModel) {
    _sessions = <Session>[];
    loadSessions();
  }

  List<Session> _sessions;

  List<Session> get sessions => _sessions;

  void addSession(Session newSession, {int duration, int position}) {
    final session =
        newSession ?? createSession(duration ?? _sessionDuration.toInt());
    if (position != null && position.isBetween(0, _sessions.lastIndex)) {
      _sessions.insert(position, session);
    } else {
      _sessions.add(session);
    }
    storageRepository.saveSession(session);
    notifyListeners();
  }

  void updateSession(Session session) {
    _sessions = _sessions
        .map<Session>((s) => s.uuid == session.uuid ? session : s)
        .toList();
    storageRepository.updateSession(session);
    notifyListeners();
  }

  void removeSession(Session session) {
    _sessions.removeWhere((s) => s.uuid == session.uuid);
    storageRepository.removeSession(session);
    notifyListeners();
  }

  void reorderSession(int oldIndex, int newIndex) {
    final oldSession = _sessions.removeAt(oldIndex);
    _sessions.insert(newIndex, oldSession);
    notifyListeners();
  }

  Future<void> loadSessions() async {
    _sessions = await storageRepository.loadSessions();
    if (_sessions == null || _sessions.isEmpty) {
      _sessions = List<Session>.generate(
        12,
        (index) => createSession(_sessionDuration.toInt()),
      );
      storageRepository.saveSessions(_sessions);
    }
    notifyListeners();
  }

  Session createSession(int duration) => Session(
        uuid: Uuid().v4(),
        duration: duration,
        isCompleted: false,
      );
}
