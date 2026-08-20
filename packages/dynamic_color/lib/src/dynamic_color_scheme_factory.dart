import 'package:dynamic_color/src/dynamicscheme_to_colorscheme.dart';
import 'package:dynamic_color/src/variant_to_dynamicschemevariant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// Generates [ColorScheme]s using the platform-provided dynamic colors as seeds
/// for the schemes.
///
/// See also:
///  * [ColorPaletteSchemeFactory] used when the platform sends a color palette
///    as seed for theming on Android.
///  * [AccentColorSchemeFactory] used when the platform sends an accent color
///    as seed for theming on other platforms.
abstract class DynamicSchemeFactory {
  const DynamicSchemeFactory();

  /// Generates a [ColorScheme] depending on the requested [brightness] and
  /// [contrastLevel].
  ///
  /// The [contrastLevel] is a floating value between -1 and 1, with 0 being the
  /// default contrast level (the same as in Material specification documents),
  /// 0.5 being the medium contrast level and 1 being the highest contrast
  /// level.
  ///
  /// See also:
  ///  * [Material specification](https://m3.material.io/styles/color/system/how-the-system-works#0207ef40-7f0d-4da8-9280-f062aa6b3e04).
  ColorScheme generate(
      {required Brightness brightness, double contrastLevel = 0.0});

  ColorScheme get light => generate(brightness: Brightness.light);
  ColorScheme get dark => generate(brightness: Brightness.dark);

  ColorScheme get lightMediumContrast =>
      generate(brightness: Brightness.light, contrastLevel: .5);
  ColorScheme get darkMediumContrast =>
      generate(brightness: Brightness.dark, contrastLevel: .5);

  ColorScheme get lightHighContrast =>
      generate(brightness: Brightness.light, contrastLevel: 1.0);
  ColorScheme get darkHighContrast =>
      generate(brightness: Brightness.dark, contrastLevel: 1.0);
}

/// Generates [ColorScheme]s directly from existing [tonalPalettes] using a
/// [variant].
class ColorPaletteSchemeFactory extends DynamicSchemeFactory {
  const ColorPaletteSchemeFactory(
      {required this.tonalPalettes,
      this.variant = DynamicSchemeVariant.tonalSpot});

  final List<TonalPalette> tonalPalettes;
  final DynamicSchemeVariant variant;

  @override
  ColorScheme generate(
      {required Brightness brightness, double contrastLevel = 0.0}) {
    final scheme = DynamicScheme(
        // This is only used with the `fidelity` variant.
        sourceColorHct: tonalPalettes.first.keyColor,
        variant: variant.toVariant(),
        isDark: brightness == Brightness.dark,
        contrastLevel: contrastLevel,
        primaryPalette: tonalPalettes[0],
        secondaryPalette: tonalPalettes[1],
        tertiaryPalette: tonalPalettes[2],
        neutralPalette: tonalPalettes[3],
        neutralVariantPalette: tonalPalettes[4],
        errorPalette: tonalPalettes.length >= 6 ? tonalPalettes[5] : null);

    return scheme.toColorScheme();
  }
}

typedef _SchemeConstructor = DynamicScheme Function(
    {required Hct sourceColorHct,
    required bool isDark,
    required double contrastLevel});

/// Generates [ColorScheme]s using an accent [color] applied to a [variant] used
/// for theming.
class AccentColorSchemeFactory extends DynamicSchemeFactory {
  const AccentColorSchemeFactory(
      {required this.color, this.variant = DynamicSchemeVariant.tonalSpot});

  final Color color;
  final DynamicSchemeVariant variant;

  /// We need this since [scheme_from_variant.dart](https://github.com/material-foundation/material-color-utilities/blob/main/dart/test/utils/scheme_from_variant.dart)
  /// from MCU is not public yet.
  static final Map<DynamicSchemeVariant, _SchemeConstructor> _constructors = {
    DynamicSchemeVariant.monochrome: SchemeMonochrome.new,
    DynamicSchemeVariant.neutral: SchemeNeutral.new,
    DynamicSchemeVariant.tonalSpot: SchemeTonalSpot.new,
    DynamicSchemeVariant.vibrant: SchemeVibrant.new,
    DynamicSchemeVariant.expressive: SchemeExpressive.new,
    DynamicSchemeVariant.content: SchemeContent.new,
    DynamicSchemeVariant.fidelity: SchemeFidelity.new,
    DynamicSchemeVariant.rainbow: SchemeRainbow.new,
    DynamicSchemeVariant.fruitSalad: SchemeFruitSalad.new,
  };

  @override
  ColorScheme generate(
      {required Brightness brightness, double contrastLevel = 0.0}) {
    var constructor = _constructors[variant];
    assert(constructor != null, 'Unknown constructor for variant $variant.');

    if (constructor == null && kDebugMode) {
      debugPrint(
          'dynamic_color: Could not create a color scheme with color variant '
          '$variant. Defaulting to [DynamicSchemeVariant.tonalSpot]. Please '
          'update the package or open an issue.');
    }

    // In case a new variant is added which we haven't added the constructor
    // for, we default to [Variant.tonalSpot].
    constructor ??= SchemeTonalSpot.new;

    return constructor(
            contrastLevel: contrastLevel,
            isDark: brightness == Brightness.dark,
            sourceColorHct: Hct.fromInt(color.toARGB32()))
        .toColorScheme();
  }
}
