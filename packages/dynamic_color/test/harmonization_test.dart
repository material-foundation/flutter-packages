import 'package:dynamic_color/src/harmonization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Color harmonization', () {
    test('green with blue', () {
      Color colorA = Colors.green;
      Color colorB = Colors.blue;
      Color harmonized = const Color(0xff00b171); // Green with a bit of blue
      expect(colorA.harmonizeWith(colorB), harmonized);
    });

    test('blue with green', () {
      Color colorA = Colors.blue;
      Color colorB = Colors.green;
      Color harmonized = const Color(0xff009bd9); // Blue with a bit of green
      expect(colorA.harmonizeWith(colorB), harmonized);
    });

    test('blue (no opacity) with green, opacity is ignored', () {
      Color colorA = Colors.blue.withOpacity(0);
      Color colorB = Colors.green;
      Color harmonized = const Color(0xff009bd9); // Blue with a bit of green
      expect(colorA.harmonizeWith(colorB), harmonized);
    });

    test('blue with green (no opacity), opacity is ignored', () {
      Color colorA = Colors.blue;
      Color colorB = Colors.green.withOpacity(0);
      Color harmonized = const Color(0xff009bd9); // Blue with a bit of green
      expect(colorA.harmonizeWith(colorB), harmonized);
    });

    test('green with white', () {
      Color colorA = Colors.green;
      Color colorB = Colors.white;
      Color harmonized = const Color(0xff00b171); // Green with a bit of white
      expect(colorA.harmonizeWith(colorB), harmonized);
    });

    test('white with green, remains white', () {
      expect(Colors.white.harmonizeWith(Colors.green), Colors.white);
    });

    test('green with black', () {
      Color colorA = Colors.green;
      Color colorB = Colors.black;
      Color harmonized = const Color(0xff76aa2e); // Green with a bit of black
      expect(colorA.harmonizeWith(colorB), harmonized);
    });

    test('black with green, remains black', () {
      expect(Colors.black.harmonizeWith(Colors.green), Colors.black);
    });

    test('same color, remains the same', () {
      expect(Colors.green.harmonizeWith(Colors.green), Colors.green);
    });
  });

  group('ColorScheme harmonization', () {
    test('modifies a color scheme', () {
      ColorScheme colorScheme = const ColorScheme.light();
      expect(colorScheme.harmonized(), isNot(equals(colorScheme)));
    });

    test('changes depending on input colors', () {
      ColorScheme colorScheme = const ColorScheme.light();
      ColorScheme colorSchemeWithPrimary = colorScheme.copyWith(
        primary: Colors.amber,
      );
      ColorScheme colorSchemeWithError = colorScheme.copyWith(
        error: Colors.blue,
      );
      ColorScheme colorSchemeWithPrimaryAndError = colorScheme.copyWith(
        primary: Colors.amber,
        error: Colors.blue,
      );

      List<ColorScheme> harmonizedColorSchemes = [
        colorScheme.harmonized(),
        colorSchemeWithPrimary.harmonized(),
        colorSchemeWithError.harmonized(),
        colorSchemeWithPrimaryAndError.harmonized(),
      ];

      // Expect all [ColorScheme]s to be different.
      expect(
        harmonizedColorSchemes.toSet().length,
        harmonizedColorSchemes.length,
      );
    });
  });
}
