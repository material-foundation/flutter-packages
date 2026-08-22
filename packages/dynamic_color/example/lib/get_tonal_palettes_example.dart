import 'package:dynamic_color/dynamic_color.dart';
import 'package:material_ui/material_ui.dart';

import 'common.dart';

class AdvancedExample3 extends StatelessWidget {
  const AdvancedExample3({super.key});

  static const title = 'DynamicColorPlugin.getTonalPalettes()';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DynamicColorPlugin.getTonalPalettes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }

          final tonalPalettes = snapshot.data;
          final primaryPalette = tonalPalettes?.first;
          return ColoredSquare(
              Color(primaryPalette?.get(40) ?? 0xFFFB8C00),
              primaryPalette != null
                  ? 'tonalPalettes.first.get(40)'
                  : 'Color(0xFFFB8C00)');
        });
  }
}
