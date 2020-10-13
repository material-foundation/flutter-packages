// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'adaptive_column_example.dart';
import 'adaptive_container_example.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Navigation Scaffold Demo',
      home: DemoSelector(),
    );
  }
}

class DemoSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Adaptive Column'),
              onPressed: () {
                Navigator.of(context)!.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return AdaptiveColumnsExample();
                    },
                  ),
                );
              },
            ),
            RaisedButton(
              child: Text('Adaptive Container'),
              onPressed: () {
                Navigator.of(context)!.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return AdaptiveContainerExample();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
