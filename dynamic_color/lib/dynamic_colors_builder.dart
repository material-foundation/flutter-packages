import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'dynamic_colors_plugin.dart';
import 'tonal_palette.dart';

/// A stateful builder widget that provides a [TonalPalette].
///
/// The [TonalPalette] object will be null on non-Android platforms and
/// pre-Android S devices.
///
/// Example usage:
/// ```dart
/// DynamicColorsBuilder(
///   builder: (TonalPalette? dynamicColors) {
///     return Container(
///       color: dynamicColors?.primary.shade500 ?? Colors.amber[500],
///     );
///   }
/// )
/// ```
///
/// See also:
///
///  * [DynamicColorsBuilder example](https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/dynamic_colors_builder_example.dart)
///  * [Complete example](https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/complete_example.dart) for obtaining dynamic
///    colors and creating a harmonized color scheme
///  * [DynamicColorsPlugin.getDynamicColors] for requesting the colors
///    directly, asynchronously.
class DynamicColorsBuilder extends StatefulWidget {
  const DynamicColorsBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  /// Builds the child widget of this widget, using the [TonalPalette] object
  /// passed in.
  ///
  /// The [TonalPalette] object will be null if the dynamic colors are not
  /// available, or have not been returned yet. For example, using this builder
  /// on an iOS device will always result in a `null` [TonalPalette] object.
  final Widget Function(TonalPalette?) builder;

  @override
  _DynamicColorsBuilderState createState() => _DynamicColorsBuilderState();
}

class _DynamicColorsBuilderState extends State<DynamicColorsBuilder> {
  TonalPalette? _dynamicColors;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    TonalPalette? dynamicColors;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      dynamicColors = await DynamicColorsPlugin.getDynamicColors();
    } on PlatformException {
      debugPrint('Failed to obtain dynamic colors.');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _dynamicColors = dynamicColors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_dynamicColors);
  }
}
