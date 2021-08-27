import 'dart:async';

import 'package:flutter/services.dart';

import 'tonal_palette.dart';

/// This plugin allows apps to use the dynamic colors defined by the Android OS.
class DynamicColorsPlugin {
  /// Method channel for requesting the dynamic color tonal palette from the
  /// Android OS.
  static const channel = MethodChannel('io.material.plugins/dynamic_colors');

  /// The method name that the java plugin will listen for and return the
  /// dynamic color tonal palette when called.
  static const methodName = 'getDynamicColors';

  /// Fetches the dynamic tonal palette from the Android OS.
  ///
  /// Returns null if called on a device where tonal palettes are unavailable.
  static Future<TonalPalette?> getDynamicColors() async {
    final result = await channel.invokeMethod(methodName);
    return result == null ? null : TonalPalette.fromList(result.toList());
  }
}
