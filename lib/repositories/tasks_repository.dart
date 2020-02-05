import 'package:hive/hive.dart';

import '../constants/hive_constants.dart';
import '../models/task.dart';
import 'interfaces/tasks_repository_interface.dart';

class TasksRepository implements ITasksRepository {
  @override
  List<Task> loadTasks() {
    final tasksBox = Hive.box(kTasksHiveBox);
    return tasksBox.values?.whereType<Task>()?.toList() ?? <Task>[];
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

class DesktopTasksRepository implements ITasksRepository {
  @override
  List<Task> loadTasks() {
    return <Task>[];
  }

  @override
  Future<void> removeTask(Task task) {
    // TODO: implement removeTask
    return null;
  }

  @override
  Future<void> saveTask(Task task) {
    // TODO: implement saveTask
    return null;
  }

  @override
  Future<void> updateTask(Task task) {
    // TODO: implement updateTask
    return null;
  }
}
