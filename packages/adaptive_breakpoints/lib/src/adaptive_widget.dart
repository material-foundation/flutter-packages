import 'package:flutter/material.dart';

abstract class AdaptiveWidget extends StatelessWidget {
  final List<Widget> children;

  AdaptiveWidget({
    Key key,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
