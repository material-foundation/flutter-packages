import 'dart:async';

import 'package:flutter/services.dart';

import 'dynamic_colors_builder.dart';
import 'tonal_palette.dart';

/// Plugin for obtaining dynamic colors defined by the Android OS.
class DynamicColorsPlugin {
  /// Optional method channel so that it returns null on non-Android platforms.
  static const channel = OptionalMethodChannel(
    'io.material.plugins/dynamic_colors',
  );

  /// The method name that the Kotlin plugin listens for.
  static const methodName = 'getDynamicColors';

  /// Returns the Android OS' dynamic colors asynchronously as a [TonalPalette].
  ///
  /// Completes with null on pre-Android S and non-Android platforms.
  ///
  /// See also:
  ///
  ///  * [getDynamicColors() example](https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/get_dynamic_colors_example.dart)
  ///  * [DynamicColorsBuilder] a convenience stateful builder widget that
  ///  provides the dynamic colors
  static Future<TonalPalette?> getDynamicColors() async {
    final result = await channel.invokeMethod(methodName);
    return result == null ? null : TonalPalette.fromList(result.toList());
  }
}
