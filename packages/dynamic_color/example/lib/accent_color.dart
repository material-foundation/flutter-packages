import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color_example/common.dart';
import 'package:material_ui/material_ui.dart';

class AccentColorExample extends StatelessWidget {
  const AccentColorExample({super.key});

  static const title = 'Accent color (desktop)';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Color?>(
      future: DynamicColorPlugin.getAccentColor(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final initialColor = snapshot.data;
          return initialColor == null
              ? const Text(
                  "Accent color isn't supported on this platform",
                )
              : StreamBuilder<Color>(
                  stream: DynamicColorPlugin.onAccentColorChanged,
                  builder: (context, changes) => Column(
                    children: [
                      ColoredSquare(
                        changes.data ?? initialColor,
                        'Accent color',
                      ),
                    ],
                  ),
                );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
