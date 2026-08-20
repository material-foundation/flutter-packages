import 'package:dynamic_color/src/dynamic_color_scheme_factory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

import 'dynamic_color_plugin.dart';

/// A stateful builder widget that provides a light and dark [ColorScheme].
///
/// Android: the [ColorScheme]s are constructed from the [TonalPalette]s
/// provided by the Android OS.
///
/// macOS, Windows and Linux: the [ColorScheme]s are constructed from the accent
/// [Color] provided by the system.
///
/// See also:
///
///  * [DynamicColorBuilder example](https://github.com/material-foundation/flutter-packages/tree/main/packages/dynamic_color/example/lib/dynamic_color_builder_example.dart)
///  * [Complete example](https://github.com/material-foundation/flutter-packages/tree/main/packages/dynamic_color/example/lib/complete_example.dart)
///    for obtaining dynamic colors and creating a harmonized color scheme
///  * [DynamicColorPlugin.getTonalPalettes] for requesting the [TonalPalette]s
///    directly, asynchronously.
///  * [DynamicColorPlugin.getAccentColor] for requesting the accent [Color]
///    [ColorScheme] directly, asynchronously.
class DynamicColorBuilder extends StatefulWidget {
  const DynamicColorBuilder(
      {Key? key,
      this.themeVariant = DynamicSchemeVariant.tonalSpot,
      this.builder,
      this.customBuilder})
      : assert((builder == null) ^ (customBuilder == null),
            'Either [builder] or [customBuilder] needs to be defined.'),
        super(key: key);

  /// Tweaks how the dynamic colors are rendered.
  ///
  /// Will not work strictly as intended using [DynamicSchemeVariant.fidelity]
  /// on Android. Since we do not have access to the source color coming from
  /// the wallpaper, we instead use the `primary` color as a replacement, colors
  /// may be different than from the spec.
  ///
  /// On Android, the user may have defined their own variant to tweak the
  /// colors on their device, this parameter is not exposed to app developers,
  /// meaning that the user may see different colors in your application than in
  /// native apps from the OS.
  final DynamicSchemeVariant themeVariant;

  /// Builds the child widget of this widget, providing a light and dark [ColorScheme].
  ///
  /// The [ColorScheme]s will be null if dynamic color is not supported on the
  /// platform, or if the OS has yet to respond.
  @Deprecated('Use [DynamicColorBuilder.customBuilder] instead.')
  final Widget Function(
    ColorScheme? lightDynamic,
    ColorScheme? darkDynamic,
  )? builder;

  /// Builds the child widget of this widget, providing a factory for different
  /// [ColorScheme]s.
  ///
  /// The [DynamicSchemeFactory] will be null if dynamic color is not supported
  /// on the platform, or if the OS has yet to respond.
  final Widget Function(
    DynamicSchemeFactory? schemes,
  )? customBuilder;

  @override
  DynamicColorBuilderState createState() => DynamicColorBuilderState();
}

class DynamicColorBuilderState extends State<DynamicColorBuilder> {
  DynamicSchemeFactory? _factory;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      List<TonalPalette>? tonalPalettes =
          await DynamicColorPlugin.getTonalPalettes();

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      if (tonalPalettes != null) {
        if (kDebugMode) {
          debugPrint('dynamic_color: Tonal palettes detected.');
        }
        setState(() {
          _factory = ColorPaletteSchemeFactory(
              tonalPalettes: tonalPalettes, variant: widget.themeVariant);
        });
        return;
      }
    } on PlatformException {
      if (kDebugMode) {
        debugPrint('dynamic_color: Failed to obtain core palette.');
      }
    }

    try {
      final Color? accentColor = await DynamicColorPlugin.getAccentColor();

      // Likewise above.
      if (!mounted) return;

      if (accentColor != null) {
        if (kDebugMode) {
          debugPrint('dynamic_color: Accent color detected.');
        }
        setState(() {
          _factory = AccentColorSchemeFactory(
              color: accentColor, variant: widget.themeVariant);
        });
        return;
      }
    } on PlatformException {
      if (kDebugMode) {
        debugPrint('dynamic_color: Failed to obtain accent color.');
      }
    }
    if (kDebugMode) {
      debugPrint('dynamic_color: Dynamic color not detected on this device.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // We know exactly one of the builders is defined from the widget
    // constructor.
    return widget.customBuilder?.call(_factory) ??
        widget.builder!.call(_factory?.light, _factory?.dark);
  }
}
