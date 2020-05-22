import 'package:flutter_test/flutter_test.dart';
import 'package:focus_timer/database/app_database.dart';

import 'package:uuid/uuid.dart';

void main() {
  group('Session data model tests ->', () {
    group('data creation tests ->', () {
      test('60 seconds', () {
        final session = Session(
          duration: 60,
          uuid: Uuid().v4(),
          isCompleted: false,
        );

        expect(session, isA<Session>());
        expect(session.duration, equals(60));
        expect(session.isCompleted, isFalse);
        expect(session.uuid, isNotNull);
      });
    });

    group('task function tests ->', () {
      test('copyWith test', () {
        var session = Session(
          duration: 1000,
          uuid: Uuid().v4(),
          isCompleted: false,
        );

        expect(session, isA<Session>());
        expect(session.duration, equals(1000));
        expect(session.isCompleted, isFalse);
        expect(session.uuid, isNotNull);

        session = session.copyWith(
          duration: 360,
        );

        expect(session, isA<Session>());
        expect(session.duration, equals(360));
        expect(session.isCompleted, isFalse);
        expect(session.uuid, isNotNull);
      });
    });
  });
}
