import 'dart:typed_data';

import 'package:dynamic_color/src/dynamic_color_plugin.dart';
import 'package:dynamic_color/src/core_palette.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

/// Generates a [CorePalette] based on some generator function which takes an index.
CorePalette generateCorePalette(int Function(int index) generator) =>
    CorePalette.fromList(
      List<int>.generate(CorePalette.size * TonalPalette.size, generator),
    );

/// Static methods used for testing apps with dynamic [CorePalette]s.
class DynamicColorsTestingUtils {
  /// Initializes the dynamic color plugin with mock values for testing.
  @visibleForTesting
  static void setMockDynamicColors(CorePalette? colors) {
    DynamicColorPlugin.channel
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == DynamicColorPlugin.methodName) {
        return colors != null ? Int32List.fromList(colors.asList()) : null;
      }
    });
    addTearDown(() {
      DynamicColorPlugin.channel.setMockMethodCallHandler(null);
    });
  }
}
