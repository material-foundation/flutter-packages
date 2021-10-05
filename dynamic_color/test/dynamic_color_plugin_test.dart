import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dynamic_color/test_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('getCorePalette', () async {
    CorePalette sampleColors = generateCorePalette((i) => i);
    DynamicColorTestingUtils.setMockDynamicColors(sampleColors);

    final colors = await DynamicColorPlugin.getCorePalette();
    expect(colors, equals(sampleColors));
  });

  test('getCorePalette returns null', () async {
    DynamicColorTestingUtils.setMockDynamicColors(null);

    final colors = await DynamicColorPlugin.getCorePalette();
    expect(colors, equals(null));
  });
}
