import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

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
                    // On Android S+ devices, use the 40 tone of the dynamic primary
                    // tonal palette. Otherwise, default to a 600 shade orange.
                    color:
                        corePalette?.primary.tone40 ?? Colors.orange.shade600,
                  ),
                  Text(
                      'The square\'s color is ${(corePalette?.primary.tone40 != null) ? 'dynamic' : 'orange'}'),
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
