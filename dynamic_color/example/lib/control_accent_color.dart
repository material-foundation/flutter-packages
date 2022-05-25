import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color_example/common.dart';

import 'package:flutter/material.dart';

class ControlAccentColorExample extends StatelessWidget {
  const ControlAccentColorExample({Key? key}) : super(key: key);

  static const title = 'Control accent color';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Color?>(
      future: DynamicColorPlugin.getControlAccentColor(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final color = snapshot.data;
          return color == null
              ? const Text(
                  "Control accent color isn't supported on this platform",
                )
              : Column(
                  children: [
                    ColoredSquare(color, 'Control Accent Color'),
                  ],
                );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
