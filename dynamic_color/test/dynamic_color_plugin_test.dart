import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color/test_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('getCorePalette', () async {
    final sampleFromListCorePalette = generateCorePalette((i) => i);

    DynamicColorTestingUtils.setMockDynamicColors(sampleFromListCorePalette);
    final colors = await DynamicColorPlugin.getCorePalette();
    expect(colors, sampleFromListCorePalette);
  });

  test('getCorePalette returns null', () async {
    DynamicColorTestingUtils.setMockDynamicColors(null);

    final colors = await DynamicColorPlugin.getCorePalette();
    expect(colors, equals(null));
  });
}
