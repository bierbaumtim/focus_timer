import 'package:hive/hive.dart';
import 'package:dartx/dartx.dart';

import 'package:focus_timer/constants/hive_constants.dart';
import 'package:focus_timer/models/session.dart';

abstract class ISessionsRepository {
  List<Session> loadSessions();
  Future<void> saveSession(Session session);
  Future<void> saveSessions(List<Session> sessions);
  Future<void> updateSession(Session session);
  Future<void> removeSession(Session session);
}

class SessionsRepository implements ISessionsRepository {
  int lastSessionKey;

  @override
  List<Session> loadSessions() {
    final sessionsBox = Hive.box(kSessionsHiveBox);
    return sessionsBox.get(kSessionsHiveKey) as List<Session> ??
        List<Session>.generate(
          12,
          (index) => Session.create(5.minutes.inSeconds),
        );
    // sessionsBox.toMap().forEach((k, v) => sessions.add(v as Session));
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