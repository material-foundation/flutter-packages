// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_components/adaptive_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Color adaptiveContainerColor = Colors.pink;
  testWidgets(
    'Adaptive Container test',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(800, 600);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: AdaptiveContainer(
            color: adaptiveContainerColor,
            constraints: const AdaptiveConstraints(small: true),
          ),
        ),
      );

      var box = tester.widget<Container>(find.byType(Container));
      expect(find.byType(Container), findsOneWidget);
      expect(box.color, adaptiveContainerColor);

      tester.view.physicalSize = const Size(2000, 600);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: AdaptiveContainer(
            color: adaptiveContainerColor,
            constraints: const AdaptiveConstraints(xlarge: false),
          ),
        ),
      );

      expect(find.byType(Container), findsNothing);
    },
  );

  testWidgets(
    'Adaptive Container test on the edge of adaptive window',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(399.5, 600);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: AdaptiveContainer(
            color: adaptiveContainerColor,
            constraints: const AdaptiveConstraints(xsmall: true),
          ),
        ),
      );

      var box = tester.widget<Container>(find.byType(Container));
      expect(find.byType(Container), findsOneWidget);
      expect(box.color, adaptiveContainerColor);

      tester.view.physicalSize = const Size(1919.99999, 600);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: AdaptiveContainer(
            color: adaptiveContainerColor,
            constraints: const AdaptiveConstraints(large: true),
          ),
        ),
      );

      box = tester.widget<Container>(find.byType(Container));
      expect(find.byType(Container), findsOneWidget);
      expect(box.color, adaptiveContainerColor);
    },
  );
}
