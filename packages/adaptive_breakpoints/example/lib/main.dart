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
