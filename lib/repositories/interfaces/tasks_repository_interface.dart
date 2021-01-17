import '../../models/task.dart';

abstract class ITasksRepository {
  Future<List<Task>> loadTasks();
  Future<String> saveTask(Task task);
  Future<int> updateTask(Task task);
  Future<int> removeTask(Task task);
}
