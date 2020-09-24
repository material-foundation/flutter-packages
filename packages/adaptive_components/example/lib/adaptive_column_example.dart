// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:adaptive_components/adaptive_components.dart';

void main() {
  runApp(AdaptiveColumnsExample());
}

class AdaptiveColumnsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AdaptiveColumn(
          children: [
            AdaptiveContainer(
              constraints: AdaptiveConstraints.xsmall(),
              columnSpan: 2,
              color: Colors.red,
              child: Text('This is an extra small window'),
            ),
            AdaptiveContainer(
              constraints: AdaptiveConstraints.small(),
              columnSpan: 2,
              color: Colors.orange,
              child: Text('This is a small window'),
            ),
            AdaptiveContainer(
              constraints: AdaptiveConstraints.medium(),
              columnSpan: 2,
              color: Colors.yellow,
              child: Text('This is a medium window'),
            ),
            AdaptiveContainer(
              constraints: AdaptiveConstraints.large(),
              columnSpan: 2,
              color: Colors.green,
              child: Text('This is a large window'),
            ),
            AdaptiveContainer(
              constraints: AdaptiveConstraints.xlarge(),
              columnSpan: 2,
              color: Colors.blue,
              child: Text('This is an extra large window'),
            ),
            AdaptiveContainer(
              constraints: AdaptiveConstraints.xsmall(
                xsmall: true,
                small: true,
              ),
              columnSpan: 2,
              color: Colors.indigo,
              child: Text('This is a small or extra small window'),
            ),
            AdaptiveContainer(
              constraints: AdaptiveConstraints.medium(
                medium: true,
                large: true,
                xlarge: true,
              ),
              columnSpan: 2,
              color: Colors.pink,
              child: Text('This is a medium, large, or extra large window'),
            ),
            AdaptiveContainer(
              columnSpan: 12,
              color: Colors.black,
              child: Text('This is for every screen size'),
            ),
            AdaptiveContainer(
              columnSpan: 6,
              color: Colors.black,
              child: Text('This is for every screen size'),
            ),
            AdaptiveContainer(
              columnSpan: 6,
              color: Colors.black,
              child: Text('This is for every screen size'),
            ),
            AdaptiveContainer(
              columnSpan: 4,
              color: Colors.black,
              child: Text('This is for every screen size'),
            ),
            AdaptiveContainer(
              columnSpan: 4,
              color: Colors.black,
              child: Text('This is for every screen size'),
            ),
            AdaptiveContainer(
              columnSpan: 4,
              color: Colors.black,
              child: Text('This is for every screen size'),
            ),
            AdaptiveContainer(
              columnSpan: 2,
              color: Colors.black,
              child: Text('This is for every screen size'),
            ),
            AdaptiveContainer(
              columnSpan: 2,
              color: Colors.black,
              child: Text('This is for every screen size'),
            ),
            AdaptiveContainer(
              columnSpan: 2,
              color: Colors.black,
              child: Text('This is for every screen size'),
            ),
            AdaptiveContainer(
              columnSpan: 2,
              color: Colors.black,
              child: Text('This is for every screen size'),
            ),
            AdaptiveContainer(
              columnSpan: 2,
              color: Colors.black,
              child: Text('This is for every screen size'),
            ),
            AdaptiveContainer(
              columnSpan: 2,
              color: Colors.black,
              child: Text('This is for every screen size'),
            ),
          ],
        ),
      ),
    );
  }
}
