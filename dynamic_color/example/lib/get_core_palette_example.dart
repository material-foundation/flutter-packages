import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Example2 extends StatefulWidget {
  const Example2({Key? key}) : super(key: key);

  static const title = 'DynamicColorPlugin.getCorePalette()';

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  CorePalette? _corePalette;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    CorePalette? corePalette;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      corePalette = await DynamicColorPlugin.getCorePalette();
    } on PlatformException {
      debugPrint('Failed to get dynamic colors.');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _corePalette = corePalette;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          // On Android S+ devices, use the 40 tone of the dynamic primary tonal palette.
          // Otherwise, default to a 600 shade amber.
          color: _corePalette?.primary.tone40 ?? Colors.amber.shade600,
          child: const Center(
            child: Text('The background color is either dynamic or amber'),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
