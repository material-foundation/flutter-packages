import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';

class AdaptiveContainer extends StatelessWidget {
  final AdaptiveWindowType windowLimit;
  final Widget child;

  const AdaptiveContainer({
    @required this.windowLimit,
    this.child,
  }) : assert(windowLimit != null);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        BreakpointSystemEntry entry = getBreakpointEntry(context);
        if (entry.adaptiveWindowType == windowLimit) {
          return Container(
            constraints: BoxConstraints(
              minWidth: entry.adaptiveWindowType.widthRangeValues.start,
              maxWidth: entry.adaptiveWindowType.widthRangeValues.end,
            ),
            width: MediaQuery.of(context).size.width - (entry.margins * 2),
            margin: EdgeInsets.symmetric(horizontal: entry.margins),
            color: Colors.pink,
            child: child,
          );
        } else {
          return Container(
            color: Colors.green,
          );
        }
      },
    );
  }
}

void main() {
  testWidgets('Adaptive Breakpoint test', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(800, 600);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: AdaptiveContainer(
          windowLimit: AdaptiveWindowType.s,
        ),
      ),
    );

    var box = tester.widget(find.byType(Container));
    expect(find.byType(Container), findsOneWidget);
    expect((box as Container).color, Colors.pink);

    tester.binding.window.physicalSizeTestValue = const Size(2000, 600);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: AdaptiveContainer(
          windowLimit: AdaptiveWindowType.s,
        ),
      ),
    );

    box = tester.widget(find.byType(Container));
    expect(find.byType(Container), findsOneWidget);
    expect((box as Container).color, Colors.green);
  });

  testWidgets('Adaptive Breakpoint test on the edge of adaptive window', (WidgetTester tester) async {
    tester.binding.window.physicalSizeTestValue = const Size(399.5, 600);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: AdaptiveContainer(
          windowLimit: AdaptiveWindowType.xs,
        ),
      ),
    );

    var box = tester.widget(find.byType(Container));
    expect(find.byType(Container), findsOneWidget);
    expect((box as Container).color, Colors.pink);

    tester.binding.window.physicalSizeTestValue = const Size(1919.99999, 600);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: AdaptiveContainer(
          windowLimit: AdaptiveWindowType.l,
        ),
      ),
    );

    box = tester.widget(find.byType(Container));
    expect(find.byType(Container), findsOneWidget);
    expect((box as Container).color, Colors.pink);
  });
}
