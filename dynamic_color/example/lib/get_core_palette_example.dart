import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdvancedExample2 extends StatefulWidget {
  const AdvancedExample2({Key? key}) : super(key: key);

  static const title = 'DynamicColorPlugin.getCorePalette()';

  @override
  State<AdvancedExample2> createState() => _AdvancedExample2State();
}

class _AdvancedExample2State extends State<AdvancedExample2> {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                // On Android S+ devices, use the 40 tone of the dynamic primary
                // tonal palette. Otherwise, default to a 600 shade orange.
                color: _corePalette?.primary.tone40 ?? Colors.orange.shade600,
              ),
              Text(
                  'The square\'s color is ${(_corePalette?.primary.tone40 != null) ? 'dynamic' : 'orange'}'),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
