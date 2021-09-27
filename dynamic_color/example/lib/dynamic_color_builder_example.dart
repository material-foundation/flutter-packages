import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class Example1 extends StatelessWidget {
  const Example1({Key? key}) : super(key: key);

  static const title = 'DynamicColorBuilder';

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (CorePalette? corePalette) {
        return MaterialApp(
          home: Scaffold(
            body: Container(
              // On Android S+ devices, use the 40 tone of the dynamic primary
              // tonal palette. Otherwise, default to a 600 shade amber.
              color: corePalette?.primary.tone40 ?? Colors.amber.shade600,
              child: const Center(
                child: Text('The background color is either dynamic or amber'),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
