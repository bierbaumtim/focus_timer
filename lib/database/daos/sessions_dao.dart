import 'package:moor/moor.dart';

import '../app_database.dart';
import '../tables/sessions_table.dart';
import '../tables/tasks_table.dart';

part 'sessions_dao.g.dart';

@UseDao(tables: [Sessions, Tasks])
class SessionsDao extends DatabaseAccessor<AppDatabase>
    with _$SessionsDaoMixin {
  SessionsDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<Session>> get loadAllSessions => (select(sessions)).get();

  Future<Session> getSessionByUuid(String uuid) =>
      (select(sessions)..where((tbl) => tbl.uuid.equals(uuid))).getSingle();

  Future<int> insertSession(Session session) =>
      into(sessions).insert(session.toCompanion(true));

  Future<bool> updateSession(Session session) =>
      (update(sessions)..whereSamePrimaryKey(session.toCompanion(true)))
          .replace(session.toCompanion(true));

  Future<int> deleteSession(Session session) =>
      (delete(sessions)..whereSamePrimaryKey(session.toCompanion(true)))
          .delete(session.toCompanion(true));
}
