import 'dart:typed_data';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// Generates a [CorePalette] based on some generator function which takes an index.
CorePalette generateCorePalette(int Function(int index) generator) =>
    CorePalette.fromList(
      List<int>.generate(CorePalette.size * TonalPalette.commonSize, generator),
    );

/// Static methods used for testing apps with dynamic [CorePalette]s.
class DynamicColorTestingUtils {
  /// Initializes the dynamic color plugin with mock values for testing.
  @visibleForTesting
  static void setMockDynamicColors({
    CorePalette? colorPalette,
    Color? accentColor,
  }) {
    DynamicColorPlugin.channel
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == DynamicColorPlugin.methodName) {
        return colorPalette != null
            ? Int64List.fromList(colorPalette.asList())
            : null;
      } else if (methodCall.method ==
          DynamicColorPlugin.accentColorMethodName) {
        return accentColor?.value;
      }
    });
    addTearDown(() {
      DynamicColorPlugin.channel.setMockMethodCallHandler(null);
    });
  }
}
