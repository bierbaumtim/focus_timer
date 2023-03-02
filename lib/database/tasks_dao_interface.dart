import '../models/task.dart';

abstract class ITasksDao {
  Future<List<Task>> get getAllTasks;

  Future<void> saveTasks(List<Task> tasks);
  Future<void> saveTask(Task tasks);
  Future<int> deleteTask(Task task);
}
