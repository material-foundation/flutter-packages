import 'dart:async';

import 'package:dynamic_color/src/color_schemes.dart';
import 'package:flutter/services.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// Plugin for obtaining dynamic colors defined by the Android OS.
class DynamicColorPlugin {
  /// Optional method channel so that it returns null on non-Android platforms.
  static const channel = OptionalMethodChannel(
    'io.material.plugins/dynamic_color',
  );

  /// A method name that the Kotlin plugin listens for.
  static const corePaletteMethodName = 'getCorePalette';

  static const colorSchemesMethodName = 'getColorSchemes';

  /// A method name that the macOS plugin listens for.
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
  static Future<CorePalette?> getCorePalette() async {
    final result = await channel.invokeMethod(corePaletteMethodName);
    return result == null ? null : CorePalette.fromList(result.toList());
  }

  /// Returns the Android OS' dynamic colors asynchronously as a [ColorSchemes].
  ///
  /// Completes with null on pre-Android U and non-Android platforms.
  ///
  /// See also:
  ///
  ///  * [DynamicColorBuilder] a convenience stateful builder widget that
  ///  provides the dynamic colors
  static Future<ColorSchemes?> getColorSchemes() async {
    final result = await channel.invokeMethod(colorSchemesMethodName);
    return result == null ? null : ColorSchemes.fromList(result.toList());
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
