import 'package:dynamic_colors/harmonization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // TODO(guidezpl): finish tests when monet is available, determine whether to test equality or specific output
  group('Color harmonization', () {
    test('white with black', () async {
      Color colorA = const Color(0xFFFFFFFF);
      Color colorB = const Color(0x00000000);

      expect(colorA.harmonizeWith(colorB), equals(colorA));
    });

    test('same color', () async {
      Color colorA = const Color(0xFFFFFFFF);

      expect(colorA.harmonizeWith(colorA), equals(colorA));
    });
  });

  group('ColorScheme harmonization', () {
    test('with default scheme', () async {
      ColorScheme colorScheme = const ColorScheme.light();
      ColorScheme harmonizedColorScheme = colorScheme.harmonized();

      expect(harmonizedColorScheme, equals(colorScheme));
    });

    test('with different primary color', () async {
      ColorScheme colorScheme = const ColorScheme.light().copyWith(
        primary: Colors.amber,
      );
      ColorScheme harmonizedColorScheme = colorScheme.harmonized();

      expect(harmonizedColorScheme, harmonizedColorScheme);
    });

    test('with different primary and error colors', () async {
      ColorScheme colorScheme = const ColorScheme.light().copyWith(
        primary: Colors.amber,
        error: Colors.blue,
      );
      ColorScheme harmonizedColorScheme = colorScheme.harmonized();

      expect(harmonizedColorScheme, harmonizedColorScheme);
    });
  });
}
