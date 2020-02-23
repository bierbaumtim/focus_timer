import 'package:flutter_test/flutter_test.dart';
import 'package:focus_timer/models/task.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Task data model tests ->', () {
    group('data creation tests', () {
      test('Name: Test Name 1', () {
        final task = Task.create('Test Name 1');

        expect(task, isA<Task>());
        expect(task.name, equals('Test Name 1'));
        expect(task.isCompleted, isFalse);
        expect(task.sessionUId, equals(''));
        expect(task.props.contains(''), isTrue);
        expect(task.props.contains('Test Name 1'), isTrue);
        expect(task.props.contains(false), isTrue);
      });
    });

    group('toggleIsCompleted tests', () {
      test('toggle from false to true', () {
        final task = Task.create('Test: false to true');

        expect(task.isCompleted, isFalse);
        task.toggleIsCompleted();
        expect(task.isCompleted, isTrue);
      });

      test('toggle from false to true', () {
        final task = Task(
          name: 'Test: false to true',
          sessionUId: '',
          uuid: Uuid().v4(),
          isCompleted: true,
        );

        expect(task.isCompleted, isTrue);
        task.toggleIsCompleted();
        expect(task.isCompleted, isFalse);
      });
    });

    group('json tests', () {
      test('json decoding', () {
        final task = Task.create('JsonDecoding');
        final json = task.toJson();

        expect(
          json,
          equals(
            <String, dynamic>{
              'name': 'JsonDecoding',
              'uuid': task.uuid,
              'iscompleted': false,
              'session_uuid': '',
            },
          ),
        );
      });

      test('json encoding', () {
        final task = Task.create('JsonEncoding');
      });
    });
  });
}
