import 'package:focus_timer/models/session.dart';
import 'package:focus_timer/models/task.dart';

abstract class IStorageRepository {
  Future<List<Task>> loadTasks();
  Future<List<Session>> loadSessions();
  Future<void> saveTasks(List<Task> task);
  Future<void> saveSessions(List<Session> sessions);
}

class StorageRepository implements IStorageRepository {
  @override
  Future<List<Session>> loadSessions() {
    // TODO: implement loadSessions
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> loadTasks() {
    // TODO: implement loadTasks
    throw UnimplementedError();
  }

  @override
  Future<void> saveSessions(List<Session> sessions) {
    // TODO: implement saveSessions
    throw UnimplementedError();
  }

  @override
  Future<void> saveTasks(List<Task> task) {
    // TODO: implement saveTasks
    throw UnimplementedError();
  }
}
