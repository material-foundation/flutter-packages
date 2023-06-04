import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// Sample [CorePalette]s to be used to mock dynamic color in tests & development.
class SampleCorePalettes {
  static CorePalette green = CorePalette.of(0xFF575D54);
  static CorePalette orange = CorePalette.of(0xFF5A545D);
}

/// Sample [ColorScheme]s to be used in tests & development.
///
/// Correspond to the [CorePalette]s in [SampleCorePalettes].
class SampleColorSchemes {
  static ColorScheme green(Brightness brightness) =>
      SampleCorePalettes.green.toColorScheme(
        brightness: brightness,
      );
  static ColorScheme orange(Brightness brightness) =>
      SampleCorePalettes.orange.toColorScheme(
        brightness: brightness,
      );
}
