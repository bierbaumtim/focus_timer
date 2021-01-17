import 'package:flutter_test/flutter_test.dart';

import 'package:focus_timer/repositories/mocks/mock_settings_repository.dart';
import 'package:focus_timer/state_models/session_settings_model.dart';

import 'package:supercharged/supercharged.dart';
import 'package:mockito/mockito.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SessionSettingsModel tests ->', () {
    group('first start tests ->', () {
      final repo = MockSettingsRepository();

      SessionSettingsModel model;

      setUp(() {
        when(repo.loadSettings()).thenAnswer(
          (_) async => <String, dynamic>{},
        );

        model = SessionSettingsModel(repo);
      });

      test('loading settings ', () {
        expect(model.settings, equals(<String, dynamic>{}));

        expect(model.shortBreakDuration, 5.minutes.inSeconds.toDouble());
        expect(model.longBreakDuration, 25.minutes.inSeconds.toDouble());
        expect(model.sessionsDuration, 25.minutes.inSeconds.toDouble());
        expect(model.sessionUntilBreak, 4);
      });

      test('setShortBreakDuration', () {
        model.setShortBreakDuration(12.minutes.inSeconds.toDouble());

        expect(
          model.settings,
          equals(
            <String, dynamic>{
              'short_break_duration': 12.minutes.inSeconds.toDouble(),
            },
          ),
        );

        expect(model.shortBreakDuration, 12.minutes.inSeconds.toDouble());
        expect(model.longBreakDuration, 25.minutes.inSeconds.toDouble());
        expect(model.sessionsDuration, 25.minutes.inSeconds.toDouble());
        expect(model.sessionUntilBreak, 4);
      });
    });

    group('normal tests ->', () {
      final repo = MockSettingsRepository();

      SessionSettingsModel model;

      setUp(() {
        when(repo.loadSettings()).thenAnswer((_) async => _defaultSettings);

        model = SessionSettingsModel(repo);
      });

      test('load settings', () {
        expect(
          model.settings,
          equals(_defaultSettings),
        );

        expect(model.sessionsDuration, 25.minutes.inSeconds.toDouble());
        expect(model.shortBreakDuration, 5.minutes.inSeconds.toDouble());
        expect(model.longBreakDuration, 25.minutes.inSeconds.toDouble());
        expect(model.sessionUntilBreak, 4);
      });

      test('setShortBreakDuration', () {
        model.setShortBreakDuration(12.minutes.inSeconds.toDouble());

        expect(
          model.settings,
          equals(
            <String, dynamic>{
              'short_break_duration': 12.minutes.inSeconds.toDouble(),
              'long_break_duration': 25.minutes.inSeconds.toDouble(),
              'sessions_duration': 25.minutes.inSeconds.toDouble(),
              'sessions_until_break': 4,
            },
          ),
        );

        expect(model.shortBreakDuration, 12.minutes.inSeconds.toDouble());
        expect(model.longBreakDuration, 25.minutes.inSeconds.toDouble());
        expect(model.sessionsDuration, 25.minutes.inSeconds.toDouble());
        expect(model.sessionUntilBreak, 4);
      });

      test('setLongBreakDuration', () {
        model.setLongBreakDuration(36.minutes.inSeconds.toDouble());

        expect(
          model.settings,
          equals(
            <String, dynamic>{
              'short_break_duration': 12.minutes.inSeconds.toDouble(),
              'long_break_duration': 36.minutes.inSeconds.toDouble(),
              'sessions_duration': 25.minutes.inSeconds.toDouble(),
              'sessions_until_break': 4,
            },
          ),
        );

        expect(model.shortBreakDuration, 12.minutes.inSeconds.toDouble());
        expect(model.longBreakDuration, 36.minutes.inSeconds.toDouble());
        expect(model.sessionsDuration, 25.minutes.inSeconds.toDouble());
        expect(model.sessionUntilBreak, 4);
      });

      test('setShortBreakDuration', () {
        model.setSessionDuration(20.minutes.inSeconds.toDouble());

        expect(
          model.settings,
          equals(
            <String, dynamic>{
              'short_break_duration': 12.minutes.inSeconds.toDouble(),
              'long_break_duration': 36.minutes.inSeconds.toDouble(),
              'sessions_duration': 20.minutes.inSeconds.toDouble(),
              'sessions_until_break': 4,
            },
          ),
        );

        expect(model.shortBreakDuration, 12.minutes.inSeconds.toDouble());
        expect(model.longBreakDuration, 36.minutes.inSeconds.toDouble());
        expect(model.sessionsDuration, 20.minutes.inSeconds.toDouble());
        expect(model.sessionUntilBreak, 4);
      });

      test('setShortBreakDuration', () {
        model.setSessionsUntilBreak(6);

        expect(
          model.settings,
          equals(
            <String, dynamic>{
              'short_break_duration': 12.minutes.inSeconds.toDouble(),
              'long_break_duration': 36.minutes.inSeconds.toDouble(),
              'sessions_duration': 20.minutes.inSeconds.toDouble(),
              'sessions_until_break': 6,
            },
          ),
        );

        expect(model.shortBreakDuration, 12.minutes.inSeconds.toDouble());
        expect(model.longBreakDuration, 36.minutes.inSeconds.toDouble());
        expect(model.sessionsDuration, 20.minutes.inSeconds.toDouble());
        expect(model.sessionUntilBreak, 6);
      });
    });
  });
}

final _defaultSettings = <String, dynamic>{
  'short_break_duration': 5.minutes.inSeconds.toDouble(),
  'long_break_duration': 25.minutes.inSeconds.toDouble(),
  'sessions_duration': 25.minutes.inSeconds.toDouble(),
  'sessions_until_break': 4,
};
