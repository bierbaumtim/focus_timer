import 'package:focus_timer/constants/hive_constants.dart';
import 'package:focus_timer/models/session.dart';
import 'package:focus_timer/models/task.dart';
import 'package:hive/hive.dart';

abstract class IStorageRepository {
  List<Task> loadTasks();
  List<Session> loadSessions();
  Future<void> saveTasks(List<Task> task);
  Future<void> saveSessions(List<Session> sessions);
}

class StorageRepository implements IStorageRepository {
  @override
  List<Session> loadSessions() {
    final sessionsBox = Hive.box(kSessionsHiveBox);
    var sessions = <Session>[];
    sessionsBox.toMap().forEach((k, v) => sessions.add(v as Session));
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
    // TODO: implement saveSessions
    throw UnimplementedError();
  }

  @override
  Future<void> saveTasks(List<Task> task) async {
    // TODO: implement saveTasks
    throw UnimplementedError();
  }
}
