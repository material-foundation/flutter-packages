import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color/test_utils.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('DynamicColorBuilder', (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors(sampleOfCorePalette);

    const containerKey = Key('myContainer');

    await tester.pumpWidget(
      DynamicColorBuilder(
        builder: (CorePalette? corePalette) {
          return Container(
            key: containerKey,
            color: Color(corePalette?.primary.get(100) ?? 123),
          );
        },
      ),
    );

    await tester.pumpAndSettle();

    expect(
      (tester.firstWidget(find.byKey(containerKey)) as Container).color,
      Colors.white,
    );
  });
}
