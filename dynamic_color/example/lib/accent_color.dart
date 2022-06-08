import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color_example/common.dart';
import 'package:flutter/material.dart';

class AccentColorExample extends StatelessWidget {
  const AccentColorExample({Key? key}) : super(key: key);

  static const title = 'Accent color (desktop)';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Color?>(
      future: DynamicColorPlugin.getAccentColor(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final color = snapshot.data;
          return color == null
              ? const Text(
                  "Accent color isn't supported on this platform",
                )
              : Column(
                  children: [
                    ColoredSquare(color, 'Accent color'),
                  ],
                );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
