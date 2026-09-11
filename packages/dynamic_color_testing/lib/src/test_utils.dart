import 'dart:typed_data';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// Generates a [CorePalette] based on some generator function which takes an index.
CorePalette generateCorePalette(int Function(int index) generator) =>
    CorePalette.fromList(
      List<int>.generate(CorePalette.size * TonalPalette.commonSize, generator),
    );

/// Static methods used for testing apps with dynamic color.
class DynamicColorTestingUtils {
  /// Initializes the dynamic color plugin with mock values for testing.
  @visibleForTesting
  static void setMockDynamicColors({
    CorePalette? corePalette,
    Color? accentColor,
  }) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(DynamicColorPlugin.channel, (
      MethodCall methodCall,
    ) async {
      if (methodCall.method == DynamicColorPlugin.methodName) {
        return corePalette != null
            ? Int64List.fromList(corePalette.asList())
            : null;
      } else if (methodCall.method ==
          DynamicColorPlugin.accentColorMethodName) {
        return accentColor?.toARGB32();
      } else {
        return null;
      }
    });

    if (accentColor != null) {
      AccentColorMockStreamHandler().send(accentColor);
    }

    addTearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        DynamicColorPlugin.channel,
        (MethodCall methodCall) => null,
      );
    });
  }

  static void mockAccentColorStream() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockStreamHandler(DynamicColorPlugin.accentColorChannel,
            AccentColorMockStreamHandler());

    addTearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockStreamHandler(
        DynamicColorPlugin.accentColorChannel,
        null,
      );
    });
  }
}

class AccentColorMockStreamHandler implements MockStreamHandler {
  static final _instance = AccentColorMockStreamHandler();

  MockStreamHandlerEventSink? _events;

  factory AccentColorMockStreamHandler() => _instance;

  @override
  void onCancel(Object? arguments) {
    // do nothing
  }

  @override
  void onListen(Object? arguments, MockStreamHandlerEventSink events) {
    _events = events;
  }

  void send(Object event) => _events?.success(event);
}
