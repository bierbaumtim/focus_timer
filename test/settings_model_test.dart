import 'package:flutter_test/flutter_test.dart';

import 'package:focus_timer/repositories/mocks/mock_settings_repository.dart';
import 'package:focus_timer/state_models/settings_model.dart';

import 'package:mockito/mockito.dart';

void main() {
  group('SettingsModel tests ->', () {
    group('first start tests ->', () {
      final repo = MockSettingsRepository();

      SettingsModel model;

      setUp(() {
        when(repo.loadSettings()).thenReturn(
          <String, dynamic>{},
        );

        model = SettingsModel(repo);
      });

      test('loading settings ', () {
        expect(model.settings, equals(<String, dynamic>{}));

        expect(model.darkmode, isTrue);
      });

      test('change darkmode', () {
        model.changeDarkmode(false);

        expect(model.settings, equals(<String, dynamic>{'darkmode': false}));

        expect(model.darkmode, isFalse);
      });
    });

    group('normal tests ->', () {
      final repo = MockSettingsRepository();

      SettingsModel model;

      setUp(() {
        when(repo.loadSettings()).thenReturn(
          <String, dynamic>{'darkmode': false},
        );

        model = SettingsModel(repo);
      });

      test('load settings', () {
        expect(model.settings, equals(<String, dynamic>{'darkmode': false}));

        expect(model.darkmode, isFalse);
      });

      test('change darkmode', () {
        model.changeDarkmode(true);

        expect(model.settings, equals(<String, dynamic>{'darkmode': true}));

        expect(model.darkmode, isTrue);
      });
    });
  });
}
