import 'dart:typed_data';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// Generates a [CorePalette] based on some generator function which takes an index.
@Deprecated('Use [generateTonalPalettes] instead.')
CorePalette generateCorePalette(int Function(int index) generator) =>
    CorePalette.fromList(
      List<int>.generate(CorePalette.size * TonalPalette.commonSize, generator),
    );

/// Generates [TonalPalette]s based on some generator function which takes an
/// index.
List<TonalPalette> generateTonalPalettes(int Function(int index) generator) => [
      for (int i = 0; i < 6; i++)
        TonalPalette.fromList(List<int>.generate(TonalPalette.commonSize,
            (index) => generator(i * TonalPalette.commonSize + index)))
    ];

/// Static methods used for testing apps with dynamic color.
class DynamicColorTestingUtils {
  /// Initializes the dynamic color plugin with mock values for testing.
  @visibleForTesting
  static void setMockDynamicColors({
    // ignore: deprecated_member_use
    CorePalette? corePalette,
    List<TonalPalette>? tonalPalettes,
    Color? accentColor,
  }) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(DynamicColorPlugin.channel, (
      MethodCall methodCall,
    ) async {
      switch (methodCall.method) {
        case DynamicColorPlugin.methodName:
          return corePalette != null
              // ignore: deprecated_member_use
              ? Int64List.fromList(corePalette.asList())
              : null;
        case DynamicColorPlugin.tonalPalettesMethodName:
          return tonalPalettes != null
              ? Int64List.fromList(tonalPalettes.map((e) => e.asList).fold(
                  <int>[],
                  (previousValue, element) => previousValue..addAll(element)))
              : null;
        case DynamicColorPlugin.accentColorMethodName:
          return accentColor?.toARGB32();
        default:
          return null;
      }
    });
    addTearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        DynamicColorPlugin.channel,
        (MethodCall methodCall) => null,
      );
    });
  }
}
