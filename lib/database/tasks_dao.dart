import 'package:sembast/sembast.dart';

import '../models/task.dart';
import 'tasks_dao_interface.dart';

class TasksDao implements ITasksDao {
  final Database db;

  TasksDao(this.db);

  final store = stringMapStoreFactory.store('tasks');

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
  Future<String> insertTask(Task task) {
    return store.add(
      db,
      task.toJson(),
    );
  }

  @override
  Future<int> updateTask(Task task) {
    final finder = Finder(
      filter: Filter.equals(
        'uuid',
        task.uuid,
      ),
    );

    return store.update(
      db,
      task.toJson(),
      finder: finder,
    );
  }
}
