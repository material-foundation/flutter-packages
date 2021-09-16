import 'package:flutter/material.dart';

import 'complete_example.dart';
import 'dynamic_colors_builder_example.dart';
import 'get_dynamic_colors_example.dart';
import 'key_palettes_visualization.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Examples')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              _ExampleAppButton(
                  title: CompleteExample.title, widget: CompleteExample()),
              Divider(),
              _ExampleAppButton(
                title: KeyPalettesVisualization.title,
                widget: KeyPalettesVisualization(),
              ),
              Divider(),
              _ExampleAppButton(title: Example1.title, widget: Example1()),
              _ExampleAppButton(title: Example2.title, widget: Example2()),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExampleAppButton extends StatelessWidget {
  const _ExampleAppButton({Key? key, required this.title, required this.widget})
      : super(key: key);

  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
    );
  }
}
