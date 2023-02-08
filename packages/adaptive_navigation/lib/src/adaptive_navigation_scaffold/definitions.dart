import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/material.dart';

import 'adaptive_navigation_scaffold.dart';
import 'bottom_navigation_scaffold.dart';
import 'navigation_rail_scaffold.dart';
import 'permanent_drawer_scaffold.dart';

/// Signature for the callback passed to [AdaptiveNavigationScaffold] as
/// [AdaptiveNavigationScaffold.navigationTypeResolver].
typedef NavigationTypeResolver = NavigationType Function(BuildContext context);

/// The navigation mechanism to configure the [Scaffold] with.
enum NavigationType {
  /// Used to configure a [Scaffold] with a [BottomNavigationBar].
  bottom,

  /// Used to configure a [Scaffold] with a [NavigationRail].
  rail,

  /// Used to configure a [Scaffold] with a modal [Drawer].
  drawer,

  /// Used to configure a [Scaffold] with an always open [Drawer].
  permanentDrawer,
}

/// Used to configure items or destinations in the various navigation
/// mechanism. For [BottomNavigationBar], see [BottomNavigationBarItem]. For
/// [NavigationRail], see [NavigationRailDestination]. For [Drawer], see
/// [ListTile].
class AdaptiveScaffoldDestination {
  final String title;
  final IconData icon;

  const AdaptiveScaffoldDestination({
    required this.title,
    required this.icon,
  });
}

/// The default [AdaptiveNavigationScaffold.navigationTypeResolver] that
/// determines the navigation type that the scaffold uses.
///
/// The default behavior is to show a [PermanentDrawerScaffold] on screens of
/// 1440px to [double.infinity]px width, a [NavigationRailScaffold] on screens
/// of 1024px to 1439px width, and a [BottomNavigationScaffold] in any other
/// case.
NavigationType defaultNavigationTypeResolver(final BuildContext context) {
  if (isLargeScreen(context)) {
    return NavigationType.permanentDrawer;
  } else if (isMediumScreen(context)) {
    return NavigationType.rail;
  } else {
    return NavigationType.bottom;
  }
}

bool isLargeScreen(final BuildContext context) =>
    getWindowType(context) >= AdaptiveWindowType.large;
bool isMediumScreen(final BuildContext context) =>
    getWindowType(context) == AdaptiveWindowType.medium;
