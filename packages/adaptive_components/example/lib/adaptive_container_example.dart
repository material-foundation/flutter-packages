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
              adaptiveConstraints: AdaptiveConstraints.xsmall(),
              color: Colors.red,
              child: Text('This is an extra small window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: AdaptiveConstraints.small(),
              color: Colors.orange,
              child: Text('This is a small window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: AdaptiveConstraints.medium(),
              color: Colors.yellow,
              child: Text('This is a medium window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: AdaptiveConstraints.large(),
              color: Colors.green,
              child: Text('This is a large window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: AdaptiveConstraints.xlarge(),
              color: Colors.blue,
              child: Text('This is an extra large window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: AdaptiveConstraints(
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
              adaptiveConstraints: AdaptiveConstraints(
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
