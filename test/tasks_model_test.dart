import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import 'package:focus_timer/models/task.dart';
import 'package:focus_timer/repositories/mocks/mock_task_repository.dart';
import 'package:focus_timer/state_models/tasks_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final defaultTasksList = List.generate(
    10,
    (index) => Task(
      name: 'Test $index',
      isCompleted: false,
      uuid: const Uuid().v4(),
      sortId: index,
    ),
  );

  group('TasksModel tests', () {
    final repo = MockTaskRepository();

    late TasksModel model;

    when(repo.loadTasks()).thenAnswer((_) async => defaultTasksList);

    setUp(() {
      model = TasksModel(repo);
    });

    test('load tasks', () {
      expect(model.allTasksCompleted, isFalse);

      expect(model.tasks.length, equals(10));

      expect(model.tasks, equals(defaultTasksList));
    });

    test('add task', () {
      final newTask = Task(
        name: 'New Task Test',
        isCompleted: false,
        uuid: const Uuid().v4(),
        sortId: 11,
      );

      model.addTask(newTask);

      expect(model.tasks.length, equals(11));

      expect(model.tasks.last, equals(newTask));
    });

    test(
      'update task',
      () {
        final task = defaultTasksList[1].copyWith(
          isCompleted: !defaultTasksList[1].isCompleted,
        );

        model.updateTask(task);

        expect(model.tasks.length, equals(11));

        expect(model.tasks[1], equals(task));
      },
    );

    test('remove task', () {
      model.removeTask(defaultTasksList.last);

      expect(model.tasks.length, equals(10));

      expect(model.tasks.last, equals(defaultTasksList[9]));
    });
  });
}
