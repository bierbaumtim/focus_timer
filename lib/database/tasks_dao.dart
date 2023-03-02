import 'package:sembast/sembast.dart';

import '../models/task.dart';
import 'tasks_dao_interface.dart';

class TasksDao implements ITasksDao {
  final Database db;

  TasksDao(this.db);

  final store = stringMapStoreFactory.store('tasks');

  @override
  Future<List<Task>> get getAllTasks async {
    final snapshots = await store.find(db);

    return snapshots
        .map<Task>(
          (s) => Task.fromJson(s.value),
        )
        .toList();
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    await Future.wait(
      tasks.map(
        (task) => store.record(task.uuid).put(
              db,
              task.toJson(),
            ),
      ),
    );
  }

  @override
  Future<void> saveTask(Task task) async =>
      store.record(task.uuid).put(db, task.toJson());

  @override
  Future<int> deleteTask(Task task) {
    final finder = Finder(
      filter: Filter.equals('uuid', task.uuid),
    );

    return store.delete(
      db,
      finder: finder,
    );
  }
}
