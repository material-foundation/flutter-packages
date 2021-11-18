import 'package:flutter/material.dart';

import 'custom_scaffold.dart';
import 'default_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Adaptive Navigation Scaffold Demo',
      home: DemoSelector(),
    );
  }
}

class DemoSelector extends StatelessWidget {
  const DemoSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Default Scaffold'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return const DefaultScaffoldDemo();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Custom Scaffold'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return const CustomScaffoldDemo();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
