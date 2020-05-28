// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

typedef NavigationType NavigationTypeResolver(BuildContext context);

// The type of navigation to configure to.
enum NavigationType {
  bottomNavigation,
  navigationRail,
  drawer,
}

/// See bottomNavigationBarItem or NavigationRailDestination
class AdaptiveScaffoldDestination {
  final String title;
  final IconData icon;

  const AdaptiveScaffoldDestination({
    @required this.title,
    @required this.icon,
  })  : assert(title != null),
        assert(icon != null);
}

/// A widget that adapts to the current display size, displaying a [Drawer],
/// [NavigationRail], or [BottomNavigationBar]. Navigation destinations are
/// defined in the [destinations] parameter.
class AdaptiveNavigationScaffold extends StatefulWidget {
  final Widget title;
  final Widget body;
  final int currentIndex;
  final List<AdaptiveScaffoldDestination> destinations;
  final ValueChanged<int> onNavigationIndexChange;
  final FloatingActionButton floatingActionButton;
  final NavigationTypeResolver navigationTypeResolver;

  AdaptiveNavigationScaffold({
    this.title,
    this.body,
    @required this.currentIndex,
    @required this.destinations,
    this.onNavigationIndexChange,
    this.floatingActionButton,
    this.navigationTypeResolver,
  })  : assert(currentIndex != null),
        assert(destinations != null);

  @override
  _AdaptiveNavigationScaffoldState createState() =>
      _AdaptiveNavigationScaffoldState();
}

class _AdaptiveNavigationScaffoldState
    extends State<AdaptiveNavigationScaffold> {
  NavigationType _defaultNavigationTypeResolver(BuildContext context) {
    if (_isLargeScreen(context)) {
      return NavigationType.drawer;
    } else if (_isMediumScreen(context)) {
      return NavigationType.navigationRail;
    } else {
      return NavigationType.bottomNavigation;
    }
  }

  @override
  Widget build(BuildContext context) {
    final NavigationTypeResolver navigationTypeResolver =
        widget.navigationTypeResolver ?? _defaultNavigationTypeResolver;
    switch (navigationTypeResolver(context)) {
      case NavigationType.bottomNavigation:
        // Show a Scaffold with a BottomNavigationBar.
        return Scaffold(
          body: widget.body,
          appBar: AppBar(title: widget.title),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              for (final destination in widget.destinations)
                BottomNavigationBarItem(
                  icon: Icon(destination.icon),
                  title: Text(destination.title),
                ),
            ],
            currentIndex: widget.currentIndex,
            onTap: widget.onNavigationIndexChange,
          ),
          floatingActionButton: widget.floatingActionButton,
        );
      case NavigationType.navigationRail:
        // Show a Scaffold with a body containing a NavigationRail.
        return Scaffold(
          appBar: AppBar(
            title: widget.title,
          ),
          body: Row(
            children: [
              NavigationRail(
                leading: widget.floatingActionButton,
                destinations: [
                  for (final destination in widget.destinations)
                    NavigationRailDestination(
                      icon: Icon(destination.icon),
                      label: Text(destination.title),
                    ),
                ],
                selectedIndex: widget.currentIndex,
                onDestinationSelected: widget.onNavigationIndexChange ?? (_) {},
              ),
              VerticalDivider(
                width: 1,
                thickness: 1,
              ),
              Expanded(
                child: widget.body,
              ),
            ],
          ),
        );
      case NavigationType.drawer:
        // Show a Row containing a Drawer and Scaffold.
        return Row(
          children: [
            Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                    child: Center(
                      child: widget.title,
                    ),
                  ),
                  for (final destination in widget.destinations)
                    ListTile(
                      leading: Icon(destination.icon),
                      title: Text(destination.title),
                      selected: widget.destinations.indexOf(destination) ==
                          widget.currentIndex,
                      onTap: () => _destinationTapped(destination),
                    ),
                ],
              ),
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
            ),
            Expanded(
              child: Scaffold(
                appBar: AppBar(),
                body: widget.body,
                floatingActionButton: widget.floatingActionButton,
              ),
            ),
          ],
        );
    }
  }

  void _destinationTapped(AdaptiveScaffoldDestination destination) {
    final index = widget.destinations.indexOf(destination);
    if (index != widget.currentIndex) {
      widget.onNavigationIndexChange(index);
    }
  }
}

bool _isLargeScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 960.0;
}

bool _isMediumScreen(BuildContext context) {
  return MediaQuery.of(context).size.width > 640.0;
}
