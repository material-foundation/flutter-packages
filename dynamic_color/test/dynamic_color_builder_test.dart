import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color/test_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('DynamicColorBuilder', (WidgetTester tester) async {
    CorePalette samplePalette = generateCorePalette((i) => 12345);
    DynamicColorTestingUtils.setMockDynamicColors(samplePalette);

    const containerKey = Key('myContainer');

    await tester.pumpWidget(
      DynamicColorBuilder(
        builder: (CorePalette? corePalette) {
          return Container(
            key: containerKey,
            color: corePalette?.primary.tone99,
          );
        },
      ),
    );

    await tester.pumpAndSettle();

    expect(
      (tester.firstWidget(find.byKey(containerKey)) as Container).color,
      const Color(0x00003039), // 12345 in hex
    );
  });
}
