import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Adaptive Navigation test', (WidgetTester tester) async {
    const mediumWindowSize = Size(960, 1000);
    tester.view.physicalSize = mediumWindowSize;
    tester.view.devicePixelRatio = 1.0;

    const allDestinations = [
      AdaptiveScaffoldDestination(title: 'Alarm', icon: Icons.alarm),
      AdaptiveScaffoldDestination(title: 'Book', icon: Icons.book),
      AdaptiveScaffoldDestination(title: 'Cake', icon: Icons.cake),
      AdaptiveScaffoldDestination(title: 'Directions', icon: Icons.directions),
      AdaptiveScaffoldDestination(title: 'Email', icon: Icons.email),
      AdaptiveScaffoldDestination(title: 'Favorite', icon: Icons.favorite),
      AdaptiveScaffoldDestination(title: 'Group', icon: Icons.group),
      AdaptiveScaffoldDestination(title: 'Headset', icon: Icons.headset),
      AdaptiveScaffoldDestination(title: 'Info', icon: Icons.info),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: AdaptiveNavigationScaffold(
          selectedIndex: 0,
          destinations: allDestinations,
          appBar: AdaptiveAppBar(title: const Text('Default Demo')),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
          body: Container(
            color: Colors.green,
          ),
        ),
      ),
    );
    expect(find.byType(AdaptiveNavigationScaffold), findsOneWidget);
  });
}
