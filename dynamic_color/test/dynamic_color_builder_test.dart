import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color/test_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('DynamicColorBuilder', (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors(sampleOfCorePalette);

    const containerKey = Key('myContainer');

    await tester.pumpWidget(
      DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return Container(
            key: containerKey,
            color: lightDynamic?.primary ?? const Color(0x00000123),
          );
        },
      ),
    );

    await tester.pumpAndSettle();

    expect(
      (tester.firstWidget(find.byKey(containerKey)) as Container).color,
      const Color(0xff4355b9),
    );
  });
}
