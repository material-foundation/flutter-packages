import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'definitions.dart';

class NavigationDrawerScaffold extends StatelessWidget {
  const NavigationDrawerScaffold({
    required this.body,
    required this.destinations,
    required this.drawerDragStartBehavior,
    required this.drawerEnableOpenDragGesture,
    required this.endDrawerEnableOpenDragGesture,
    required this.extendBody,
    required this.extendBodyBehindAppBar,
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
  final Widget body;
  final Widget? bottomSheet;
  final Widget? drawerFooter;
  final Widget? drawerHeader;
  final Widget? endDrawer;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final bool? resizeToAvoidBottomInset;
  final double? drawerEdgeDragWidth;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  void destinationTapped(AdaptiveScaffoldDestination destination) {
    final index = destinations.indexOf(destination);
    if (index != selectedIndex) {
      onDestinationSelected?.call(index);
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      key: key,
      body: body,
      appBar: appBar,
      drawer: Drawer(
        child: Column(
          children: [
            if (drawerHeader != null) drawerHeader!,
            for (final destination in destinations)
              ListTile(
                leading: Icon(destination.icon),
                title: Text(destination.title),
                selected: destinations.indexOf(destination) == selectedIndex,
                onTap: () => destinationTapped(destination),
              ),
            const Spacer(),
            if (drawerFooter != null) drawerFooter!,
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
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
