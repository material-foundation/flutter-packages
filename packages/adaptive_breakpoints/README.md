# adaptive_breakpoints

The `adaptive_breakpoints` package for Flutter allows you to use the adaptive [breakpoints entries](https://material.io/design/layout/responsive-layout-grid.html#breakpoints) from the [Material Design System](https://material.io/).

## Getting Started

This package provides the material breakpoint entries for adaptive/responsive development in Flutter.

First, add the `adaptive_breakpoints` package to your pubspec dependencies.

To import `adaptive_breakpoints`:

```dart
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart
```

Here is an example of how to implement the Adaptive Breakpoint entries in Flutter Development.

In this example, we created an adaptive container which will 'activate' anytime that window screen is
on same as the window limit. If they are the same the child will show otherwise it will be an empty container.

Try it yourself with this [dartpad](https://dartpad.dev/be6d3b390933220daf14bd4afd7e438c)

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
        body: Column(
          children: [
            AdaptiveContainer(
              windowLimit: AdaptiveWindowType.xs,
              child: Text('This is an extra small window'),
            ),
            AdaptiveContainer(
              windowLimit: AdaptiveWindowType.s,
              child: Text('This is a small window'),
            ),
            AdaptiveContainer(
              windowLimit: AdaptiveWindowType.m,
              child: Text('This is a medium window'),
            ),
            AdaptiveContainer(
              windowLimit: AdaptiveWindowType.l,
              child: Text('This is a large window'),
            ),
            AdaptiveContainer(
              windowLimit: AdaptiveWindowType.xl,
              child: Text('This is an extra large window'),
            ),
          ],
        ),
      ),
    );
  }
}

/// This example application demonstrates how to use
/// [`adaptive_breakpoints`](https://pub.dev/packages/adaptive_breakpoints)
/// within a simple Flutter app.
class AdaptiveContainer extends StatelessWidget {
  final AdaptiveWindowType windowLimit;
  final Widget child;

  const AdaptiveContainer({
    @required this.windowLimit,
    this.child,
  })  : assert(windowLimit != null);

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
