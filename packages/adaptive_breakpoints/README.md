# adaptive_breakpoints

The `adaptive_breakpoints` package for Flutter allows you to use the adaptive [breakpoints entries](https://material.io/design/layout/responsive-layout-grid.html#breakpoints) from the [Material Design System](https://material.io/).

## Getting Started

This package provides the material breakpoint entries for adaptive/responsive development in Flutter.

First, add the `adaptive_breakpoints` package to your pubspec dependencies.

To import `adaptive_breakpoints`:

```dart
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart
```

In this example, we created an adaptive container which will 'activate' anytime that window screen is
on same as the window limit. If they are the same the child will show otherwise it will be an empty container.

Try it yourself with this [dartpad](https://dartpad.dev/?id=fd5f55145f74ffa9c66eb0fe11991d63)

```dart
// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';

void main() {
  runApp(AdaptiveBreakpointsExample());
}

class AdaptiveBreakpointsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            AdaptiveContainer(
              adaptiveConstraints: AdaptiveConstraints(xs: true),
              color: Colors.red,
              child: Text('This is an extra small window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: AdaptiveConstraints(s: true),
              color: Colors.orange,
              child: Text('This is a small window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: AdaptiveConstraints(m: true),
              color: Colors.yellow,
              child: Text('This is a medium window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: AdaptiveConstraints(l: true),
              color: Colors.green,
              child: Text('This is a large window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: AdaptiveConstraints(xl: true),
              color: Colors.blue,
              child: Text('This is an extra large window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: AdaptiveConstraints(
                xs: true,
                s: true,
              ),
              color: Colors.indigo,
              child: Text('This is a small or extra small window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: AdaptiveConstraints(
                m: true,
                l: true,
                xl: true,
              ),
              color: Colors.pink,
              child: Text('This is a medium, large, or extra large window'),
            ),
          ],
        ),
      ),
    );
  }
}

```
