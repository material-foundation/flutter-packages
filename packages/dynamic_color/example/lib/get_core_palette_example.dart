import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

import 'common.dart';

class AdvancedExample2 extends StatelessWidget {
  const AdvancedExample2({Key? key}) : super(key: key);

  static const title = 'DynamicColorPlugin.getCorePalette()';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CorePalette?>(
      future: DynamicColorPlugin.getCorePalette(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final corePalette = snapshot.data;
          return ColoredSquare(
            // On Android S+ devices, use the 40 tone of the dynamic
            // primary tonal palette. Otherwise, default to a 40 tone
            // orange (Colors.orange.shade600).
            Color(corePalette?.primary.get(40) ?? 0xFFFB8C00),
            corePalette != null
                ? 'corePalette.primary.get(40)'
                : 'Color(0xFFFB8C00)',
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
