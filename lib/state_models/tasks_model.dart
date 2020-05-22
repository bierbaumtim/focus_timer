import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../repositories/interfaces/tasks_repository_interface.dart';

class TasksModel extends ChangeNotifier {
  final ITasksRepository repository;

  TasksModel(this.repository) : assert(repository != null) {
    _allTasksCompleted = false;
    _tasks = <Task>[];
    loadTasks();
  }

  List<Task> _tasks;
  bool _allTasksCompleted;

  List<Task> get tasks => _tasks;
  bool get allTasksCompleted => _allTasksCompleted;

  Future<void> loadTasks() async {
    _tasks = await repository.loadTasks();
    notifyListeners();
  }

  void createTask(String taskName) {
    final task = Task(
      name: taskName,
      isCompleted: false,
      uuid: Uuid().v4(),
    );
    addTask(task);
  }

  void addTask(Task task) {
    _tasks.add(task);
    repository.saveTask(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    _tasks = _tasks.map<Task>((t) => t.uuid == task.uuid ? task : t).toList();
    repository.updateTask(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.removeWhere((t) => t.uuid == task.uuid);
    repository.removeTask(task);
    notifyListeners();
  }

  void reorderTasks(int oldIndex, int newIndex) {
    final oldTask = _tasks.removeAt(oldIndex);
    tasks.insert(newIndex, oldTask);
    notifyListeners();
  }
}
