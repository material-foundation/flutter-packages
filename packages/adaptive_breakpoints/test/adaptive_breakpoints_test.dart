import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';

void main() {
  Color trueColor = Colors.green;
  Color falseColor = Colors.red;

  testWidgets('Adaptive Breakpoint window operators <=',
          (WidgetTester tester) async {
        tester.binding.window.physicalSizeTestValue = const Size(399.5, 600);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.xs <= AdaptiveWindowType.xl
                    ? trueColor
                    : falseColor,
              )),
        );
        var box = tester.widget(find.byType(Container));
        expect((box as Container).color, trueColor);

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.md <= AdaptiveWindowType.xl
                    ? trueColor
                    : falseColor,
              )),
        );

        box = tester.widget(find.byType(Container));
        expect((box as Container).color, trueColor);

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.xl <= AdaptiveWindowType.xl
                    ? trueColor
                    : falseColor,
              )),
        );

        box = tester.widget(find.byType(Container));
        expect((box as Container).color, trueColor);

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.lg <= AdaptiveWindowType.sm
                    ? trueColor
                    : falseColor,
              )),
        );

        box = tester.widget(find.byType(Container));
        expect((box as Container).color, falseColor);
      });

  testWidgets('Adaptive Breakpoint window operators <',
          (WidgetTester tester) async {
        tester.binding.window.physicalSizeTestValue = const Size(399.5, 600);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.xs < AdaptiveWindowType.xl
                    ? trueColor
                    : falseColor,
              )),
        );
        var box = tester.widget(find.byType(Container));
        expect((box as Container).color, trueColor);

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.md < AdaptiveWindowType.xl
                    ? trueColor
                    : falseColor,
              )),
        );

        box = tester.widget(find.byType(Container));
        expect((box as Container).color, trueColor);

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.xl < AdaptiveWindowType.xl
                    ? trueColor
                    : falseColor,
              )),
        );

        box = tester.widget(find.byType(Container));
        expect((box as Container).color, falseColor);

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.lg < AdaptiveWindowType.sm
                    ? trueColor
                    : falseColor,
              )),
        );

        box = tester.widget(find.byType(Container));
        expect((box as Container).color, falseColor);
      });

  testWidgets('Adaptive Breakpoint window operators >=',
          (WidgetTester tester) async {
        tester.binding.window.physicalSizeTestValue = const Size(399.5, 600);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.xs >= AdaptiveWindowType.xl
                    ? trueColor
                    : falseColor,
              )),
        );
        var box = tester.widget(find.byType(Container));
        expect((box as Container).color, falseColor);

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.md >= AdaptiveWindowType.xl
                    ? trueColor
                    : falseColor,
              )),
        );

        box = tester.widget(find.byType(Container));
        expect((box as Container).color, falseColor);

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.xl >= AdaptiveWindowType.xl
                    ? trueColor
                    : falseColor,
              )),
        );

        box = tester.widget(find.byType(Container));
        expect((box as Container).color, trueColor);

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.lg >= AdaptiveWindowType.sm
                    ? trueColor
                    : falseColor,
              )),
        );

        box = tester.widget(find.byType(Container));
        expect((box as Container).color, trueColor);
      });

  testWidgets('Adaptive Breakpoint window operators >',
          (WidgetTester tester) async {
        tester.binding.window.physicalSizeTestValue = const Size(399.5, 600);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.xs > AdaptiveWindowType.xl
                    ? trueColor
                    : falseColor,
              )),
        );
        var box = tester.widget(find.byType(Container));
        expect((box as Container).color, falseColor);

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.md > AdaptiveWindowType.xl
                    ? trueColor
                    : falseColor,
              )),
        );

        box = tester.widget(find.byType(Container));
        expect((box as Container).color, falseColor);

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.xl > AdaptiveWindowType.xl
                    ? trueColor
                    : falseColor,
              )),
        );

        box = tester.widget(find.byType(Container));
        expect((box as Container).color, falseColor);

        await tester.pumpWidget(
          MaterialApp(
              home: Container(
                color: AdaptiveWindowType.lg > AdaptiveWindowType.sm
                    ? trueColor
                    : falseColor,
              )),
        );

        box = tester.widget(find.byType(Container));
        expect((box as Container).color, trueColor);
      });
}
