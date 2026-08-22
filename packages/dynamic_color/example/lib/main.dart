import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';

import 'accent_color.dart';
import 'common.dart';
import 'complete_example.dart';
import 'core_palette_visualization.dart';
import 'dynamic_color_builder_example.dart';
import 'get_core_palette_example.dart';
import 'get_tonal_palettes_example.dart';
import 'harmonization_example.dart';
import 'tonal_palettes_visualization.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            // Clean fade transitions for Web/Desktop environments
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Examples')),
        body: Center(
          child: Container(
            constraints: contentMaxWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _ExampleAppButton(
                  title: CompleteExample.title,
                  widget: CompleteExample(),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Advanced examples',
                    style: textTheme.titleMedium,
                  ),
                ),
                const _ExampleAppButton(
                  title: CorePaletteVisualization.title,
                  widget: CorePaletteVisualization(),
                ),
                const _ExampleAppButton(
                  title: TonalPalettesVisualization.title,
                  widget: TonalPalettesVisualization(),
                ),
                const _ExampleAppButton(
                  title: AccentColorExample.title,
                  widget: AccentColorExample(),
                ),
                const _ExampleAppButton(
                  title: HarmonizationExample.title,
                  widget: HarmonizationExample(),
                ),
                const _ExampleAppButton(
                  title: AdvancedExample1.title,
                  widget: AdvancedExample1(),
                ),
                const _ExampleAppButton(
                  title: AdvancedExample2.title,
                  widget: AdvancedExample2(),
                ),
                const _ExampleAppButton(
                    title: AdvancedExample3.title, widget: AdvancedExample3())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExampleAppButton extends StatelessWidget {
  const _ExampleAppButton({
    required this.title,
    required this.widget,
  });

  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(title, style: const TextStyle(fontSize: 14)),
              ),
              body: Padding(
                  padding: (title == CompleteExample.title)
                      ? EdgeInsets.zero
                      : contentPadding,
                  child: widget),
            ),
          ),
        ),
      ),
    );
  }
}
