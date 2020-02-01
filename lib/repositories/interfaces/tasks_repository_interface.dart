import '../../models/task.dart';

abstract class ITasksRepository {
  List<Task> loadTasks();
  Future<void> saveTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> removeTask(Task task);
}
