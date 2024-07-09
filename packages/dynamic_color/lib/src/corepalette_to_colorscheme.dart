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
      surface: _guessTone(neutral, 98),
      onSurface: Color(neutral.get(10)),
      surfaceDim: _guessTone(neutral, 87),
      surfaceBright: _guessTone(neutral, 98),
      onSurfaceVariant: Color(neutralVariant.get(30)),
      surfaceContainerLowest: Color(neutral.get(100)),
      surfaceContainerLow: _guessTone(neutral, 96),
      surfaceContainer: _guessTone(neutral, 94),
      surfaceContainerHigh: _guessTone(neutral, 92),
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
      surface: _guessTone(neutral, 6),
      onSurface: Color(neutral.get(90)),
      surfaceDim: _guessTone(neutral, 6),
      surfaceBright: _guessTone(neutral, 24),
      onSurfaceVariant: Color(neutralVariant.get(80)),
      surfaceContainerLowest: _guessTone(neutral, 4),
      surfaceContainerLow: Color(neutral.get(10)),
      surfaceContainer: _guessTone(neutral, 12),
      surfaceContainerHigh: _guessTone(neutral, 17),
      surfaceContainerHighest: _guessTone(neutral, 22),
      inverseSurface: Color(neutral.get(90)),
      onInverseSurface: Color(neutral.get(20)),
      inversePrimary: Color(primary.get(40)),
      outline: Color(neutralVariant.get(60)),
      outlineVariant: Color(neutralVariant.get(30)),
    );
  }
}

// This logic is taken from material_color_utilities 0.12 - https://github.com/material-foundation/material-color-utilities/blob/be615fc90286787bbe0c04ef58a6987e0e8fdc29/dart/lib/palettes/tonal_palette.dart#L93C5-L111.
// Once flutter updates to the latest version, this workaround can be removed.
Color _guessTone(TonalPalette palette, double tone) {
  // Approximately deduces the original hue and chroma that generated this
  // list of colors.
  // Uses the hue and chroma of the provided color with the highest chroma.

  var bestHue = 0.0, bestChroma = 0.0;
  for (final argb in palette.asList) {
    final hct = Hct.fromInt(argb);
    if (hct.tone == tone) {
      return Color(hct.toInt());
    }

    // If the color is too close to white, its chroma may have been
    // affected by a known issue, so we ignore it.
    // https://github.com/material-foundation/material-color-utilities/issues/140

    if (hct.tone > 98.0) continue;

    if (hct.chroma > bestChroma) {
      bestHue = hct.hue;
      bestChroma = hct.chroma;
    }
  }
  return Color(Hct.from(bestHue, bestChroma, tone).toInt());
}
