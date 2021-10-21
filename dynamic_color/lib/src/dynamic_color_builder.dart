import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'dynamic_color_plugin.dart';

/// A stateful builder widget that provides a [CorePalette].
///
/// The [CorePalette] will be null on non-Android platforms and pre-Android S
/// devices. See the linked examples for usage.
///
/// See also:
///
///  * [DynamicColorBuilder example](https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/dynamic_color_builder_example.dart)
///  * [Complete example](https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/complete_example.dart)
///    for obtaining dynamic colors and creating a harmonized color scheme
///  * [DynamicColorPlugin.getCorePalette] for requesting the colors
///    directly, asynchronously.
class DynamicColorBuilder extends StatefulWidget {
  const DynamicColorBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  /// Builds the child widget of this widget, using the [CorePalette] passed in.
  ///
  /// The [CorePalette] will be null if dynamic colors are not available,
  /// or have not been returned yet.
  final Widget Function(CorePalette?) builder;

  @override
  _DynamicColorBuilderState createState() => _DynamicColorBuilderState();
}

class _DynamicColorBuilderState extends State<DynamicColorBuilder> {
  CorePalette? _corePalette;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    CorePalette? corePalette;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      corePalette = await DynamicColorPlugin.getCorePalette();
    } on PlatformException {
      debugPrint('Failed to obtain dynamic colors.');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _corePalette = corePalette;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_corePalette);
  }
}