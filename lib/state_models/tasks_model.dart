import 'package:states_rebuilder/states_rebuilder.dart';

import '../models/task.dart';
import '../repositories/interfaces/tasks_repository_interface.dart';

class TasksModel extends StatesRebuilder {
  final ITasksRepository repository;

  TasksModel(this.repository) : assert(repository != null) {
    _allTasksCompleted = false;
    _tasks = repository.loadTasks();
  }

  List<Task> _tasks;
  bool _allTasksCompleted;

  List<Task> get tasks => _tasks;
  bool get allTasksCompleted => _allTasksCompleted;

  void addTask(Task task) {
    _tasks.add(task);
    repository.saveTask(task);
    if (hasObservers) {
      rebuildStates();
    }
  }

  void updateTask(Task task) {
    _tasks = _tasks.map<Task>((t) => t.uuid == task.uuid ? task : t).toList();
    repository.updateTask(task);
    if (hasObservers) {
      rebuildStates();
    }
  }

  void removeTask(Task task) {
    _tasks.removeWhere((t) => t.uuid == task.uuid);
    repository.removeTask(task);
    if (hasObservers) {
      rebuildStates();
    }
  }
}
