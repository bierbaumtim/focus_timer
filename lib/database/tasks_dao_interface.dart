import '../models/task.dart';

abstract class ITasksDao {
  Future<List<Task>> get getAllTasks;

  Future<String> insertTask(Task task);

  Future<int> updateTask(Task task);

  Future<int> deleteTask(Task task);
}
