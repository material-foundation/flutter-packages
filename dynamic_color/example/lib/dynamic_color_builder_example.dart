import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class AdvancedExample1 extends StatelessWidget {
  const AdvancedExample1({Key? key}) : super(key: key);

  static const title = 'DynamicColorBuilder';

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    // On Android S+ devices, use the primary dynamic color.
                    // Otherwise, default to a 40 tone orange (Colors.orange.shade600).
                    color: lightDynamic?.primary ?? const Color(0xFFFB8C00),
                  ),
                  Text(
                    'The square\'s color is ${lightDynamic != null ? 'dynamic' : 'orange'}',
                  ),
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
