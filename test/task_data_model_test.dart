import 'package:flutter_test/flutter_test.dart';
import 'package:focus_timer/models/task.dart';
import 'package:uuid/uuid.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Task data model tests ->', () {
    group('constructor tests ->', () {
      test('named constructor', () {
        final uuid = const Uuid().v4();
        final task = Task(
          name: 'Test Name',
          uuid: uuid,
          isCompleted: true,
          sortId: 1,
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
          uuid: const Uuid().v4(),
          sortId: 1,
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
          uuid: const Uuid().v4(),
          sortId: 1,
        );
        final json = task.toJson();

        expect(
          json,
          equals(
            <String, dynamic>{
              'uuid': task.uuid,
              'name': 'Test Name',
              'isCompleted': false,
            },
          ),
        );
      });

      test('json decoding', () {
        final uuid = const Uuid().v4();
        final task = Task.fromJson(
          <String, dynamic>{
            'uuid': uuid,
            'name': 'Test Name',
            'isCompleted': false,
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
