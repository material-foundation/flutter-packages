import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Adaptive Navigation test', (WidgetTester tester) async {
    const mediumWindowSize = Size(960, 1000);
    tester.view.physicalSize = mediumWindowSize;
    tester.view.devicePixelRatio = 1.0;

    const allDestinations = [
      AdaptiveScaffoldDestination(title: 'Alarm', icon: Icon(Icons.alarm)),
      AdaptiveScaffoldDestination(title: 'Book', icon: Icon(Icons.book)),
      AdaptiveScaffoldDestination(title: 'Cake', icon: Icon(Icons.cake)),
      AdaptiveScaffoldDestination(title: 'Directions', icon: Icon(Icons.directions)),
      AdaptiveScaffoldDestination(title: 'Email', icon: Icon(Icons.email)),
      AdaptiveScaffoldDestination(title: 'Favorite', icon: Icon(Icons.favorite)),
      AdaptiveScaffoldDestination(title: 'Group', icon: Icon(Icons.group)),
      AdaptiveScaffoldDestination(title: 'Headset', icon: Icon(Icons.headset)),
      AdaptiveScaffoldDestination(title: 'Info', icon: Icon(Icons.info)),
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
