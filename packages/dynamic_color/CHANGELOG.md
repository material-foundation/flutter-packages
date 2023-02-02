## 1.6.0
### Added
- Add support for `outlineVariant` and `scrim` colors

### Changed
- Update constraint for `material_color_utilities` to `0.2.0`
- Update Flutter constraint
- Make return value of toColorScheme extension method non-nullable ([\#55](https://github.com/material-foundation/material-dynamic-color-flutter/pull/55))

## 1.5.4
### Changed
- Update constraint for Flutter SDK

## 1.5.3
### Changed
- Update constraint for `material_color_utilities`

## 1.5.2
### Changed
- Improve `DynamicColorBuilder` short-circuiting logic if dynamic color is detected
- Tweak debugging messages

## 1.5.1
### Added
- Add support for DWM/Windows Aero's color ([\#50](https://github.com/material-foundation/material-dynamic-color-flutter/pull/50))

## 1.5.0
### Added
- Add support for GTK's accent color on Linux ([\#47](https://github.com/material-foundation/material-dynamic-color-flutter/pull/47))

## 1.4.1
### Added
- Add example tests

### Changed
- Expand and improve README
- Rename `DynamicColorTestingUtils.setMockDynamicColors`'s argument `colorPalette` to `corePalette`

## 1.4.0
### Added
- Add support for Windows' accent color ([\#43](https://github.com/material-foundation/material-dynamic-color-flutter/pull/43))

### Changed
- Rename `DynamicColorPlugin.getControlAccentColor` to `DynamicColorPlugin.getAccentColor`
- Rename `DynamicColorTestingUtils.setMockDynamicColors`'s argument `controlAccentColor` to `accentColor`

## 1.3.0
### Added
- Add support for macOS' control accent color ([\#42](https://github.com/material-foundation/material-dynamic-color-flutter/pull/42))
  - Rename `DynamicColorTestingUtils.setMockDynamicColors`'s argument `colors` to `colorPalette`

## 1.2.3
### Changed
- Tweak pubspec description

## 1.2.2
### Changed
- Update lower Flutter SDK bound

## 1.2.0
### Changed
- Improve examples: show how to create dynamic and fallback color schemes, and use harmonization for color schemes and custom colors

## 1.1.2
### Changed
- Move samples to their own library

## 1.1.1
### Changed
- Provide sample `CorePalette`s and corresponding `ColorScheme`s to test utils
- Make the extension method which converts a `CorePalette` to a `ColorScheme` public

## 1.1.0
### Changed
- Qualify builder parameters (`light` =&gt; `lightDynamic`, `dark` =&gt; `darkDynamic`) for clarity

## 1.0.1
### Changed
- Polish README and examples

## 1.0.0
### Changed
- `DynamicColorBuilder`'s `builder` now provides a light and dark `ColorScheme` rather than a `CorePalette`
  - Advanced users can still obtain the palette with `DynamicColorPlugin.getCorePalette()`

## 0.1.1
### Added
- Add missing semantic colors to harmonization from updated m3 color scheme

## 0.1.0
### Added
- Create `CorePalette` and `TonalPalette` classes
- Create `DynamicColorPlugin` plugin
- Create convenience `DynamicColorBuilder` widget
- Create `ColorHarmonization` and `ColorSchemeHarmonization` extensions
