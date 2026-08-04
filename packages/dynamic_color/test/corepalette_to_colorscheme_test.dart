import 'package:dynamic_color/src/corepalette_to_colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

void main() {
  group('CorePalette.toColorScheme', () {
    const sourceColor = Color(0xff00bfa5);

    test('fills the new surface roles for light schemes', () {
      final corePalette = CorePalette.of(sourceColor.value);
      final colorScheme = corePalette.toColorScheme();
      final seedScheme = ColorScheme.fromSeed(
        seedColor: Color(Scheme.lightFromCorePalette(corePalette).primary),
      );

      expect(colorScheme.surface, seedScheme.surface);
      expect(colorScheme.surfaceDim, seedScheme.surfaceDim);
      expect(colorScheme.surfaceBright, seedScheme.surfaceBright);
      expect(
        colorScheme.surfaceContainerLowest,
        seedScheme.surfaceContainerLowest,
      );
      expect(colorScheme.surfaceContainerLow, seedScheme.surfaceContainerLow);
      expect(colorScheme.surfaceContainer, seedScheme.surfaceContainer);
      expect(colorScheme.surfaceContainerHigh, seedScheme.surfaceContainerHigh);
      expect(
        colorScheme.surfaceContainerHighest,
        seedScheme.surfaceContainerHighest,
      );
      expect(colorScheme.surfaceTint, seedScheme.surfaceTint);
    });

    test('fills the new surface roles for dark schemes', () {
      final corePalette = CorePalette.of(sourceColor.value);
      final colorScheme = corePalette.toColorScheme(
        brightness: Brightness.dark,
      );
      final seedScheme = ColorScheme.fromSeed(
        seedColor: Color(Scheme.darkFromCorePalette(corePalette).primary),
        brightness: Brightness.dark,
      );

      expect(colorScheme.surface, seedScheme.surface);
      expect(colorScheme.surfaceDim, seedScheme.surfaceDim);
      expect(colorScheme.surfaceBright, seedScheme.surfaceBright);
      expect(
        colorScheme.surfaceContainerLowest,
        seedScheme.surfaceContainerLowest,
      );
      expect(colorScheme.surfaceContainerLow, seedScheme.surfaceContainerLow);
      expect(colorScheme.surfaceContainer, seedScheme.surfaceContainer);
      expect(colorScheme.surfaceContainerHigh, seedScheme.surfaceContainerHigh);
      expect(
        colorScheme.surfaceContainerHighest,
        seedScheme.surfaceContainerHighest,
      );
      expect(colorScheme.surfaceTint, seedScheme.surfaceTint);
    });
  });
}
