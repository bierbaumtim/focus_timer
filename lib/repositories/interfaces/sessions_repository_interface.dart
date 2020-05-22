import '../../database/app_database.dart';

abstract class ISessionsRepository {
  Future<List<Session>> loadSessions();
  Future<int> saveSession(Session session);
  Future<void> saveSessions(List<Session> sessions);
  Future<bool> updateSession(Session session);
  Future<int> removeSession(Session session);
}
