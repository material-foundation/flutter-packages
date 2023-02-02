import 'dart:ui';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color/test_utils.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
