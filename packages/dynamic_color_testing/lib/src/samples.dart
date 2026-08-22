import 'package:dynamic_color/dynamic_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// Sample [CorePalette]s to be used to mock dynamic color in tests & development.
@Deprecated('See [SampleTonalPalettes].')
class SampleCorePalettes {
  static CorePalette green = CorePalette.of(0xFF575D54);
  static CorePalette orange = CorePalette.of(0xFF5A545D);
}

/// Sample [DynamicSchemeFactory] examples to be used to mock dynamic color in
/// tests & development.
class SampleDynamicSchemes {
  static DynamicSchemeFactory _generate(int color) {
    return AccentColorSchemeFactory(color: Color(color));
  }

  static DynamicSchemeFactory green = _generate(0xFF575D54);
  static DynamicSchemeFactory orange = _generate(0xFF5A545D);
}

class SampleTonalPalettes {
  static List<TonalPalette> _extract(int color) {
    // Parameters such as isDark and contrastLevel do not matter when generating
    // palettes.
    final scheme = SchemeTonalSpot(
        sourceColorHct: Hct.fromInt(0xFF575D54),
        isDark: false,
        contrastLevel: 0);
    return [
      scheme.primaryPalette,
      scheme.secondaryPalette,
      scheme.tertiaryPalette,
      scheme.neutralPalette,
      scheme.neutralVariantPalette,
      scheme.errorPalette,
    ];
  }

  static List<TonalPalette> green = _extract(0xFF575D54);
  static List<TonalPalette> orange = _extract(0xFF5A545D);
}

/// Sample [ColorScheme]s to be used in tests & development.
///
/// Correspond to each [DynamicSchemeFactory] in
/// [SampleDynamicSchemes].
class SampleColorSchemes {
  static ColorScheme green(Brightness brightness,
          {double contrastLevel = 0.0}) =>
      SampleDynamicSchemes.green
          .generate(brightness: brightness, contrastLevel: contrastLevel);
  static ColorScheme orange(Brightness brightness,
          {double contrastLevel = 0.0}) =>
      SampleDynamicSchemes.orange
          .generate(brightness: brightness, contrastLevel: contrastLevel);
}
