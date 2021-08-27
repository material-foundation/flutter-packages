import 'dart:async';

import 'package:dynamic_colors/dynamic_colors_plugin.dart';
import 'package:dynamic_colors/tonal_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExampleApp2 extends StatefulWidget {
  const ExampleApp2({Key? key}) : super(key: key);

  @override
  State<ExampleApp2> createState() => _ExampleApp2State();
}

class _ExampleApp2State extends State<ExampleApp2> {
  TonalPalette? _dynamicColors;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    TonalPalette? dynamicColors;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      dynamicColors = await DynamicColorsPlugin.getDynamicColors();
    } on PlatformException {
      debugPrint('Failed to get dynamic colors.');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _dynamicColors = dynamicColors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          // On Android S+ devices, use the 500 shade of the primary palette
          // On other platforms, default to a mid-range amber.
          color: _dynamicColors?.primary.shade500 ?? Colors.amber[500],
          child: const Center(
            child: Text('DynamicColorsPlugin.getDynamicColors() example app'),
          ),
        ),
      ),
    );
  }
}
