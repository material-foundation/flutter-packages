## 1.4.1

- Expand and improve README
- Add example tests
- Rename `DynamicColorTestingUtils.setMockDynamicColors`'s argument `colorPalette` to `corePalette`

## 1.4.0

- Add support for Windows' accent color ([#43](https://github.com/material-foundation/material-dynamic-color-flutter/pull/43))
  - Rename `DynamicColorPlugin.getControlAccentColor` to `DynamicColorPlugin.getAccentColor`
  - Rename `DynamicColorTestingUtils.setMockDynamicColors`'s argument `controlAccentColor` to `accentColor`

## 1.3.0

- Add support for macOS' control accent color ([#42](https://github.com/material-foundation/material-dynamic-color-flutter/pull/42))
  - Rename `DynamicColorTestingUtils.setMockDynamicColors`'s argument `colors` to `colorPalette`

## 1.2.3

- Tweak pubspec description

## 1.2.2

- Update lower Flutter SDK bound

## 1.2.0

- Improve examples: show how to create dynamic and fallback color schemes, and use harmonization for color schemes and custom colors

## 1.1.2

- Move samples to their own library

## 1.1.1

- Provide sample `CorePalette`s and corresponding `ColorScheme`s to test utils
- Make the extension method which converts a `CorePalette` to a `ColorScheme` public

## 1.1.0

- Qualify builder parameters (`light` => `lightDynamic`, `dark` => `darkDynamic`) for clarity

## 1.0.1

- Polish README and examples

## 1.0.0

- `DynamicColorBuilder`'s `builder` now provides a light and dark `ColorScheme` rather than a `CorePalette`
  - Advanced users can still obtain the palette with `DynamicColorPlugin.getCorePalette()`

## 0.1.1

- Add missing semantic colors to harmonization from updated m3 color scheme

## 0.1.0

- Create `CorePalette` and `TonalPalette` classes
- Create `DynamicColorPlugin` plugin
- Create convenience `DynamicColorBuilder` widget
- Create `ColorHarmonization` and `ColorSchemeHarmonization` extensions
