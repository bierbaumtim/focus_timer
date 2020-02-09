import 'package:flutter_test/flutter_test.dart';
import 'package:focus_timer/models/task.dart';
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
          sessionUId: '',
        );

        expect(task, isA<Task>());
        expect(task.name, equals('Test Name'));
        expect(task.sessionUId, equals(''));
        expect(task.isCompleted, isTrue);
        expect(task.uuid, equals(uuid));
        expect(
          task.props,
          equals(
            [
              'Test Name',
              uuid,
              '',
              true,
            ],
          ),
        );
      });

      test('factory constructor', () {
        final task = Task.create('Test Name');

        expect(task, isA<Task>());
        expect(task.name, equals('Test Name'));
        expect(task.sessionUId, equals(''));
        expect(task.isCompleted, isFalse);
        expect(task.uuid.isNotEmpty, isTrue);
        expect(
          task.props,
          equals(
            [
              'Test Name',
              task.uuid,
              '',
              false,
            ],
          ),
        );
      });
    });

    group('json convert tests ->', () {
      test('json encoding', () {
        final task = Task.create('Test Name');
        final json = task.toJson();

        expect(
          json,
          equals(
            <String, dynamic>{
              'name': 'Test Name',
              'uuid': task.uuid,
              'session_uuid': '',
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
            'session_uuid': '',
            'iscompleted': false,
          },
        );

        expect(task, isA<Task>());
        expect(task.name, equals('Test Name'));
        expect(task.sessionUId, equals(''));
        expect(task.isCompleted, isFalse);
        expect(task.uuid, equals(uuid));
        expect(
          task.props,
          equals(
            [
              'Test Name',
              uuid,
              '',
              false,
            ],
          ),
        );
      });
    });
  });
}
