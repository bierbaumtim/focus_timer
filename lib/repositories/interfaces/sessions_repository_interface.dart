import '../../models/session.dart';

abstract class ISessionsRepository {
  List<Session> loadSessions();
  Future<void> saveSession(Session session);
  Future<void> saveSessions(List<Session> sessions);
  Future<void> updateSession(Session session);
  Future<void> removeSession(Session session);
}
