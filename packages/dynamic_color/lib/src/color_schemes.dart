import 'package:flutter/material.dart';

class ColorSchemes {
  final ColorScheme light;
  final ColorScheme dark;

  const ColorSchemes({required this.light, required this.dark});

  factory ColorSchemes.fromList(List<int> colors) {
    return ColorSchemes(
      light: _colorSchemeFromList(colors, 0, Brightness.light),
      dark: _colorSchemeFromList(colors, 1, Brightness.dark),
    );
  }
}

ColorScheme _colorSchemeFromList(
    List<int> colors, int n, Brightness brightness) {
  int offset = (colors.length ~/ 2) * n;
  return ColorScheme(
    brightness: brightness,
    primary: Color(colors[offset + 0]),
    onPrimary: Color(colors[offset + 1]),
    primaryContainer: Color(colors[offset + 2]),
    onPrimaryContainer: Color(colors[offset + 3]),
    primaryFixed: Color(colors[offset + 4]),
    primaryFixedDim: Color(colors[offset + 5]),
    onPrimaryFixed: Color(colors[offset + 6]),
    onPrimaryFixedVariant: Color(colors[offset + 7]),
    secondary: Color(colors[offset + 8]),
    onSecondary: Color(colors[offset + 9]),
    secondaryContainer: Color(colors[offset + 10]),
    onSecondaryContainer: Color(colors[offset + 11]),
    secondaryFixed: Color(colors[offset + 12]),
    secondaryFixedDim: Color(colors[offset + 13]),
    onSecondaryFixed: Color(colors[offset + 14]),
    onSecondaryFixedVariant: Color(colors[offset + 15]),
    tertiary: Color(colors[offset + 16]),
    onTertiary: Color(colors[offset + 17]),
    tertiaryContainer: Color(colors[offset + 18]),
    onTertiaryContainer: Color(colors[offset + 19]),
    tertiaryFixed: Color(colors[offset + 20]),
    tertiaryFixedDim: Color(colors[offset + 21]),
    onTertiaryFixed: Color(colors[offset + 22]),
    onTertiaryFixedVariant: Color(colors[offset + 23]),
    error: Color(colors[offset + 24]),
    onError: Color(colors[offset + 25]),
    errorContainer: Color(colors[offset + 26]),
    onErrorContainer: Color(colors[offset + 27]),
    surface: Color(colors[offset + 28]),
    onSurface: Color(colors[offset + 29]),
    surfaceDim: Color(colors[offset + 30]),
    surfaceBright: Color(colors[offset + 31]),
    onSurfaceVariant: Color(colors[offset + 32]),
    surfaceContainerLowest: Color(colors[offset + 33]),
    surfaceContainerLow: Color(colors[offset + 34]),
    surfaceContainer: Color(colors[offset + 35]),
    surfaceContainerHigh: Color(colors[offset + 36]),
    surfaceContainerHighest: Color(colors[offset + 37]),
    inverseSurface: Color(colors[offset + 38]),
    onInverseSurface: Color(colors[offset + 39]),
    inversePrimary: Color(colors[offset + 40]),
    outline: Color(colors[offset + 41]),
    outlineVariant: Color(colors[offset + 42]),
  );
}
