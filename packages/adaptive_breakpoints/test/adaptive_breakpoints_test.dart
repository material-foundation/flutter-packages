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
        color: AdaptiveWindowType.xsmall <= AdaptiveWindowType.xlarge
            ? trueColor
            : falseColor,
      )),
    );
    var box = tester.widget<Container>(find.byType(Container));
    expect(box.color, trueColor);

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.medium <= AdaptiveWindowType.xlarge
            ? trueColor
            : falseColor,
      )),
    );

    box = tester.widget(find.byType(Container));
    expect(box.color, trueColor);

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.xlarge <= AdaptiveWindowType.xlarge
            ? trueColor
            : falseColor,
      )),
    );

    box = tester.widget(find.byType(Container));
    expect(box.color, trueColor);

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.large <= AdaptiveWindowType.small
            ? trueColor
            : falseColor,
      )),
    );

    box = tester.widget(find.byType(Container));
    expect(box.color, falseColor);
  });

  testWidgets('Adaptive Breakpoint window operators <',
      (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(399.5, 600);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.xsmall < AdaptiveWindowType.xlarge
            ? trueColor
            : falseColor,
      )),
    );
    var box = tester.widget<Container>(find.byType(Container));
    expect(box.color, trueColor);

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.medium < AdaptiveWindowType.xlarge
            ? trueColor
            : falseColor,
      )),
    );

    box = tester.widget(find.byType(Container));
    expect(box.color, trueColor);

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.xlarge < AdaptiveWindowType.xlarge
            ? trueColor
            : falseColor,
      )),
    );

    box = tester.widget(find.byType(Container));
    expect(box.color, falseColor);

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.large < AdaptiveWindowType.small
            ? trueColor
            : falseColor,
      )),
    );

    box = tester.widget(find.byType(Container));
    expect(box.color, falseColor);
  });

  testWidgets('Adaptive Breakpoint window operators >=',
      (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(399.5, 600);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.xsmall >= AdaptiveWindowType.xlarge
            ? trueColor
            : falseColor,
      )),
    );
    var box = tester.widget<Container>(find.byType(Container));
    expect(box.color, falseColor);

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.medium >= AdaptiveWindowType.xlarge
            ? trueColor
            : falseColor,
      )),
    );

    box = tester.widget(find.byType(Container));
    expect(box.color, falseColor);

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.xlarge >= AdaptiveWindowType.xlarge
            ? trueColor
            : falseColor,
      )),
    );

    box = tester.widget(find.byType(Container));
    expect(box.color, trueColor);

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.large >= AdaptiveWindowType.small
            ? trueColor
            : falseColor,
      )),
    );

    box = tester.widget(find.byType(Container));
    expect(box.color, trueColor);
  });

  testWidgets('Adaptive Breakpoint window operators >',
      (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(399.5, 600);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.xsmall > AdaptiveWindowType.xlarge
            ? trueColor
            : falseColor,
      )),
    );
    var box = tester.widget<Container>(find.byType(Container));
    expect(box.color, falseColor);

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.medium > AdaptiveWindowType.xlarge
            ? trueColor
            : falseColor,
      )),
    );

    box = tester.widget(find.byType(Container));
    expect(box.color, falseColor);

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.xlarge > AdaptiveWindowType.xlarge
            ? trueColor
            : falseColor,
      )),
    );

    box = tester.widget(find.byType(Container));
    expect(box.color, falseColor);

    await tester.pumpWidget(
      MaterialApp(
          home: Container(
        color: AdaptiveWindowType.large > AdaptiveWindowType.small
            ? trueColor
            : falseColor,
      )),
    );

    box = tester.widget(find.byType(Container));
    expect(box.color, trueColor);
  });
}
