import 'package:dynamic_colors/dynamic_colors_builder.dart';
import 'package:dynamic_colors/tonal_palette.dart';
import 'package:flutter/material.dart';

class ExampleApp1 extends StatelessWidget {
  const ExampleApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorsBuilder(
      builder: (TonalPalette? dynamicColors) {
        return MaterialApp(
          // TODO(guidezpl): show how to use with theme
          // theme:
          home: Scaffold(
            body: Container(
              // On Android S+ devices, use the 500 shade of the primary palette
              // On other platforms, default to a mid-range amber.
              color: dynamicColors?.primary.shade500 ?? Colors.amber[500],
              child: const Center(
                child: Text('DynamicColorsBuilder example app'),
              ),
            ),
          ),
        );
      },
    );
  }
}
