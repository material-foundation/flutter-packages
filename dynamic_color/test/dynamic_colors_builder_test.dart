import 'package:dynamic_colors/dynamic_colors_builder.dart';
import 'package:dynamic_colors/tonal_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('DynamicColorsBuilder', (WidgetTester tester) async {
    TonalPalette sampleColors = generateTonalPalette((i) => 12345);
    DynamicColorsTestingUtils.setMockDynamicColors(sampleColors);

    const containerKey = Key('myContainer');

    await tester.pumpWidget(
      DynamicColorsBuilder(
        builder: (TonalPalette? dynamicColors) {
          return Container(
            key: containerKey,
            color: dynamicColors?.primary.shade10,
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
