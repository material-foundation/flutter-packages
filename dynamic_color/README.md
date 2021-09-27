# dynamic_color

[![ci](https://github.com/material-foundation/material-dynamic-color-flutter/actions/workflows/test.yml/badge.svg)](https://github.com/material-foundation/material-dynamic-color-flutter/actions/workflows/test.yml)
[![pub package](https://img.shields.io/pub/v/dynamic_color.svg)](https://pub.dev/packages/dynamic_color)

A Flutter plugin to obtain dynamic colors on Android S+ and create harmonized
color schemes.

TODO(guidezpl): link to API docs once published

## Features

TODO(guidezpl): List what your package can do. Maybe include images, gifs, or videos.

## Getting started

`flutter pub add dynamic_color`

```dart
import package:dynamic_color/dynamic_color.dart;
```

## Usage

See this [complete example] for obtaining dynamic colors and creating
a harmonized color scheme. Essentially, we wrap our `MaterialApp` with a
`DynamicColorBuilder`, and create:

- a dynamic color scheme that we harmonize with `colorScheme.harmonized()`
- a fallback color scheme

Run all examples with

```
cd example
flutter run
```

<details> 
<Summary>Advanced</Summary>

`DynamicColorBuilder` is a stateful widget that provides the device's
dynamic colors in a [`CorePalette`][corepalette]. [Example][dynamiccolorbuilder example]

| Android S+                                                                                                                                                | Other device                                                                                                                                                  |
| --------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <img width="100%" alt="Using dynamic color" src="https://user-images.githubusercontent.com/6655696/131468852-9e79837d-4109-40b8-82d7-3ef5fe8c225e.png" /> | <img width="100%" alt="Not using dynamic color" src="https://user-images.githubusercontent.com/6655696/131468869-180c0cad-80d5-4e5a-8f2a-6518c525b0a7.png" /> |

Under the hood, `DynamicColorBuilder` uses `DynamicColorPlugin.getCorePalette()`
to obtain the [`CorePalette`][corepalette] asynchronously. Unlike with
`DynamicColorBuilder`, the developer is responsible for obtaining and
storing the [`CorePalette`][corepalette].
[Example][dynamiccolorplugin.getcorepalette example]

</details>

[corepalette]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/lib/tonal_palette.dart
[complete example]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/complete_example.dart
[dynamiccolorbuilder example]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/dynamic_color_builder_example.dart
[dynamiccolorplugin.getcorepalette example]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/get_core_palette_example.dart
