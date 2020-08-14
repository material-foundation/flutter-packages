import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';

void main() {
  Color adaptiveContainerColor = Colors.pink;
  testWidgets('Adaptive Breakpoint test', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(800, 600);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: AdaptiveContainer(
          color: adaptiveContainerColor,
          adaptiveConstraints: AdaptiveConstraints(s: true),
        ),
      ),
    );

    var box = tester.widget(find.byType(Container));
    expect(find.byType(Container), findsOneWidget);
    expect((box as Container).color, adaptiveContainerColor);

    tester.binding.window.physicalSizeTestValue = const Size(2000, 600);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: AdaptiveContainer(
          color: adaptiveContainerColor,
          adaptiveConstraints: AdaptiveConstraints(s: true),
        ),
      ),
    );

    expect(find.byType(Container), findsNothing);
  });

  testWidgets('Adaptive Breakpoint test on the edge of adaptive window',
      (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(399.5, 600);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: AdaptiveContainer(
          color: adaptiveContainerColor,
          adaptiveConstraints: AdaptiveConstraints(xs: true),
        ),
      ),
    );

    var box = tester.widget(find.byType(Container));
    expect(find.byType(Container), findsOneWidget);
    expect((box as Container).color, adaptiveContainerColor);

    tester.binding.window.physicalSizeTestValue = const Size(1919.99999, 600);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: AdaptiveContainer(
          color: adaptiveContainerColor,
          adaptiveConstraints: AdaptiveConstraints(l: true),
        ),
      ),
    );

    box = tester.widget(find.byType(Container));
    expect(find.byType(Container), findsOneWidget);
    expect((box as Container).color, adaptiveContainerColor);
  });
}
