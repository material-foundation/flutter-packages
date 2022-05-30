import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color/samples.dart';
import 'package:dynamic_color/test_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    DynamicColorTestingUtils.setMockDynamicColors(
      colorPalette: SampleCorePalettes.green,
      accentColor: Colors.amber,
    );
  });

  const containerKey = Key('myContainer');

  Widget dynamicColorBuilder() => DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return Container(
            key: containerKey,
            color: lightDynamic?.primary ?? const Color(0x00000123),
          );
        },
      );

  testWidgets('DynamicColorBuilder is correct on Android',
      (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors(
      colorPalette: SampleCorePalettes.green,
    );

    await tester.pumpWidget(dynamicColorBuilder());
    await tester.pumpAndSettle();

    final container = tester.firstWidget(find.byKey(containerKey)) as Container;
    expect(container.color, const Color(0xff286b2a));
  });

  testWidgets('DynamicColorBuilder is correct on macOS/Windows',
      (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors(
      accentColor: Colors.amber,
    );
    await tester.pumpWidget(dynamicColorBuilder());
    await tester.pumpAndSettle();

    final container = tester.firstWidget(find.byKey(containerKey)) as Container;
    expect(container.color, const Color(0xff795900));
  });

  testWidgets('DynamicColorBuilder is correct on other platforms',
      (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors();

    await tester.pumpWidget(dynamicColorBuilder());
    await tester.pumpAndSettle();

    final container = tester.firstWidget(find.byKey(containerKey)) as Container;
    expect(container.color, const Color(0x00000123));
  });
}
