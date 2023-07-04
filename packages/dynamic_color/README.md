# dynamic_color

[![pub package](https://img.shields.io/pub/v/dynamic_color.svg)](https://pub.dev/packages/dynamic_color)

A Flutter package to create Material color schemes based on a platform's implementation of dynamic color. Currently supported platforms are:

- Android S+: user [wallpaper color](https://m3.material.io/styles/color/dynamic-color/user-generated-color#35bc06c5-35d9-4559-9f5d-07ea734cbcb1)
    - For color schemes from [content color](https://m3.material.io/styles/color/dynamic-color/user-generated-color#8af550b9-a19e-4e9f-bb0a-7f611fed5d0f), use [`ColorScheme.fromImageProvider`](https://api.flutter.dev/flutter/material/ColorScheme/fromImageProvider.html)
- Linux: GTK+ theme's `@theme_selected_bg_color`
- macOS: [app accent color](https://developer.apple.com/design/human-interface-guidelines/macos/overview/whats-new-in-macos/#app-accent-colors)
- Windows: [accent color](https://docs.microsoft.com/en-us/windows/apps/design/style/color#accent-color) or [window/glass color](https://web.archive.org/web/20080812195923/http://www.microsoft.com/windows/windows-vista/features/aero.aspx?tabid=2&catid=4)

This package also supports color and color scheme harmonization.

## Getting started

```bash
flutter pub add dynamic_color
```

```dart
import 'package:dynamic_color/dynamic_color.dart';
```

## Features

### Builder widget

`DynamicColorBuilder` is a stateful widget
that provides the device's dynamic colors in a light and dark `ColorScheme`.

```dart
DynamicColorBuilder(
  builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    return ...;
  }
),
```

### Plugin

Under the hood, `DynamicColorBuilder` uses a plugin to talk to the OS.

### Color and color scheme harmonization

Harmonization makes adding and introducing new colors to your app more seamless by automatically shifting hue and chroma slightly so that a product's colors feel more cohesive with user colors.

This package provides two extension methods to accomplish this:

```dart
Color color = Colors.red;
// Shift's [color]'s hue towards the (dynamic) color scheme's primary color. This leaves the color recognizable while harmonizing it with a user's dynamic color.
harmonizedColor = color.harmonizeWith(colorScheme.primary);

// Does the same thing, for ColorScheme built-in semantic colors
harmonizedColorScheme = colorScheme.harmonized();
```

See [harmonization.dart] for details. Learn more about [custom colors and harmonization](https://m3.material.io/styles/color/the-color-system/custom-colors) on the Material 3 site.

## Examples

See [example/lib/complete_example.dart][complete example] for obtaining dynamic colors, creating
harmonized color schemes, and harmonizing custom colors.

See [example/lib/accent_color.dart][accent color example] for obtaining the accent color on desktop.

<a href="https://material-foundation.github.io/flutter-packages/dynamic_color">
<img src="https://user-images.githubusercontent.com/6655696/152188934-35e58f5c-2a3c-41af-8d49-faabb1701dcc.png" width="400" /> </a>

All examples are part of this [example app] ([source][example app source]). To run the example app:

```
cd example
flutter run
```

## Testing

```dart
import 'package:dynamic_color/test_utils.dart';
import 'package:dynamic_color/samples.dart';

void main() {
  // Reset for every test
  setUp(() => DynamicColorTestingUtils.setMockDynamicColors());

  testWidgets('Verify dynamic core palette is used ',
      (WidgetTester tester) async {
    DynamicColorTestingUtils.setMockDynamicColors(
      corePalette: SampleCorePalettes.green,
    );

    // ...
});
```

See [example/test/widget_test.dart](https://github.com/material-foundation/flutter-packages/blob/main/packages/dynamic_color/example/test/widget_test.dart) for an example.

## Development

The [example app] is hosted via GitHub pages. To update it:

```
cd example
flutter build web
```

[complete example]: https://github.com/material-foundation/flutter-packages/tree/main/packages/dynamic_color/example/lib/complete_example.dart
[dynamiccolorbuilder example]: https://github.com/material-foundation/flutter-packages/tree/main/packages/dynamic_color/example/lib/dynamic_color_builder_example.dart
[dynamiccolorplugin.getcorepalette example]: https://github.com/material-foundation/flutter-packages/tree/main/packages/dynamic_color/example/lib/get_core_palette_example.dart
[example app source]: https://github.com/material-foundation/flutter-packages/tree/main/packages/dynamic_color/example/lib/
[harmonization.dart]: https://github.com/material-foundation/flutter-packages/blob/main/packages/dynamic_color/lib/src/harmonization.dart
[example app]: https://material-foundation.github.io/flutter-packages/dynamic_color
[accent color example]: https://github.com/material-foundation/flutter-packages/blob/main/packages/dynamic_color/example/lib/accent_color.dart
