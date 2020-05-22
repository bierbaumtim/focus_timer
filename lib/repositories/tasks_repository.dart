import '../database/app_database.dart';
import '../database/daos/tasks_dao.dart';
import 'interfaces/tasks_repository_interface.dart';

class TasksRepository implements ITasksRepository {
  final TasksDao tasksDao;

  const TasksRepository(this.tasksDao);

  @override
  Future<List<Task>> loadTasks() => tasksDao.getAllTasks;

  @override
  Future<int> removeTask(Task task) => tasksDao.deleteTask(task);

  @override
  Future<int> saveTask(Task task) => tasksDao.insertTask(task);

  @override
  Future<bool> updateTask(Task task) => tasksDao.updateTask(task);
}
