import 'package:adaptive_navigation_example/custom_scaffold.dart';
import 'package:flutter/material.dart';

import 'default_scaffold.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Navigation Scaffold Demo',
      home: DemoSelector(),
    );
  }
}

class DemoSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Default Scaffold'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return DefaultScaffoldDemo();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            RaisedButton(
              child: Text('Custom Scaffold'),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return CustomScaffoldDemo();
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
