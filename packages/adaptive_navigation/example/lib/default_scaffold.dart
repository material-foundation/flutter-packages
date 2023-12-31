import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: DefaultScaffoldDemo()));
}

class DefaultScaffoldDemo extends StatefulWidget {
  const DefaultScaffoldDemo({Key? key}) : super(key: key);

  @override
  DefaultScaffoldDemoState createState() => DefaultScaffoldDemoState();
}

class DefaultScaffoldDemoState extends State<DefaultScaffoldDemo> {
  int _destinationCount = 5;
  bool _fabInRail = false;
  bool _includeBaseDestinationsInMenu = true;

  @override
  Widget build(BuildContext context) {
    return AdaptiveNavigationScaffold(
      selectedIndex: 0,
      destinations: _allDestinations.sublist(0, _destinationCount),
      appBar: AdaptiveAppBar(title: const Text('Default Demo')),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      fabInRail: _fabInRail,
      includeBaseDestinationsInMenu: _includeBaseDestinationsInMenu,
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('''
          This is the default behavior of the AdaptiveNavigationScaffold.
          It switches between bottom navigation, navigation rail, and a permanent drawer.
          Resize the window to switch between the navigation types.
          '''),
          const SizedBox(height: 40),
          Slider(
            min: 2,
            max: _allDestinations.length.toDouble(),
            divisions: _allDestinations.length - 2,
            value: _destinationCount.toDouble(),
            label: _destinationCount.toString(),
            onChanged: (value) {
              setState(() {
                _destinationCount = value.round();
              });
            },
          ),
          const Text('Destination Count'),
          const SizedBox(height: 40),
          Switch(
            value: _fabInRail,
            onChanged: (value) {
              setState(() {
                _fabInRail = value;
              });
            },
          ),
          const Text('fabInRail'),
          const SizedBox(height: 40),
          Switch(
            value: _includeBaseDestinationsInMenu,
            onChanged: (value) {
              setState(() {
                _includeBaseDestinationsInMenu = value;
              });
            },
          ),
          const Text('includeBaseDestinationsInMenu'),
          const SizedBox(height: 40),
          ElevatedButton(
            child: const Text('BACK'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}

const _allDestinations = [
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
