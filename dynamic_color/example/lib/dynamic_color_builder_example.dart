import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class AdvancedExample1 extends StatelessWidget {
  const AdvancedExample1({Key? key}) : super(key: key);

  static const title = 'DynamicColorBuilder';

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (CorePalette? corePalette) {
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    // On Android S+ devices, use the 40 tone of the dynamic
                    // primary tonal palette. Otherwise, default to a 40 tone
                    // orange (Colors.orange.shade600).
                    color: Color(corePalette?.primary.get(40) ?? 0xFFFB8C00),
                  ),
                  Text(
                      'The square\'s color is ${corePalette != null ? 'dynamic' : 'orange'}'),
                ],
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
