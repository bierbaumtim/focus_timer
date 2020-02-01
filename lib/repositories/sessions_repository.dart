import 'package:hive/hive.dart';
import 'package:dartx/dartx.dart';

import '../constants/hive_constants.dart';
import '../models/session.dart';
import 'interfaces/sessions_repository_interface.dart';

class SessionsRepository implements ISessionsRepository {
  @override
  List<Session> loadSessions() {
    final sessionsBox = Hive.box(kSessionsHiveBox);
    return sessionsBox.get(kSessionsHiveKey) as List<Session> ??
        List<Session>.generate(
          12,
          (index) => Session.create(25.minutes.inSeconds),
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

class DesktopSessionsRepository implements ISessionsRepository {
  @override
  List<Session> loadSessions() {
    return List<Session>.generate(
      12,
      (index) => Session.create(25.minutes.inSeconds),
    );
  }

  @override
  Future<void> removeSession(Session session) {
    // TODO: implement removeSession
    // throw UnimplementedError();
    return null;
  }

  @override
  Future<void> saveSession(Session session) {
    // TODO: implement saveSession
    // throw UnimplementedError();
    return null;
  }

  @override
  Future<void> saveSessions(List<Session> sessions) {
    // TODO: implement saveSessions
    // throw UnimplementedError();
    return null;
  }

  @override
  Future<void> updateSession(Session session) {
    // TODO: implement updateSession
    // throw UnimplementedError();
    return null;
  }
}
