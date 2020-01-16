import 'package:focus_timer/constants/hive_constants.dart';
import 'package:focus_timer/models/session.dart';
import 'package:focus_timer/models/task.dart';
import 'package:hive/hive.dart';

abstract class IStorageRepository {
  List<Task> loadTasks();
  List<Session> loadSessions();
  Future<void> saveTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> saveSession(Session session);
  Future<void> saveSessions(List<Session> sessions);
  Future<void> updateSession(Session session);
  Future<void> removeSession(Session session);
}

class StorageRepository implements IStorageRepository {
  int lastSessionKey;

  @override
  List<Session> loadSessions() {
    final sessionsBox = Hive.box(kSessionsHiveBox);
    var sessions = <Session>[];
    sessions =
        sessionsBox.get(kSessionsHiveKey) as List<Session> ?? <Session>[];
    // sessionsBox.toMap().forEach((k, v) => sessions.add(v as Session));
    return sessions;
  }

  @override
  List<Task> loadTasks() {
    final tasksBox = Hive.box(kTasksHiveBox);
    var tasks = tasksBox.values as List<Task>;
    return tasks;
  }

  @override
  Future<void> saveSessions(List<Session> sessions) async {
    for (var session in sessions) {
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

  @override
  Future<void> saveTask(Task task) {
    // TODO: implement saveTask
    throw UnimplementedError();
  }

  @override
  Future<void> updateTask(Task task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
