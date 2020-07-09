import 'package:moor/moor.dart';

import '../app_database.dart';
import '../tables/tasks_table.dart';

part 'tasks_dao.g.dart';

@UseDao(tables: [Tasks])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  TasksDao(AppDatabase attachedDatabase) : super(attachedDatabase);

  Future<List<Task>> get getAllTasks => select(tasks).get();

  Future<int> insertTask(Task task) => into(tasks).insert(task);

  Future<bool> updateTask(Task task) => update(tasks).replace(task);

  Future<int> deleteTask(Task task) => delete(tasks).delete(task);
}
