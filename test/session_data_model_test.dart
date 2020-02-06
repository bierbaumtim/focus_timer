import 'package:flutter_test/flutter_test.dart';

import 'package:focus_timer/models/session.dart';
import 'package:focus_timer/models/task.dart';

void main() {
  group('Session data model tests ->', () {
    group('data creation tests ->', () {
      test('60 seconds', () {
        final session = Session.create(60);

        expect(session, isA<Session>());
        expect(session.duration, equals(60));
        expect(session.isCompleted, isFalse);
        expect(session.tasks.isEmpty, isTrue);
        expect(session.props.contains(session.uid), isTrue);
        expect(session.props.contains(60), isTrue);
        expect(session.props.contains(session.tasks), isTrue);
        expect(session.props.contains(false), isTrue);
      });
    });

    group('Json tests ->', () {
      test('json decoding', () {
        final session = Session.fromJson(kSessionJson);

        expect(session, isA<Session>());
        expect(session.duration, equals(60));
        expect(session.isCompleted, isTrue);
        expect(session.tasks.isEmpty, isTrue);
        expect(session.uid, equals('41ee837b-c3c2-49df-83c5-0f6dec73d9e1'));
        expect(session.props.contains(session.uid), isTrue);
        expect(session.props.contains(60), isTrue);
        expect(session.props.contains(session.tasks), isTrue);
        expect(session.props.contains(true), isTrue);
      });

      test('json encoding', () {
        final session = Session.create(300);
        final json = session.toJson();

        expect(json['duration'], equals(300));
        expect(json['uid'], equals(session.uid));
        expect(json['tasks'], equals(<Task>[]));
        expect(json['isCompleted'], isFalse);

        final decodedSession = Session.fromJson(json);

        expect(decodedSession, equals(session));
      });
    });

    group('task function tests ->', () {
      test('addTask test', () {
        final session = Session.create(360);
        final task = Task.create('Test Task 1');

        session.addTask(task);

        expect(session.tasks, equals(<Task>[task]));
      });

      test('add same task twice', () {
        final session = Session.create(360);
        final task = Task.create('Test Task 1');

        session.addTask(task);

        expect(session.tasks, equals(<Task>[task]));
        expect(session.tasks.length, equals(1));

        session.addTask(task);

        expect(session.tasks, equals(<Task>[task]));
        expect(session.tasks.length, equals(1));
      });

      test('add 4 tasks test', () {
        final session = Session.create(480);
        final tasks =
            List.generate(4, (index) => Task.create('Test Task $index'));

        for (var task in tasks) {
          session.addTask(task);
        }

        expect(session.tasks.length, equals(4));
        expect(session.tasks, equals(tasks));
      });

      test('remove Task', () {
        final session = Session.create(360);
        final task = Task.create('Test Task 1');

        session.addTask(task);

        expect(session.tasks.isEmpty, isFalse);

        session.removeTask(task.uuid);

        expect(session.tasks.isEmpty, isTrue);
      });
    });
  });
}

const kSessionJson = <String, dynamic>{
  'duration': 60,
  'uid': '41ee837b-c3c2-49df-83c5-0f6dec73d9e1',
  'tasks': [],
  'isCompleted': true,
};
