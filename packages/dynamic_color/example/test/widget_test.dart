// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color/samples.dart';
import 'package:dynamic_color/test_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const key = Key('container');

  // Reset for every test
  setUp(() => DynamicColorTestingUtils.setMockDynamicColors());

  testWidgets('Verify dynamic core palette is used ',
      (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors(
      corePalette: SampleCorePalettes.green,
    );

    await tester.pumpWidget(
      DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) => Container(
          key: key,
          color: lightDynamic?.primary ?? Colors.red,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final container = tester.widget<Container>(find.byKey(key));
    expect(container.color, const Color(0xff286c2a));
  });
  testWidgets('Verify dynamic accent color is used ',
      (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors(
      accentColor: Colors.green,
    );

    await tester.pumpWidget(
      DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) => Container(
          key: key,
          color: lightDynamic?.primary ?? Colors.red,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final container = tester.widget<Container>(find.byKey(key));
    expect(container.color, const Color(0xff006e1c));
  });

  testWidgets('Verify fallback color is used', (WidgetTester tester) async {
    await tester.pumpWidget(
      DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return Container(
            key: key,
            color: lightDynamic?.primary ?? Colors.red,
          );
        },
      ),
    );
    await tester.pumpAndSettle();

    final container = tester.widget<Container>(find.byKey(key));
    expect(container.color, Colors.red);
  });
}
