# adaptive_breakpoints

The `adaptive_breakpoints` package for Flutter allows you to use the adaptive [breakpoints entries](https://material.io/design/layout/responsive-layout-grid.html#breakpoints) from the [Material Design System](https://material.io/).

## Getting Started

This package provides the material breakpoint entries for adaptive/responsive development in Flutter.

Firs, add the `adaptive_breakpoints` package to your pubspec dependencies.

To import `adaptive_breakpoints`:

```dart
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart
```

Here is an example of how to implement the Adaptive Breakpoint entries in Flutter Development.

```dart
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

```
