import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

import 'corepalette_to_colorscheme.dart';
import 'dynamic_color_plugin.dart';

/// A stateful builder widget that provides a light and dark [ColorScheme].
///
/// Android: the [ColorScheme]s are constructed from the [CorePalette] provided
/// by the Android OS.
///
/// macOS, Windows and Linux: the [ColorScheme]s are constructed from the accent
/// [Color] provided by the system.
///
/// See also:
///
///  * [DynamicColorBuilder example](https://github.com/material-foundation/flutter-packages/tree/main/packages/dynamic_color/example/lib/dynamic_color_builder_example.dart)
///  * [Complete example](https://github.com/material-foundation/flutter-packages/tree/main/packages/dynamic_color/example/lib/complete_example.dart)
///    for obtaining dynamic colors and creating a harmonized color scheme
///  * [DynamicColorPlugin.getCorePalette] for requesting the [CorePalette]
///    directly, asynchronously.
///  * [DynamicColorPlugin.getAccentColor] for requesting the accent [Color]
///    [ColorScheme] directly, asynchronously.
class DynamicColorBuilder extends StatefulWidget {
  const DynamicColorBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  /// Builds the child widget of this widget, providing a light and dark [ColorScheme].
  ///
  /// The [ColorScheme]s will be null if dynamic color is not supported on the
  /// platform, or if the OS has yet to respond.
  final Widget Function(
    ColorScheme? lightDynamic,
    ColorScheme? darkDynamic,
  ) builder;

  @override
  DynamicColorBuilderState createState() => DynamicColorBuilderState();
}

class DynamicColorBuilderState extends State<DynamicColorBuilder> {
  ColorScheme? _light;
  ColorScheme? _dark;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      CorePalette? corePalette = await DynamicColorPlugin.getCorePalette();

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      if (corePalette != null) {
        debugPrint('dynamic_color: Core palette detected.');
        setState(() {
          _light = corePalette.toColorScheme();
          _dark = corePalette.toColorScheme(brightness: Brightness.dark);
        });
        return;
      }
    } on PlatformException {
      debugPrint('dynamic_color: Failed to obtain core palette.');
    }

    try {
      final Color? accentColor = await DynamicColorPlugin.getAccentColor();

      // Likewise above.
      if (!mounted) return;

      if (accentColor != null) {
        debugPrint('dynamic_color: Accent color detected.');
        setState(() {
          _light = ColorScheme.fromSeed(
            seedColor: accentColor,
            brightness: Brightness.light,
          );
          _dark = ColorScheme.fromSeed(
            seedColor: accentColor,
            brightness: Brightness.dark,
          );
        });
        return;
      }
    } on PlatformException {
      debugPrint('dynamic_color: Failed to obtain accent color.');
    }

    debugPrint('dynamic_color: Dynamic color not detected on this device.');
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_light, _dark);
  }
}
