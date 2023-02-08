import 'package:flutter/material.dart';

import 'definitions.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({
    required this.destinations,
    this.onDestinationSelected,
    this.drawerHeader,
    this.drawerFooter,
    super.key,
  });

  final List<AdaptiveScaffoldDestination> destinations;
  final ValueChanged<int>? onDestinationSelected;
  final Widget? drawerFooter;
  final Widget? drawerHeader;

  @override
  Widget build(final BuildContext context) => Drawer(
        child: ListView(
          children: [
            if (drawerHeader != null) drawerHeader!,
            for (int i = 0; i < destinations.length; i++)
              ListTile(
                leading: Icon(destinations[i].icon),
                title: Text(destinations[i].title),
                onTap: () {
                  onDestinationSelected?.call(i);
                },
              ),
            const Spacer(),
            if (drawerFooter != null) drawerFooter!,
          ],
        ),
      );
}
