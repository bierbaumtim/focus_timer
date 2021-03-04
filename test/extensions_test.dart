import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:focus_timer/extensions/num_extensions.dart';
import 'package:focus_timer/extensions/text_style_extension.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('extensions tests ->', () {
    group('num extensions ->', () {
      test('isBetween false', () {
        expect(200.isBetween(0, 40), isFalse);
      });

      test('isBetween true', () {
        expect(200.isBetween(-5, 201), isTrue);
      });
    });

    group('TextStyle extensions -> ', () {
      test('Black with opacity 0', () {
        final style = const TextStyle(color: Colors.black).colorWithOpacity(0);

        expect(
          style.color!.alpha,
          equals(0),
        );

        expect(style.color!.value, equals(const Color(0x00000000).value));
      });

      test('Black with opacity 0.5', () {
        final style =
            const TextStyle(color: Colors.black).colorWithOpacity(0.5);

        expect(
          style.color!.alpha,
          equals(128),
        );
      });

      test('Black with opacity 1', () {
        final style = const TextStyle(color: Colors.black).colorWithOpacity(1);

        expect(
          style.color!.alpha,
          equals(255),
        );

        expect(style.color!.value, equals(const Color(0xFF000000).value));
      });
    });
  });
}
