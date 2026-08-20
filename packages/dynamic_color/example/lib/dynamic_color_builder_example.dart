import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color_example/common.dart';
import 'package:flutter/material.dart';

class AdvancedExample1 extends StatelessWidget {
  const AdvancedExample1({super.key});

  static const title = 'DynamicColorBuilder';

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      customBuilder: (schemes) {
        final lightDynamic = schemes?.light;

        return ColoredSquare(
          lightDynamic?.primary ?? const Color(0xFFFB8C00),
          lightDynamic != null ? 'schemes.light.primary' : 'Color(0xFFFB8C00)',
        );
      },
    );
  }
}
