import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'default_drawer.dart';
import 'definitions.dart';

class NavigationRailScaffold extends StatelessWidget {
  const NavigationRailScaffold({
    required this.body,
    required this.destinations,
    required this.drawerDragStartBehavior,
    required this.drawerEnableOpenDragGesture,
    required this.endDrawerEnableOpenDragGesture,
    required this.extendBody,
    required this.extendBodyBehindAppBar,
    required this.fabInRail,
    required this.includeBaseDestinationsInMenu,
    required this.selectedIndex,
    this.appBar,
    this.backgroundColor,
    this.bottomSheet,
    this.drawerEdgeDragWidth,
    this.drawerFooter,
    this.drawerHeader,
    this.drawerScrimColor,
    this.endDrawer,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.onDestinationSelected,
    this.persistentFooterButtons,
    this.resizeToAvoidBottomInset,
    super.key,
  });

  final Color? backgroundColor;
  final Color? drawerScrimColor;
  final DragStartBehavior drawerDragStartBehavior;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<AdaptiveScaffoldDestination> destinations;
  final List<Widget>? persistentFooterButtons;
  final PreferredSizeWidget? appBar;
  final ValueChanged<int>? onDestinationSelected;
  final Widget body;
  final Widget? bottomSheet;
  final Widget? drawerFooter;
  final Widget? drawerHeader;
  final Widget? endDrawer;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool fabInRail;
  final bool includeBaseDestinationsInMenu;
  final bool? resizeToAvoidBottomInset;
  final double? drawerEdgeDragWidth;
  final int selectedIndex;

  static const int railDestinationsOverflow = 7;

  @override
  Widget build(final BuildContext context) {
    final railDestinations = destinations.sublist(
      0,
      math.min(destinations.length, railDestinationsOverflow),
    );
    final drawerDestinations = destinations.length > railDestinationsOverflow
        ? destinations.sublist(
            includeBaseDestinationsInMenu ? 0 : railDestinationsOverflow)
        : <AdaptiveScaffoldDestination>[];
    return Scaffold(
      key: key,
      appBar: appBar,
      drawer: drawerDestinations.isEmpty
          ? null
          : DefaultDrawer(
              destinations: drawerDestinations,
              onDestinationSelected: onDestinationSelected,
              drawerHeader: drawerHeader,
              drawerFooter: drawerFooter,
            ),
      body: Row(
        children: [
          NavigationRail(
            leading: fabInRail ? floatingActionButton : null,
            destinations: [
              for (final destination in railDestinations)
                NavigationRailDestination(
                  icon: Icon(destination.icon),
                  label: Text(destination.title),
                ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected ?? (_) {},
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(child: body),
        ],
      ),
      floatingActionButton: fabInRail ? null : floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      endDrawer: endDrawer,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: true,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
    );
  }
}
