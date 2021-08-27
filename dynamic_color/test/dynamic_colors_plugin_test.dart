import 'package:dynamic_colors/dynamic_colors_plugin.dart';
import 'package:dynamic_colors/tonal_palette.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('getDynamicColors', () async {
    TonalPalette sampleColors = generateTonalPalette((i) => i);
    DynamicColorsTestingUtils.setMockDynamicColors(sampleColors);

    final colors = await DynamicColorsPlugin.getDynamicColors();
    expect(colors, equals(sampleColors));
  });

  test('getDynamicColors returns null', () async {
    DynamicColorsTestingUtils.setMockDynamicColors(null);

    final colors = await DynamicColorsPlugin.getDynamicColors();
    expect(colors, equals(null));
  });
}
