import '../../database/app_database.dart';

abstract class ITasksRepository {
  Future<List<Task>> loadTasks();
  Future<int> saveTask(Task task);
  Future<bool> updateTask(Task task);
  Future<int> removeTask(Task task);
}
