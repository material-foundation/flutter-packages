import 'package:dynamic_color/src/dynamic_color_plugin.dart';
import 'package:dynamic_color/src/core_palette.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('getCorePalette', () async {
    CorePalette sampleColors = generateCorePalette((i) => i);
    DynamicColorsTestingUtils.setMockDynamicColors(sampleColors);

    final colors = await DynamicColorPlugin.getCorePalette();
    expect(colors, equals(sampleColors));
  });

  test('getCorePalette returns null', () async {
    DynamicColorsTestingUtils.setMockDynamicColors(null);

    final colors = await DynamicColorPlugin.getCorePalette();
    expect(colors, equals(null));
  });
}
