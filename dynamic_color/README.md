# dynamic_color

[![pub package](https://img.shields.io/pub/v/dynamic_color.svg)](https://pub.dev/packages/dynamic_color)

A Flutter package to obtain dynamic colors on Android S+ and create harmonized color schemes.

Learn more about [dynamic color](https://m3.material.io/styles/color/dynamic-color/overview), [custom colors and harmonization](https://m3.material.io/styles/color/the-color-system/custom-colors) on the Material 3 site.

## Features

### Builder widget

For convenience, this package includes `DynamicColorBuilder`, a stateful widget
that provides the device's dynamic colors in a light and dark `ColorScheme`.

### Plugin

Under the hood, `DynamicColorBuilder` uses a plugin to talk to the Android OS.

### Color and color scheme harmonization

How do we ensure any particular color (i.e. semantic/custom color)
looks good next to a user's dynamically-generated color?

This package provides two extension methods, `Color.harmonizeWith()` and
`ColorScheme.harmonized()` to accomplish this.

`Color.harmonizeWith()` shift the hue of the color towards the passed in
color, typically `colorScheme.primary`. This leaves the color recognizable
while harmonizing it.

`ColorScheme.harmonized()` does the same thing, for `ColorScheme`'s
built-in semantic colors. See [harmonization.dart] for more.

## Getting started

`flutter pub add dynamic_color`

```dart
import 'package:dynamic_color/dynamic_color.dart';
```

## Usage

See this [complete example] for obtaining dynamic colors, creating
harmonized color schemes, and harmonizing custom colors.

<a href="https://material-foundation.github.io/material-dynamic-color-flutter/example/build/web/">
<img src="https://user-images.githubusercontent.com/6655696/152188934-35e58f5c-2a3c-41af-8d49-faabb1701dcc.png" width="400" /> </a>

All [examples] are [hosted on GitHub] and can be run with:

```
cd example
flutter run
```

## Development

The [hosted examples][hosted on github] can be updated with:

```
cd example
flutter build web
```

[complete example]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/complete_example.dart
[dynamiccolorbuilder example]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/dynamic_color_builder_example.dart
[dynamiccolorplugin.getcorepalette example]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/get_core_palette_example.dart
[examples]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/
[harmonization.dart]: https://github.com/material-foundation/material-dynamic-color-flutter/blob/main/lib/src/harmonization.dart
[hosted on github]: https://material-foundation.github.io/material-dynamic-color-flutter/example/build/web/
