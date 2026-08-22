import 'dart:async';

import 'package:flutter/services.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// Plugin for obtaining dynamic colors defined by the Android OS.
class DynamicColorPlugin {
  /// Optional method channel so that it returns null on non-Android platforms.
  static const channel = OptionalMethodChannel(
    'io.material.plugins/dynamic_color',
  );

  /// A method name that the Android plugin listens for.
  static const methodName = 'getCorePalette';

  /// A method name that the Android plugin listens for.
  static const tonalPalettesMethodName = 'getTonalPalettes';

  /// A method name that other plugins than Android listen for.
  static const accentColorMethodName = 'getAccentColor';

  /// Returns the Android OS' dynamic colors asynchronously in a [CorePalette].
  ///
  /// Completes with null on pre-Android S and non-Android platforms.
  ///
  /// See also:
  ///
  ///  * [getCorePalette() example](https://github.com/material-foundation/flutter-packages/tree/main/packages/dynamic_color/example/lib/get_core_palette_example.dart)
  ///  * [DynamicColorBuilder] a convenience stateful builder widget that
  ///  provides the dynamic colors
  @Deprecated('Use [DynamicColorPlugin.getTonalPalettes] instead.')
  static Future<CorePalette?> getCorePalette() async {
    final result = await channel.invokeMethod(methodName);
    return result == null ? null : CorePalette.fromList(result.toList());
  }

  /// Returns all of Android OS' dynamic color palettes asynchronously as a
  /// plain list of [TonalPalette]s.
  ///
  /// Completes with null on pre-Android S and non-Android platforms. The
  /// palettes are presented in this order:
  /// - Primary
  /// - Secondary
  /// - Tertiary
  /// - Neutral
  /// - Neutral variant
  /// - Error (only on Android 15+)
  ///
  /// See also:
  ///  * [getTonalPalettes() example](https://github.com/material-foundation/flutter-packages/tree/main/packages/dynamic_color/example/lib/get_tonal_palettes_example.dart)
  ///  * [DynamicColorBuilder] a convenience stateful builder widget that
  ///  provides the dynamic colors
  static Future<List<TonalPalette>?> getTonalPalettes() async {
    final result =
        (await channel.invokeListMethod(tonalPalettesMethodName))?.cast<int>();
    if (result == null) return null;
    assert(result.length % TonalPalette.commonSize == 0,
        'Received a list of colors that can\'t be formatted into tonal palettes');

    // We split the entire color list into their respective tonal palettes.
    final palettes = <TonalPalette>[];
    for (int offset = 0;
        offset + TonalPalette.commonSize <= result.length;
        offset += TonalPalette.commonSize) {
      palettes.add(TonalPalette.fromList(
          result.sublist(offset, offset + TonalPalette.commonSize)));
    }

    return palettes;
  }

  /// Returns the OS' accent color asynchronously as a [Color].
  ///
  /// Supported on macOS starting with 10.14 (Mojave), on Windows starting with
  /// Vista, and on GTK-based Linux desktops.
  ///
  /// See also:
  ///
  /// * [Apple's introduction to macOS accent color](https://developer.apple.com/design/human-interface-guidelines/macos/overview/whats-new-in-macos/#app-accent-colors)
  /// * [macOS's NSColor.controlAccentColor documentation](https://developer.apple.com/documentation/appkit/nscolor/3000782-controlaccentcolor)
  /// * [Windows' accent color](https://docs.microsoft.com/en-us/windows/apps/design/style/color#accent-color)
  /// * [Windows Aero](https://web.archive.org/web/20080812195923/http://www.microsoft.com/windows/windows-vista/features/aero.aspx?tabid=2&catid=4)
  /// * [Change colors in Windows](https://support.microsoft.com/en-us/windows/change-colors-in-windows-d26ef4d6-819a-581c-1581-493cfcc005fe)
  static Future<Color?> getAccentColor() async {
    final result = await channel.invokeMethod(accentColorMethodName);
    return result == null ? null : Color(result);
  }
}
