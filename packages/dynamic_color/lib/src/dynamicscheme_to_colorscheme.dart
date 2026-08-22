import 'package:dynamic_color/src/variant_to_dynamicschemevariant.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:material_ui/material_ui.dart';

extension DynamicSchemeToColorScheme on DynamicScheme {
  /// Create a [ColorScheme] from the given scheme.
  ColorScheme toColorScheme() {
    // We start from a seed to set coherent colors in the case new ones are
    // added to [ColorScheme] and the package is not updated.
    final colorScheme = ColorScheme.fromSeed(
        brightness: isDark ? Brightness.dark : Brightness.light,
        contrastLevel: contrastLevel,
        dynamicSchemeVariant: variant.toDynamicSchemeVariant(),
        seedColor: Color(sourceColorArgb));

    return colorScheme.copyWith(
      primary: Color(primary),
      onPrimary: Color(onPrimary),
      primaryContainer: Color(primaryContainer),
      onPrimaryContainer: Color(onPrimaryContainer),
      primaryFixed: Color(primaryFixed),
      primaryFixedDim: Color(primaryFixedDim),
      onPrimaryFixed: Color(onPrimaryFixed),
      onPrimaryFixedVariant: Color(onPrimaryFixedVariant),
      secondary: Color(secondary),
      onSecondary: Color(onSecondary),
      secondaryContainer: Color(secondaryContainer),
      onSecondaryContainer: Color(onSecondaryContainer),
      secondaryFixed: Color(secondaryFixed),
      secondaryFixedDim: Color(secondaryFixedDim),
      onSecondaryFixed: Color(onSecondaryFixed),
      onSecondaryFixedVariant: Color(onSecondaryFixedVariant),
      tertiary: Color(tertiary),
      onTertiary: Color(onTertiary),
      tertiaryContainer: Color(tertiaryContainer),
      onTertiaryContainer: Color(onTertiaryContainer),
      tertiaryFixed: Color(tertiaryFixed),
      tertiaryFixedDim: Color(tertiaryFixedDim),
      onTertiaryFixed: Color(onTertiaryFixed),
      onTertiaryFixedVariant: Color(onTertiaryFixedVariant),
      error: Color(error),
      onError: Color(onError),
      errorContainer: Color(errorContainer),
      onErrorContainer: Color(onErrorContainer),
      surface: Color(surface),
      onSurface: Color(onSurface),
      surfaceDim: Color(surfaceDim),
      surfaceBright: Color(surfaceBright),
      surfaceContainerLowest: Color(surfaceContainerLowest),
      surfaceContainerLow: Color(surfaceContainerLow),
      surfaceContainer: Color(surfaceContainer),
      surfaceContainerHigh: Color(surfaceContainerHigh),
      surfaceContainerHighest: Color(surfaceContainerHighest),
      onSurfaceVariant: Color(onSurfaceVariant),
      outline: Color(outline),
      outlineVariant: Color(outlineVariant),
      shadow: Color(shadow),
      scrim: Color(scrim),
      inverseSurface: Color(inverseSurface),
      onInverseSurface: Color(inverseOnSurface),
      inversePrimary: Color(inversePrimary),
      surfaceTint: Color(surfaceTint),
    );
  }
}
