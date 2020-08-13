// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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
            child: child,
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
