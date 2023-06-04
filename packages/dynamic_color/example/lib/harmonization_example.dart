import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color_example/common.dart';
import 'package:flutter/material.dart';

class HarmonizationExample extends StatelessWidget {
  const HarmonizationExample({Key? key}) : super(key: key);

  static const title = 'Color harmonization';

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xff0b57d0);
    return Column(
      children: [
        const ColoredSquare(primaryColor, 'Primary color'),
        const ColoredSquare(Colors.red, 'Red'),
        ColoredSquare(
          Colors.red.harmonizeWith(primaryColor),
          'Red, harmonized with primary color',
        ),
      ],
    );
  }
}
