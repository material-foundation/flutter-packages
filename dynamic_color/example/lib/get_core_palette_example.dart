import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class AdvancedExample2 extends StatelessWidget {
  const AdvancedExample2({Key? key}) : super(key: key);

  static const title = 'DynamicColorPlugin.getCorePalette()';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<CorePalette?>(
            future: DynamicColorPlugin.getCorePalette(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final corePalette = snapshot.data;
                return Column(
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
                      'The square\'s color is ${corePalette != null ? 'dynamic' : 'orange'}',
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
