import '../database/app_database.dart';
import '../database/daos/sessions_dao.dart';
import 'interfaces/sessions_repository_interface.dart';

class SessionsRepository implements ISessionsRepository {
  final SessionsDao sessionsDao;

  const SessionsRepository(this.sessionsDao);

  @override
  Future<List<Session>> loadSessions() => sessionsDao.loadAllSessions;

  @override
  Future<void> saveSessions(List<Session> sessions) async {
    for (final session in sessions) {
      await saveSession(session);
    }
  }

  @override
  Future<int> saveSession(Session session) =>
      sessionsDao.insertSession(session);

  @override
  Future<bool> updateSession(Session session) =>
      sessionsDao.updateSession(session);

  @override
  Future<int> removeSession(Session session) =>
      sessionsDao.deleteSession(session);
}
