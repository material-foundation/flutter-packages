// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';


import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';




class AdaptiveContainer extends StatelessWidget {
  final AdaptiveWindow windowLimit;
  final Widget child;

  const AdaptiveContainer({
    @required this.windowLimit,
    this.child,
  })  : assert(windowLimit != null);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        BreakpointSystemEntry entry =
            getBreakpointEntry(MediaQuery.of(context).size);
        if (entry.window == windowLimit) {
          return Container(
            constraints: BoxConstraints(
              maxWidth: entry.window.longestWidth,
              minWidth: entry.window.shortestWidth,
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
    await tester.pumpWidget(
      MaterialApp(
        home: AdaptiveContainer(
          windowLimit: AdaptiveWindow.s,
        ),
      ),
    );

    /// By default the constraints of the test is BoxConstraints(w=800.0, h=600.0)
    /// You can get this by printing the constraints within the LayoutBuilder.
    /// This means that by default the Size of the screen in Flutter testing is small.
    var box = tester.widget(find.byType(Container));
    expect(find.byType(Container), findsOneWidget);
    expect((box as Container).color, Colors.pink);

    await tester.pumpWidget(
      MaterialApp(
        home: AdaptiveContainer(
          windowLimit: AdaptiveWindow.m,
        ),
      ),
    );

    box = tester.widget(find.byType(Container));
    expect(find.byType(Container), findsOneWidget);
    expect((box as Container).color, Colors.green);
  });
}
