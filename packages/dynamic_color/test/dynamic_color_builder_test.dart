import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color_testing/dynamic_color_testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    DynamicColorTestingUtils.setMockDynamicColors(
      corePalette: SampleCorePalettes.green,
      tonalPalettes: SampleTonalPalettes.green,
      accentColor: Colors.amber,
    );
  });

  const containerKey = Key('myContainer');

  Widget dynamicColorBuilder() => DynamicColorBuilder(customBuilder: (schemes) {
        return Container(
          key: containerKey,
          color: schemes?.light.primary ?? const Color(0x00000123),
        );
      });

  testWidgets('DynamicColorBuilder is correct on Android',
      (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors(
        corePalette: SampleCorePalettes.green,
        tonalPalettes: SampleTonalPalettes.green);

    await tester.pumpWidget(dynamicColorBuilder());
    await tester.pumpAndSettle();

    final container = tester.firstWidget(find.byKey(containerKey)) as Container;
    expect(container.color, const Color(0xff3c6939));
  });

  testWidgets('DynamicColorBuilder is correct on desktop',
      (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors(
      accentColor: Colors.amber,
    );
    await tester.pumpWidget(dynamicColorBuilder());
    await tester.pumpAndSettle();

    final container = tester.firstWidget(find.byKey(containerKey)) as Container;
    expect(container.color, const Color(0xff775a0b));
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
