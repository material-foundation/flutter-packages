# dynamic_colors

A Flutter plugin to obtain dynamic colors on Android S+.

## Features

TODO(guidezpl): List what your package can do. Maybe include images, gifs, or videos.

## Getting started

`flutter pub add dynamic_colors`

## Usage

There are two ways to use this plugin. 

1. `DynamicColorsBuilder`, a convenience stateful builder widget that provides
   the dynamic colors in a [`TonalPalette`](lib/tonal_palette.dart). This uses 
   `2.` under the hood. [Example](example/lib/dynamic_colors_builder_example.dart)
   
   Android S+ | Other device 
    --- | ---
   ![Using dynamic color](https://user-images.githubusercontent.com/6655696/131153023-21ed468c-ea99-406b-937a-7043ab9798d5.png) | ![Not using dynamic color](https://user-images.githubusercontent.com/6655696/131153002-e4c33c66-d806-4fa2-bdb1-2b4bbef87375.png)

2. `DynamicColorsPlugin.getDynamicColors()`, which requests the colors 
   asynchronously, returns the dynamic colors in a 
   [`TonalPalette`](lib/tonal_palette.dart). The developer is responsible for 
   obtaining and storing the `TonalPalette`.
   [Example](example/lib/get_dynamic_colors_example.dart)

The `TonalPalette` object will be `null` on non-Android platforms and 
pre-Android S devices.
