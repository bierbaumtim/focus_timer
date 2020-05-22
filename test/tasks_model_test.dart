import 'package:flutter_test/flutter_test.dart';
import 'package:focus_timer/database/app_database.dart';

import 'package:mockito/mockito.dart';

import 'package:focus_timer/repositories/mocks/mock_task_repository.dart';
import 'package:focus_timer/state_models/tasks_model.dart';
import 'package:uuid/uuid.dart';

void main() {
  final _defaultTasksList = List.generate(
    10,
    (index) => Task(
      name: 'Test $index',
      isCompleted: false,
      uuid: Uuid().v4(),
    ),
  );

  group('TasksModel tests', () {
    final repo = MockTaskRepository();

    TasksModel model;

    when(repo.loadTasks()).thenReturn(_defaultTasksList);

    setUp(() {
      model = TasksModel(repo);
    });

    test('load tasks', () {
      expect(model.allTasksCompleted, isFalse);

      expect(model.tasks.length, equals(10));

      expect(model.tasks, equals(_defaultTasksList));
    });

    test('add task', () {
      final newTask = Task(
        name: 'New Task Test',
        isCompleted: false,
        uuid: Uuid().v4(),
      );

      model.addTask(newTask);

      expect(model.tasks.length, equals(11));

      expect(model.tasks.last, equals(newTask));
    });

    test(
      'update task',
      () {
        final task = _defaultTasksList[1].copyWith(
          isCompleted: !_defaultTasksList[1].isCompleted,
        );

        model.updateTask(task);

        expect(model.tasks.length, equals(11));

        expect(model.tasks[1], equals(task));
      },
    );

    test('remove task', () {
      model.removeTask(_defaultTasksList.last);

      expect(model.tasks.length, equals(10));

      expect(model.tasks.last, equals(_defaultTasksList[9]));
    });
  });
}
