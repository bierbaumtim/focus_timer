import '../../models/task.dart';

abstract class ITasksRepository {
  Future<List<Task>> loadTasks();
  Future<void> saveTasks(List<Task> tasks);
  Future<void> saveTask(Task task);
  Future<int> removeTask(Task task);
}
