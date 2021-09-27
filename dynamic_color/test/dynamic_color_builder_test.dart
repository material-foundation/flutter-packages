import 'package:dynamic_color/src/dynamic_color_builder.dart';
import 'package:dynamic_color/src/core_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('DynamicColorBuilder', (WidgetTester tester) async {
    CorePalette samplePalette = generateCorePalette((i) => 12345);
    DynamicColorsTestingUtils.setMockDynamicColors(samplePalette);

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
