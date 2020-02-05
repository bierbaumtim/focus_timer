import 'package:flutter_test/flutter_test.dart';
import 'package:focus_timer/models/session.dart';

import 'package:focus_timer/repositories/mocks/mock_sessions_repository.dart';
import 'package:focus_timer/repositories/mocks/mock_settings_repository.dart';
import 'package:focus_timer/state_models/session_model.dart';
import 'package:focus_timer/state_models/session_settings_model.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('SessionModel tests ->', () {
    group('first start tests ->', () {
      final sessionsRepo = MockSessionsRepository();
      final settingsRepo = MockSettingsRepository();
      final testSession = Session.create(3600);

      SessionsModel sessionsModel;
      SessionSettingsModel settingsModel;

      setUp(() {
        when(settingsRepo.loadSettings()).thenReturn(
          <String, dynamic>{},
        );

        when(sessionsRepo.loadSessions()).thenReturn(null);

        settingsModel = SessionSettingsModel(settingsRepo);
        sessionsModel = SessionsModel(sessionsRepo, settingsModel);
      });

      test('load sessions', () {
        expect(sessionsModel.sessions.length, equals(12));
      });

      test('add Session', () {
        sessionsModel.addSession(testSession);

        expect(sessionsModel.sessions.length, equals(13));
        expect(sessionsModel.sessions.last, equals(testSession));
      });

      test('add Session at position 5', () {
        final positionSession = Session.create(3600);
        sessionsModel.addSession(positionSession, position: 5);

        expect(sessionsModel.sessions.length, equals(13));
        expect(sessionsModel.sessions.elementAt(5), equals(positionSession));
      });

      test('remove Session which isn\'t in list', () {
        sessionsModel.removeSession(testSession);

        expect(sessionsModel.sessions.length, equals(12));
      });
    });
  });
}
