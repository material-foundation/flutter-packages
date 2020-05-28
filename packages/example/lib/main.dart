import 'package:flutter/material.dart';
import 'package:adaptive_navigation/scaffold.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Navigation Scaffold',
      home: AdaptiveNavigationScaffoldDemo(),
    );
  }
}

class AdaptiveNavigationScaffoldDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveNavigationScaffold(
      currentIndex: 0,
      destinations: [
        AdaptiveScaffoldDestination(title: 'Home', icon: Icons.home),
        AdaptiveScaffoldDestination(title: 'Settings', icon: Icons.settings),
      ],
      body: Center(
        child: Text(
            'Resize the window to switch between the Navigation Rail and Bottom Navigation'),
      ),
    );
  }
}
