import 'dart:ui';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color_testing/dynamic_color_testing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'accent_color_stream_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('getCorePalette', () async {
    final sampleFromListCorePalette = generateCorePalette((i) => i);

    DynamicColorTestingUtils.setMockDynamicColors(
      corePalette: sampleFromListCorePalette,
    );
    final colors = await DynamicColorPlugin.getCorePalette();
    expect(colors, sampleFromListCorePalette);
  });

  test('getCorePalette returns null', () async {
    DynamicColorTestingUtils.setMockDynamicColors(
      corePalette: null,
    );
    final colors = await DynamicColorPlugin.getCorePalette();
    expect(colors, equals(null));
  });

  test('getAccentColor', () async {
    const color = Color.fromARGB(12, 24, 123, 53);

    DynamicColorTestingUtils.setMockDynamicColors(
      accentColor: color,
    );
    final result = await DynamicColorPlugin.getAccentColor();
    expect(result, color);
  });

  test('getAccentColor returns null', () async {
    DynamicColorTestingUtils.setMockDynamicColors(accentColor: null);

    final colors = await DynamicColorPlugin.getAccentColor();
    expect(colors, equals(null));
  });

  group('onAccentColorChanged', () {
    tearDown(() => debugDefaultTargetPlatformOverride = null);

    test('emits each change on Linux', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;
      final mock = AccentColorStreamMock();

      final colors = <Color>[];
      final subscription =
          DynamicColorPlugin.onAccentColorChanged.listen(colors.add);
      await pumpEventQueue();

      mock.emit(0xFF112233);
      mock.emit(0xFF112233);
      mock.emit(0xFF445566);
      await pumpEventQueue();
      await subscription.cancel();

      expect(colors, const [Color(0xFF112233), Color(0xFF445566)]);
    });

    test('shares one native subscription between listeners', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.linux;
      final mock = AccentColorStreamMock();

      final first = DynamicColorPlugin.onAccentColorChanged.listen(null);
      final second = DynamicColorPlugin.onAccentColorChanged.listen(null);
      await pumpEventQueue();
      await first.cancel();
      await second.cancel();
      await pumpEventQueue();

      expect([mock.listenCount, mock.cancelCount], [1, 1]);
    });

    for (final platform in TargetPlatform.values.where(
      (TargetPlatform platform) => platform != TargetPlatform.linux,
    )) {
      test('is empty on ${platform.name}', () async {
        debugDefaultTargetPlatformOverride = platform;
        final mock = AccentColorStreamMock();

        expect(await DynamicColorPlugin.onAccentColorChanged.isEmpty, isTrue);
        expect(mock.listenCount, 0);
      });
    }
  });
}
