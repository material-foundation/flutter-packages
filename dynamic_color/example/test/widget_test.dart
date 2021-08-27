// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dynamic_colors_example/dynamic_colors_builder_example.dart';
// ignore: unused_import
import 'package:dynamic_colors_example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Verify default color', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExampleApp1());

    // Verify that default color is used.
    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is Container && widget.color == Colors.amber[500],
      ),
      findsOneWidget,
    );
  });
}
