import 'package:flutter/material.dart';
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AdaptiveContainer(
          windowLimit: AdaptiveWindow.m,
          child: SizedBox(
            height: 300,
            child: Text('Adaptive Container'),
          ),
        ),
      ),
    );
  }
}

class AdaptiveContainer extends StatelessWidget {
  final AdaptiveWindow windowLimit;
  final Widget child;

  const AdaptiveContainer({
    @required this.windowLimit,
    @required this.child,
  })  : assert(windowLimit != null),
        assert(child != null);

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
          return SizedBox();
        }
      },
    );
  }
}
