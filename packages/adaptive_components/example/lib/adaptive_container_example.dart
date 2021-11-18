// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:adaptive_components/adaptive_components.dart';

void main() {
  runApp(const AdaptiveContainerExample());
}

class AdaptiveContainerExample extends StatelessWidget {
  const AdaptiveContainerExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            AdaptiveContainer(
              constraints: const AdaptiveConstraints.xsmall(),
              color: Colors.red,
              child: const Text('This is an extra small window'),
            ),
            AdaptiveContainer(
              constraints: const AdaptiveConstraints.small(),
              color: Colors.orange,
              child: const Text('This is a small window'),
            ),
            AdaptiveContainer(
              constraints: const AdaptiveConstraints.medium(),
              color: Colors.yellow,
              child: const Text('This is a medium window'),
            ),
            AdaptiveContainer(
              constraints: const AdaptiveConstraints.large(),
              color: Colors.green,
              child: const Text('This is a large window'),
            ),
            AdaptiveContainer(
              constraints: const AdaptiveConstraints.xlarge(),
              color: Colors.blue,
              child: const Text('This is an extra large window'),
            ),
            AdaptiveContainer(
              constraints: const AdaptiveConstraints(
                xsmall: true,
                small: true,
                medium: false,
                large: false,
                xlarge: false,
              ),
              color: Colors.indigo,
              child: const Text('This is a small or extra small window'),
            ),
            AdaptiveContainer(
              constraints: const AdaptiveConstraints(
                xsmall: false,
                small: false,
                medium: true,
                large: true,
                xlarge: true,
              ),
              color: Colors.pink,
              child:
                  const Text('This is a medium, large, or extra large window'),
            ),
          ],
        ),
      ),
    );
  }
}
