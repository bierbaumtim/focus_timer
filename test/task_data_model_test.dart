import 'package:flutter_test/flutter_test.dart';
import 'package:focus_timer/database/app_database.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Task data model tests ->', () {
    group('constructor tests ->', () {
      test('named constructor', () {
        final uuid = Uuid().v4();
        final task = Task(
          name: 'Test Name',
          uuid: uuid,
          isCompleted: true,
        );

        expect(task, isA<Task>());
        expect(task.name, equals('Test Name'));
        expect(task.isCompleted, isTrue);
        expect(task.uuid, equals(uuid));
      });

      test('factory constructor', () {
        final task = Task(
          name: 'Test Name',
          isCompleted: false,
          uuid: Uuid().v4(),
        );

        expect(task, isA<Task>());
        expect(task.name, equals('Test Name'));
        expect(task.isCompleted, isFalse);
        expect(task.uuid.isNotEmpty, isTrue);
      });
    });

    group('json convert tests ->', () {
      test('json encoding', () {
        final task = Task(
          name: 'Test Name',
          isCompleted: false,
          uuid: Uuid().v4(),
        );
        final json = task.toJson();

        expect(
          json,
          equals(
            <String, dynamic>{
              'name': 'Test Name',
              'uuid': task.uuid,
              'iscompleted': false,
            },
          ),
        );
      });

      test('json decoding', () {
        final uuid = Uuid().v4();
        final task = Task.fromJson(
          <String, dynamic>{
            'name': 'Test Name',
            'uuid': uuid,
            'iscompleted': false,
          },
        );

        expect(task, isA<Task>());
        expect(task.name, equals('Test Name'));
        expect(task.isCompleted, isFalse);
        expect(task.uuid, equals(uuid));
      });
    });
  });
}
