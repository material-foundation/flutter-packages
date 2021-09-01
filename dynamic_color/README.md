# dynamic_colors

A Flutter plugin to obtain dynamic colors on Android S+ and create harmonized
color schemes.

TODO(guidezpl): link to API docs once published

## Features

TODO(guidezpl): List what your package can do. Maybe include images, gifs, or videos.

## Getting started

`flutter pub add dynamic_colors`

## Usage

Run all examples with
```
cd example
flutter run
```

See this [complete example] for obtaining dynamic colors and creating 
a harmonized color scheme. Essentially, we wrap our `MaterialApp` with a 
[`DynamicColorsBuilder`](#1-dynamiccolorsbuilder), and create:
- a dynamic color scheme that we harmonize with `colorScheme.harmonized()`
- a fallback color scheme

### Advanced
This package includes two ways to obtain dynamic colors.

#### 1. `DynamicColorsBuilder`
A convenience stateful builder widget that provides the dynamic colors
in a [`TonalPalette`][TonalPalette]. This uses
[2.](#2-dynamiccolorsplugingetdynamiccolors) under the hood.
[Example][DynamicColorsBuilder example]

Android S+ | Other device
   --- | ---
<img width="100%" alt="Using dynamic color" src="https://user-images.githubusercontent.com/6655696/131468852-9e79837d-4109-40b8-82d7-3ef5fe8c225e.png" /> | <img width="100%" alt="Not using dynamic color" src="https://user-images.githubusercontent.com/6655696/131468869-180c0cad-80d5-4e5a-8f2a-6518c525b0a7.png" />

#### 2. `DynamicColorsPlugin.getDynamicColors()`
Requests the dynamic colors asynchronously, returning a
[`TonalPalette`][TonalPalette]. The developer is responsible for
obtaining and storing the `TonalPalette`.
[Example][DynamicColorsPlugin.getDynamicColors example]


[TonalPalette]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/lib/tonal_palette.dart
[complete example]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/complete_example.dart
[DynamicColorsBuilder example]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/dynamic_colors_builder_example.dart
[DynamicColorsPlugin.getDynamicColors example]: https://github.com/material-foundation/material-dynamic-color-flutter/tree/main/example/lib/get_dynamic_colors_example.dart
