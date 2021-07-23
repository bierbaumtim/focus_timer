import 'package:flutter/foundation.dart';

import 'package:uuid/uuid.dart';

import '../models/task.dart';
import '../repositories/interfaces/tasks_repository_interface.dart';

class TasksModel extends ChangeNotifier {
  final ITasksRepository repository;

  TasksModel(this.repository) {
    _allTasksCompleted = false;
    _filterTasks = true;
    _tasks = <Task>[];
    loadTasks();
  }

  late List<Task> _tasks;
  late bool _allTasksCompleted, _filterTasks;

  List<Task> get filteredTasks => _filterTasks
      ? tasks.where((element) => !element.isCompleted).toList()
      : tasks;

  List<Task> get tasks => _tasks;
  bool get allTasksCompleted => _allTasksCompleted;
  bool get filterTasks => _filterTasks;

  Future<void> loadTasks() async {
    _tasks = await repository.loadTasks();
    notifyListeners();
  }

  void createTask(String taskName) {
    final task = Task(
      name: taskName,
      isCompleted: false,
      uuid: const Uuid().v4(),
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
    var effectiveNewIndex = newIndex;
    var effectiveOldIndex = oldIndex;
    if (newIndex > oldIndex) {
      effectiveNewIndex--;
    }
    if (filterTasks) {
      final newIndexTask = filteredTasks.elementAt(effectiveNewIndex);
      final oldIndexTask = filteredTasks.elementAt(effectiveOldIndex);
      effectiveNewIndex = _tasks.indexOf(newIndexTask);
      effectiveOldIndex = _tasks.indexOf(oldIndexTask);
    }
    final oldTask = _tasks.removeAt(effectiveOldIndex);
    _tasks.insert(effectiveNewIndex, oldTask);
    notifyListeners();
  }

  void toggleFilter({bool? value}) {
    _filterTasks = value ?? !_filterTasks;
    notifyListeners();
  }
}
