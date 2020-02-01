import 'package:flutter_test/flutter_test.dart';
import 'package:focus_timer/utils/time_utils.dart';

void main() {
  group('utils tests', () {
    group('time utils tests', () {
      test('60 seconds - 1 min', () {
        expect(timeToString(60), equals('01:00'));
      });

      test('3600 seconds - 1 hour', () {
        expect(timeToString(3600), equals('01:00'));
      });

      test('1500 seconds - 25 min', () {
        expect(timeToString(1500), equals('25:00'));
      });

      test('3710 seconds - 1 hour, 1 min, 50 sec', () {
        expect(timeToString(3710), equals('01:01:50'));
      });
    });
  });
}
