# dynamic_color

[![ci](https://github.com/material-foundation/material-dynamic-color-flutter/actions/workflows/test.yml/badge.svg)](https://github.com/material-foundation/material-dynamic-color-flutter/actions/workflows/test.yml)
[![pub package](https://img.shields.io/pub/v/dynamic_color.svg)](https://pub.dev/packages/dynamic_color)

A Flutter plugin to obtain dynamic colors on Android S+ and create harmonized
color schemes.

TODO(guidezpl): link to API docs once published

## Features

### Builder widget

For convenience, this package includes `DynamicColorBuilder`, a stateful widget
that provides the device's dynamic colors in a [`CorePalette`][corepalette].

### Plugin

Under the hood, `DynamicColorBuilder` uses a plugin to talk to the Android OS.

### Color and color scheme harmonization

Color harmonization solves the problem: "How do we ensure any particular
Reserved color (i.e. semantic or brand color) look good next to a
user's dynamically-generated color?"

This package provides two extension methods, `Color.harmonizeWith()` and
`ColorScheme.harmonized()` to accomplish this.

`Color.harmonizeWith()` shift the hue of the color towards the passed in 
color, typically `colorScheme.primary`. This leaves the color recognizable
while harmonizing it.

`ColorScheme.harmonized()` does the same thing, for all semantic colors.
See [harmonization.dart] for more.

## Getting started

`flutter pub add dynamic_color`

```dart
import package:dynamic_color/dynamic_color.dart;
```

## Usage

See this [complete example] for obtaining dynamic colors and creating
a harmonized color scheme. Essentially, we wrap our `MaterialApp` with a
`DynamicColorBuilder`, and create:

- a dynamic color scheme that we harmonize
- a fallback color scheme

Run all examples with

```
cd example
flutter run
```

<details> 
<Summary>Advanced</Summary>

[`DynamicColorBuilder` example][dynamiccolorbuilder example]

| Android S+                                                                                                                                                | Other device                                                                                                                                                  |
| --------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <img width="100%" alt="Using dynamic color" src="https://user-images.githubusercontent.com/6655696/135142179-ce080344-cd20-4776-b9f0-b1e12e1662e1.png" /> | <img width="100%" alt="Not using dynamic color" src="https://user-images.githubusercontent.com/6655696/135142176-5bba6a1a-59e9-469c-b61f-327ebd274825.png" /> |

Under the hood, `DynamicColorBuilder` uses `DynamicColorPlugin.getCorePalette()`
to obtain the [`CorePalette`][corepalette] asynchronously. Unlike with
`DynamicColorBuilder`, the developer is responsible for obtaining and
storing the [`CorePalette`][corepalette].
[Example][dynamiccolorplugin.getcorepalette example]

</details>

[corepalette]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/lib/src/core_palette.dart
[complete example]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/complete_example.dart
[dynamiccolorbuilder example]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/dynamic_color_builder_example.dart
[dynamiccolorplugin.getcorepalette example]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/get_core_palette_example.dart
[harmonization.dart]: https://github.com/material-foundation/material-dynamic-color-flutter/blob/main/lib/src/harmonization.dart
