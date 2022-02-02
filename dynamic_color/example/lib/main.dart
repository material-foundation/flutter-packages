import 'package:flutter/material.dart';

import 'complete_example.dart';
import 'core_palette_visualization.dart';
import 'dynamic_color_builder_example.dart';
import 'get_core_palette_example.dart';
import 'harmonization_example.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Examples')),
        body: Center(
          child: Container(
            constraints: demoWidthConstraints,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Complete example', style: textTheme.headline6),
                const _ExampleAppButton(
                  title: CompleteExample.title,
                  widget: CompleteExample(),
                ),
                const Divider(height: 50),
                Text('CorePalette visualization', style: textTheme.headline6),
                const _ExampleAppButton(
                  title: CorePaletteVisualization.title,
                  widget: CorePaletteVisualization(),
                ),
                const Divider(height: 50),
                Text('Harmonization', style: textTheme.headline6),
                const _ExampleAppButton(
                  title: HarmonizationExample.title,
                  widget: HarmonizationExample(),
                ),
                const Divider(height: 50),
                Text('Advanced examples', style: textTheme.headline6),
                const _ExampleAppButton(
                  title: AdvancedExample1.title,
                  widget: AdvancedExample1(),
                ),
                const _ExampleAppButton(
                  title: AdvancedExample2.title,
                  widget: AdvancedExample2(),
                ),
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
    Key? key,
    required this.title,
    required this.widget,
  }) : super(key: key);

  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        child: Text(title),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(title, style: const TextStyle(fontSize: 14)),
              ),
              body: widget,
            ),
          ),
        ),
      ),
    );
  }
}
