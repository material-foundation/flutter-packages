import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

import 'dynamic_color_plugin.dart';

/// A stateful builder widget that provides a light and dark [ColorScheme].
///
/// The [ColorScheme]s are constructed from the [CorePalette] provided by the
/// Android OS.
///
/// See also:
///
///  * [DynamicColorBuilder example](https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/dynamic_color_builder_example.dart)
///  * [Complete example](https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/complete_example.dart)
///    for obtaining dynamic colors and creating a harmonized color scheme
///  * [DynamicColorPlugin.getCorePalette] for requesting the [CorePalette]
///    directly, asynchronously.
class DynamicColorBuilder extends StatefulWidget {
  const DynamicColorBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  /// Builds the child widget of this widget, providing a light and dark [ColorScheme].
  ///
  /// The [ColorScheme]s will be null if dynamic color is not supported (i.e on
  /// non-Android platforms and pre-Android S devices), or if the colors
  /// have yet to be obtained.
  final Widget Function(
    ColorScheme? lightDynamic,
    ColorScheme? darkDynamic,
  ) builder;

  @override
  _DynamicColorBuilderState createState() => _DynamicColorBuilderState();
}

class _DynamicColorBuilderState extends State<DynamicColorBuilder> {
  ColorScheme? _light;
  ColorScheme? _dark;

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
      _light = corePalette?.toColorScheme();
      _dark = corePalette?.toColorScheme(brightness: Brightness.dark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_light, _dark);
  }
}

extension on CorePalette {
  /// Create a [ColorScheme] from the given `palette` obtained from the Android OS.
  ColorScheme? toColorScheme({
    Brightness brightness = Brightness.light,
  }) {
    final Scheme scheme;

    switch (brightness) {
      case Brightness.light:
        scheme = Scheme.lightFromCorePalette(this);
        break;
      case Brightness.dark:
        scheme = Scheme.darkFromCorePalette(this);
        break;
    }
    return ColorScheme(
      primary: Color(scheme.primary),
      onPrimary: Color(scheme.onPrimary),
      primaryContainer: Color(scheme.primaryContainer),
      onPrimaryContainer: Color(scheme.onPrimaryContainer),
      secondary: Color(scheme.secondary),
      onSecondary: Color(scheme.onSecondary),
      secondaryContainer: Color(scheme.secondaryContainer),
      onSecondaryContainer: Color(scheme.onSecondaryContainer),
      tertiary: Color(scheme.tertiary),
      onTertiary: Color(scheme.onTertiary),
      tertiaryContainer: Color(scheme.tertiaryContainer),
      onTertiaryContainer: Color(scheme.onTertiaryContainer),
      error: Color(scheme.error),
      onError: Color(scheme.onError),
      errorContainer: Color(scheme.errorContainer),
      onErrorContainer: Color(scheme.onErrorContainer),
      outline: Color(scheme.outline),
      background: Color(scheme.background),
      onBackground: Color(scheme.onBackground),
      surface: Color(scheme.surface),
      onSurface: Color(scheme.onSurface),
      surfaceVariant: Color(scheme.surfaceVariant),
      onSurfaceVariant: Color(scheme.onSurfaceVariant),
      inverseSurface: Color(scheme.inverseSurface),
      onInverseSurface: Color(scheme.inverseOnSurface),
      inversePrimary: Color(scheme.inversePrimary),
      shadow: Color(scheme.shadow),
      brightness: brightness,
    );
  }
}
