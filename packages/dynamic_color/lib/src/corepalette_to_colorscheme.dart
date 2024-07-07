import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

extension CorePaletteToColorScheme on CorePalette {
  /// Create a [ColorScheme] from the given `palette` obtained from the Android OS.
  ColorScheme toColorScheme({
    Brightness brightness = Brightness.light,
  }) {
    switch (brightness) {
      case Brightness.light:
        return _toLightColorScheme();
      case Brightness.dark:
        return _toDarkColorScheme();
    }
  }

  ColorScheme _toLightColorScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: Color(primary.get(40)),
      onPrimary: Color(primary.get(100)),
      primaryContainer: Color(primary.get(90)),
      onPrimaryContainer: Color(primary.get(10)),
      primaryFixed: Color(primary.get(90)),
      primaryFixedDim: Color(primary.get(80)),
      onPrimaryFixed: Color(primary.get(10)),
      onPrimaryFixedVariant: Color(primary.get(30)),
      secondary: Color(secondary.get(40)),
      onSecondary: Color(secondary.get(100)),
      secondaryContainer: Color(secondary.get(90)),
      onSecondaryContainer: Color(secondary.get(10)),
      secondaryFixed: Color(secondary.get(90)),
      secondaryFixedDim: Color(secondary.get(80)),
      onSecondaryFixed: Color(secondary.get(10)),
      onSecondaryFixedVariant: Color(secondary.get(30)),
      tertiary: Color(tertiary.get(40)),
      onTertiary: Color(tertiary.get(100)),
      tertiaryContainer: Color(tertiary.get(90)),
      onTertiaryContainer: Color(tertiary.get(10)),
      tertiaryFixed: Color(tertiary.get(90)),
      tertiaryFixedDim: Color(tertiary.get(80)),
      onTertiaryFixed: Color(tertiary.get(10)),
      onTertiaryFixedVariant: Color(tertiary.get(30)),
      error: Color(error.get(40)),
      onError: Color(error.get(100)),
      errorContainer: Color(error.get(90)),
      onErrorContainer: Color(error.get(10)),
      surface: Color(neutral.get(98)),
      onSurface: Color(neutral.get(10)),
      surfaceDim: Color(neutral.get(87)),
      surfaceBright: Color(neutral.get(98)),
      onSurfaceVariant: Color(neutralVariant.get(30)),
      surfaceContainerLowest: Color(neutral.get(100)),
      surfaceContainerLow: Color(neutral.get(96)),
      surfaceContainer: Color(neutral.get(94)),
      surfaceContainerHigh: Color(neutral.get(92)),
      surfaceContainerHighest: Color(neutral.get(90)),
      inverseSurface: Color(neutral.get(20)),
      onInverseSurface: Color(neutral.get(95)),
      inversePrimary: Color(primary.get(80)),
      outline: Color(neutralVariant.get(50)),
      outlineVariant: Color(neutralVariant.get(80)),
    );
  }

  ColorScheme _toDarkColorScheme() {
    return ColorScheme(
      brightness: Brightness.dark,
      primary: Color(primary.get(80)),
      onPrimary: Color(primary.get(20)),
      primaryContainer: Color(primary.get(30)),
      onPrimaryContainer: Color(primary.get(90)),
      primaryFixed: Color(primary.get(90)),
      primaryFixedDim: Color(primary.get(80)),
      onPrimaryFixed: Color(primary.get(10)),
      onPrimaryFixedVariant: Color(primary.get(30)),
      secondary: Color(secondary.get(80)),
      onSecondary: Color(secondary.get(20)),
      secondaryContainer: Color(secondary.get(30)),
      onSecondaryContainer: Color(secondary.get(90)),
      secondaryFixed: Color(secondary.get(90)),
      secondaryFixedDim: Color(secondary.get(80)),
      onSecondaryFixed: Color(secondary.get(10)),
      onSecondaryFixedVariant: Color(secondary.get(30)),
      tertiary: Color(tertiary.get(80)),
      onTertiary: Color(tertiary.get(20)),
      tertiaryContainer: Color(tertiary.get(30)),
      onTertiaryContainer: Color(tertiary.get(90)),
      tertiaryFixed: Color(tertiary.get(90)),
      tertiaryFixedDim: Color(tertiary.get(80)),
      onTertiaryFixed: Color(tertiary.get(10)),
      onTertiaryFixedVariant: Color(tertiary.get(30)),
      error: Color(error.get(80)),
      onError: Color(error.get(20)),
      errorContainer: Color(error.get(30)),
      onErrorContainer: Color(error.get(90)),
      surface: Color(neutral.get(6)),
      onSurface: Color(neutral.get(90)),
      surfaceDim: Color(neutral.get(6)),
      surfaceBright: Color(neutral.get(24)),
      onSurfaceVariant: Color(neutralVariant.get(80)),
      surfaceContainerLowest: Color(neutral.get(4)),
      surfaceContainerLow: Color(neutral.get(10)),
      surfaceContainer: Color(neutral.get(12)),
      surfaceContainerHigh: Color(neutral.get(17)),
      surfaceContainerHighest: Color(neutral.get(22)),
      inverseSurface: Color(neutral.get(90)),
      onInverseSurface: Color(neutral.get(20)),
      inversePrimary: Color(primary.get(40)),
      outline: Color(neutralVariant.get(60)),
      outlineVariant: Color(neutralVariant.get(30)),
    );
  }
}
