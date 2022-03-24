## 1.2.0

- Improve examples: show how to create dynamic and fallback color schemes, and use harmonization for color schemes and custom colors

## 1.1.2

- Move samples to their own library

## 1.1.1

- Provide sample [CorePalette]s and corresponding [ColorScheme]s to test utils
- Make the extension method which converts a [CorePalette] to a [ColorScheme] public

## 1.1.0

- Qualify builder parameters (light => lightDynamic, dark => darkDynamic) for clarity

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
