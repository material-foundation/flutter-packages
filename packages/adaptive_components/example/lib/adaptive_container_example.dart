// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:adaptive_components/adaptive_components.dart';

void main() {
  runApp(AdaptiveContainerExample());
}

class AdaptiveContainerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            AdaptiveContainer(
              constraints: AdaptiveConstraints.xsmall(),
              color: Colors.red,
              child: Text('This is an extra small window'),
            ),
            AdaptiveContainer(
              constraints: AdaptiveConstraints.small(),
              color: Colors.orange,
              child: Text('This is a small window'),
            ),
            AdaptiveContainer(
              constraints: AdaptiveConstraints.medium(),
              color: Colors.yellow,
              child: Text('This is a medium window'),
            ),
            AdaptiveContainer(
              constraints: AdaptiveConstraints.large(),
              color: Colors.green,
              child: Text('This is a large window'),
            ),
            AdaptiveContainer(
              constraints: AdaptiveConstraints.xlarge(),
              color: Colors.blue,
              child: Text('This is an extra large window'),
            ),
            AdaptiveContainer(
              constraints: AdaptiveConstraints(
                xsmall: true,
                small: true,
                medium: false,
                large: false,
                xlarge: false,
              ),
              color: Colors.indigo,
              child: Text('This is a small or extra small window'),
            ),
            AdaptiveContainer(
              constraints: AdaptiveConstraints(
                xsmall: false,
                small: false,
                medium: true,
                large: true,
                xlarge: true,
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
