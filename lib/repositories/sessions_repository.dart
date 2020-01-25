import 'package:hive/hive.dart';
import 'package:dartx/dartx.dart';

import '../constants/hive_constants.dart';
import '../models/session.dart';

abstract class ISessionsRepository {
  List<Session> loadSessions();
  Future<void> saveSession(Session session);
  Future<void> saveSessions(List<Session> sessions);
  Future<void> updateSession(Session session);
  Future<void> removeSession(Session session);
}

class SessionsRepository implements ISessionsRepository {
  @override
  List<Session> loadSessions() {
    final sessionsBox = Hive.box(kSessionsHiveBox);
    return sessionsBox.get(kSessionsHiveKey) as List<Session> ??
        List<Session>.generate(
          12,
          (index) => Session.create(5.minutes.inSeconds),
        );
  }

  @override
  Future<void> saveSessions(List<Session> sessions) async {
    for (final session in sessions) {
      await saveSession(session);
    }
  }

  @override
  Future<void> saveSession(Session session) {
    final sessionsBox = Hive.box(kSessionsHiveBox);
    return sessionsBox.put(session.uid, session);
  }

  @override
  Future<void> updateSession(Session session) {
    final sessionsBox = Hive.box(kSessionsHiveBox);
    return sessionsBox.put(session.uid, session);
  }

  @override
  Future<void> removeSession(Session session) {
    final sessionsBox = Hive.box(kSessionsHiveBox);
    return sessionsBox.delete(session.uid);
  }
}
