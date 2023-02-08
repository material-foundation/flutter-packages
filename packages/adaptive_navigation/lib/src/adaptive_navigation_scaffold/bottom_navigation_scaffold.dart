import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'default_drawer.dart';
import 'definitions.dart';

class BottomNavigationScaffold extends StatelessWidget {
  const BottomNavigationScaffold({
    required this.destinations,
    required this.bottomNavigationOverflow,
    required this.includeBaseDestinationsInMenu,
    required this.selectedIndex,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.onDestinationSelected,
    this.drawerHeader,
    this.drawerFooter,
    super.key,
  });

  final List<AdaptiveScaffoldDestination> destinations;
  final int bottomNavigationOverflow;
  final bool includeBaseDestinationsInMenu;
  final int selectedIndex;
  final Widget body;
  final PreferredSizeWidget? appBar;
  final FloatingActionButton? floatingActionButton;
  final Widget? drawerHeader;
  final Widget? drawerFooter;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(final BuildContext context) {
    final bottomDestinations = destinations.sublist(
      0,
      math.min(destinations.length, bottomNavigationOverflow),
    );
    final drawerDestinations = destinations.length > bottomNavigationOverflow
        ? destinations.sublist(
            includeBaseDestinationsInMenu ? 0 : bottomNavigationOverflow)
        : <AdaptiveScaffoldDestination>[];
    return Scaffold(
      key: key,
      body: body,
      appBar: appBar,
      drawer: drawerDestinations.isEmpty
          ? null
          : DefaultDrawer(
              destinations: drawerDestinations,
              onDestinationSelected: onDestinationSelected,
              drawerHeader: drawerHeader,
              drawerFooter: drawerFooter,
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          for (final destination in bottomDestinations)
            BottomNavigationBarItem(
              icon: Icon(destination.icon),
              label: destination.title,
            ),
        ],
        currentIndex: selectedIndex,
        onTap: onDestinationSelected ?? (_) {},
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
