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
      final scheme = Scheme.lightFromCorePalette(corePalette);
      final seedScheme = ColorScheme.fromSeed(
        seedColor: Color(scheme.primary),
      );

      // Keep legacy dynamic-color roles sourced from MCU's Scheme.
      expect(colorScheme.surface, Color(scheme.surface));
      expect(colorScheme.surfaceTint, Color(scheme.primary));

      // New Material surface roles should be populated from seeded values.
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
    });

    test('fills the new surface roles for dark schemes', () {
      final corePalette = CorePalette.of(sourceColor.value);
      final colorScheme = corePalette.toColorScheme(
        brightness: Brightness.dark,
      );
      final scheme = Scheme.darkFromCorePalette(corePalette);
      final seedScheme = ColorScheme.fromSeed(
        seedColor: Color(scheme.primary),
        brightness: Brightness.dark,
      );

      // Keep legacy dynamic-color roles sourced from MCU's Scheme.
      expect(colorScheme.surface, Color(scheme.surface));
      expect(colorScheme.surfaceTint, Color(scheme.primary));

      // New Material surface roles should be populated from seeded values.
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
    });
  });
}
