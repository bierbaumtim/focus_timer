import '../database/tasks_dao.dart';
import '../models/task.dart';
import 'interfaces/tasks_repository_interface.dart';

class TasksRepository implements ITasksRepository {
  final TasksDao tasksDao;

  const TasksRepository(this.tasksDao);

  @override
  Future<List<Task>> loadTasks() => tasksDao.getAllTasks;

  @override
  Future<int> removeTask(Task task) => tasksDao.deleteTask(task);

  @override
  Future<String> saveTask(Task task) => tasksDao.insertTask(task);

  @override
  Future<int> updateTask(Task task) => tasksDao.updateTask(task);
}
