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
            AdaptiveContaine(
              color: Colors.red,
              child: Text('This is an extra small window'),
            ),
            AdaptiveContaine(
              color: Colors.orange,
              child: Text('This is a small window'),
            ),
            AdaptiveContaine(
              color: Colors.yellow,
              child: Text('This is a medium window'),
            ),
            AdaptiveContaine(
              color: Colors.green,
              child: Text('This is a large window'),
            ),
            AdaptiveContaine(
              color: Colors.blue,
              child: Text('This is an extra large window'),
            ),
            AdaptiveContaine(
              adaptiveConstraints: AdaptiveConstraints(
                xs: true,
                sm: true,
              ),
              color: Colors.indigo,
              child: Text('This is a small or extra small window'),
            ),
            AdaptiveContaine(
              adaptiveConstraints: AdaptiveConstraints(
                md: true,
                lg: true,
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
