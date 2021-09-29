import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class HarmonizationExample extends StatelessWidget {
  const HarmonizationExample({Key? key}) : super(key: key);

  static const title = 'Color harmonization';

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xff0b57d0);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 100, height: 100, color: primaryColor),
          const Text('Primary color'),
          const SizedBox(height: 20),
          Container(width: 100, height: 100, color: Colors.red),
          const Text('Red'),
          const SizedBox(height: 20),
          Container(
            width: 100,
            height: 100,
            color: Colors.red.harmonizeWith(primaryColor),
          ),
          const Text('Red, harmonized with primary color'),
        ],
      ),
    );
  }
}
