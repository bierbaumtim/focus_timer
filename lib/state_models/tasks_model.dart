import 'package:focus_timer/models/task.dart';
import 'package:focus_timer/repositories/tasks_repository.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class TasksModel extends StatesRebuilder {
  final ITasksRepository repository;

  TasksModel(this.repository) : assert(repository != null) {
    allTasksCompleted = false;
    tasks = repository.loadTasks();
  }

  List<Task> tasks;
  bool allTasksCompleted;

  void addTask(Task task) {
    tasks.add(task);
    repository.saveTask(task);
    rebuildStates();
  }

  void updateTask(Task task) {
    tasks = tasks.map<Task>((t) => t.uuid == task.uuid ? task : t).toList();
    repository.updateTask(task);
    rebuildStates();
  }

  void removeTask(Task task) {
    tasks.removeWhere((t) => t.uuid == task.uuid);
    repository.removeTask(task);
    rebuildStates();
  }
}
