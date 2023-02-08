// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_scaffold.dart';
import 'definitions.dart';
import 'navigation_drawer_scaffold.dart';
import 'navigation_rail_scaffold.dart';
import 'permanent_drawer_scaffold.dart';

/// A widget that adapts to the current display size, displaying a [Drawer],
/// [NavigationRail], or [BottomNavigationBar]. Navigation destinations are
/// defined in the [destinations] parameter.
class AdaptiveNavigationScaffold extends StatelessWidget {
  const AdaptiveNavigationScaffold({
    Key? key,
    required this.body,
    required this.selectedIndex,
    required this.destinations,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.endDrawer,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.onDestinationSelected,
    this.navigationTypeResolver = defaultNavigationTypeResolver,
    this.drawerHeader,
    this.drawerFooter,
    this.fabInRail = true,
    this.includeBaseDestinationsInMenu = true,
    this.bottomNavigationOverflow = 5,
  }) : super(key: key);

  /// See [Scaffold.appBar].
  final PreferredSizeWidget? appBar;

  /// See [Scaffold.body].
  final Widget body;

  /// See [Scaffold.floatingActionButton].
  final FloatingActionButton? floatingActionButton;

  /// See [Scaffold.floatingActionButtonLocation].
  ///
  /// Ignored if [fabInRail] is true.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// See [Scaffold.floatingActionButtonAnimator].
  ///
  /// Ignored if [fabInRail] is true.
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// See [Scaffold.persistentFooterButtons].
  final List<Widget>? persistentFooterButtons;

  /// See [Scaffold.endDrawer].
  final Widget? endDrawer;

  /// See [Scaffold.drawerScrimColor].
  final Color? drawerScrimColor;

  /// See [Scaffold.backgroundColor].
  final Color? backgroundColor;

  /// See [Scaffold.bottomSheet].
  final Widget? bottomSheet;

  /// See [Scaffold.resizeToAvoidBottomInset].
  final bool? resizeToAvoidBottomInset;

  /// See [Scaffold.primary].
  final bool primary;

  /// See [Scaffold.drawerDragStartBehavior].
  final DragStartBehavior drawerDragStartBehavior;

  /// See [Scaffold.extendBody].
  final bool extendBody;

  /// See [Scaffold.extendBodyBehindAppBar].
  final bool extendBodyBehindAppBar;

  /// See [Scaffold.drawerEdgeDragWidth].
  final double? drawerEdgeDragWidth;

  /// See [Scaffold.drawerEnableOpenDragGesture].
  final bool drawerEnableOpenDragGesture;

  /// See [Scaffold.endDrawerEnableOpenDragGesture].
  final bool endDrawerEnableOpenDragGesture;

  /// The index into [destinations] for the current selected
  /// [AdaptiveScaffoldDestination].
  final int selectedIndex;

  /// Defines the appearance of the items that are arrayed within the
  /// navigation.
  ///
  /// The value must be a list of two or more [AdaptiveScaffoldDestination]
  /// values.
  final List<AdaptiveScaffoldDestination> destinations;

  /// Called when one of the [destinations] is selected.
  ///
  /// The stateful widget that creates the adaptive scaffold needs to keep
  /// track of the index of the selected [AdaptiveScaffoldDestination] and call
  /// `setState` to rebuild the adaptive scaffold with the new [selectedIndex].
  final ValueChanged<int>? onDestinationSelected;

  /// Determines the navigation type that the scaffold uses.
  final NavigationTypeResolver navigationTypeResolver;

  /// The leading item in the drawer when the navigation has a drawer.
  ///
  /// If null, then there is no header.
  final Widget? drawerHeader;

  /// The footer item in the drawer when the navigation has a drawer.
  ///
  /// If null, then there is no footer.
  final Widget? drawerFooter;

  /// Whether the [floatingActionButton] is inside or the rail or in the regular
  /// spot.
  ///
  /// If true, then [floatingActionButtonLocation] and
  /// [floatingActionButtonAnimation] are ignored.
  final bool fabInRail;

  /// Weather the overflow menu defaults to include overflow destinations and
  /// the overflow destinations.
  final bool includeBaseDestinationsInMenu;

  /// Maximum number of items to display in [bottomNavigationBar]
  final int bottomNavigationOverflow;

  @override
  Widget build(BuildContext context) {
    final navigationType = navigationTypeResolver(context);
    switch (navigationType) {
      case NavigationType.bottom:
        return BottomNavigationScaffold(
          key: key,
          appBar: appBar,
          body: body,
          bottomNavigationOverflow: bottomNavigationOverflow,
          destinations: destinations,
          drawerFooter: drawerFooter,
          drawerHeader: drawerHeader,
          floatingActionButton: floatingActionButton,
          includeBaseDestinationsInMenu: includeBaseDestinationsInMenu,
          onDestinationSelected: onDestinationSelected,
          selectedIndex: selectedIndex,
        );
      case NavigationType.rail:
        return NavigationRailScaffold(
          key: key,
          appBar: appBar,
          backgroundColor: backgroundColor,
          body: body,
          bottomSheet: bottomSheet,
          destinations: destinations,
          drawerDragStartBehavior: drawerDragStartBehavior,
          drawerEdgeDragWidth: drawerEdgeDragWidth,
          drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
          drawerFooter: drawerFooter,
          drawerHeader: drawerHeader,
          drawerScrimColor: drawerScrimColor,
          endDrawer: endDrawer,
          endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          fabInRail: fabInRail,
          floatingActionButton: floatingActionButton,
          floatingActionButtonAnimator: floatingActionButtonAnimator,
          floatingActionButtonLocation: floatingActionButtonLocation,
          includeBaseDestinationsInMenu: includeBaseDestinationsInMenu,
          onDestinationSelected: onDestinationSelected,
          persistentFooterButtons: persistentFooterButtons,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          selectedIndex: selectedIndex,
        );
      case NavigationType.drawer:
        return NavigationDrawerScaffold(
          key: key,
          appBar: appBar,
          backgroundColor: backgroundColor,
          body: body,
          bottomSheet: bottomSheet,
          destinations: destinations,
          drawerDragStartBehavior: drawerDragStartBehavior,
          drawerEdgeDragWidth: drawerEdgeDragWidth,
          drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
          drawerFooter: drawerFooter,
          drawerHeader: drawerHeader,
          drawerScrimColor: drawerScrimColor,
          endDrawer: endDrawer,
          endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          floatingActionButton: floatingActionButton,
          floatingActionButtonAnimator: floatingActionButtonAnimator,
          floatingActionButtonLocation: floatingActionButtonLocation,
          onDestinationSelected: onDestinationSelected,
          persistentFooterButtons: persistentFooterButtons,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          selectedIndex: selectedIndex,
        );
      case NavigationType.permanentDrawer:
        return PermanentDrawerScaffold(
          key: key,
          appBar: appBar,
          backgroundColor: backgroundColor,
          body: body,
          bottomSheet: bottomSheet,
          destinations: destinations,
          drawerDragStartBehavior: drawerDragStartBehavior,
          drawerEdgeDragWidth: drawerEdgeDragWidth,
          drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
          drawerFooter: drawerFooter,
          drawerHeader: drawerHeader,
          drawerScrimColor: drawerScrimColor,
          endDrawer: endDrawer,
          endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          floatingActionButton: floatingActionButton,
          floatingActionButtonAnimator: floatingActionButtonAnimator,
          floatingActionButtonLocation: floatingActionButtonLocation,
          onDestinationSelected: onDestinationSelected,
          persistentFooterButtons: persistentFooterButtons,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          selectedIndex: selectedIndex,
        );
    }
  }
}
