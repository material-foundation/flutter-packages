import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color_example/common.dart';
import 'package:material_ui/material_ui.dart';

class AccentColorExample extends StatelessWidget {
  const AccentColorExample({super.key});

  static const title = 'Accent color (desktop)';

  Stream<Color> getAccentColor() async* {
    final initialColor = await DynamicColorPlugin.getAccentColor();

    if (initialColor == null) {
      return;
    }

    yield initialColor;

    yield* DynamicColorPlugin.onAccentColorChanged;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Color?>(
      stream: getAccentColor(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
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
