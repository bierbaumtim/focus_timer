import 'package:hive/hive.dart';

import 'package:focus_timer/constants/hive_constants.dart';
import 'package:focus_timer/models/task.dart';

abstract class ITasksRepository {
  List<Task> loadTasks();
  Future<void> saveTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> removeTask(Task task);
}

class TasksRepository implements ITasksRepository {
  @override
  List<Task> loadTasks() {
    final tasksBox = Hive.box(kTasksHiveBox);
    return tasksBox.get(kTasksHiveKey) as List<Task> ?? <Task>[];
  }

  @override
  Future<void> removeTask(Task task) {
    final tasksBox = Hive.box(kTasksHiveBox);
    return tasksBox.delete(task.uuid);
  }

  @override
  Future<void> saveTask(Task task) {
    final tasksBox = Hive.box(kTasksHiveBox);
    return tasksBox.put(task.uuid, task);
  }

  @override
  Future<void> updateTask(Task task) {
    final tasksBox = Hive.box(kTasksHiveBox);
    return tasksBox.put(task.uuid, task);
  }
}
