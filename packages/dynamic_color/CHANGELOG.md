## 1.7.0 - 2024-03-01
### Changed
- Update `material_color_utilities` to `0.8.0`

## 1.6.9 - 2023-12-16
### Changed
- Use `DynamicColors.isDynamicColorAvailable` from `com.google.android.material:material` to verify if dynamic colors are available on Android

## 1.6.8 - 2023-10-17
### Changed
- Broaden constraint for `material_color_utilities` to support it until its `1.0.0` release

## 1.6.7 - 2023-09-15
### Fixed
- Upgraded dependencies

## 1.6.6 - 2023-07-04
### Changed
- Improved documentation for content-based color schemes

## 1.6.5 - 2023-05-15
### Changed
- Broaden constraint for `material_color_utilities` to support multiple Flutter SDK versions

## 1.6.4 - 2023-05-05
### Changed
- Update constraint for `material_color_utilities` to `0.5.0`

## 1.6.3 - 2023-04-04
### Changed
- Update constraint for `material_color_utilities` to `0.3.0`

## 1.6.2 - 2023-02-03
### Added
- Added screenshots

## 1.6.1 - 2023-02-03
### Changed
- Update pubspec `repository`

## 1.6.0 - 2023-01-31
### Added
- Add support for `outlineVariant` and `scrim` colors

### Changed
- Update constraint for `material_color_utilities` to `0.2.0`
- Update Flutter constraint
- Make return value of toColorScheme extension method non-nullable ([\#55](https://github.com/material-foundation/material-dynamic-color-flutter/pull/55))

## 1.5.4 - 2022-09-02
### Changed
- Update constraint for Flutter SDK

## 1.5.3 - 2022-08-09
### Changed
- Update constraint for `material_color_utilities`

## 1.5.2 - 2022-08-02
### Added
- Add support for DWM/Windows Aero's color ([\#50](https://github.com/material-foundation/material-dynamic-color-flutter/pull/50))
- Add support for GTK's accent color on Linux ([\#47](https://github.com/material-foundation/material-dynamic-color-flutter/pull/47))
- Add example tests

### Changed
- Expand and improve README
- Rename `DynamicColorTestingUtils.setMockDynamicColors`'s argument `colorPalette` to `corePalette`
- Improve `DynamicColorBuilder` short-circuiting logic if dynamic color is detected
- Tweak debugging messages

## 1.4.0 - 2022-05-31
### Added
- Add support for Windows' accent color ([\#43](https://github.com/material-foundation/material-dynamic-color-flutter/pull/43))

### Changed
- Rename `DynamicColorPlugin.getControlAccentColor` to `DynamicColorPlugin.getAccentColor`
- Rename `DynamicColorTestingUtils.setMockDynamicColors`'s argument `controlAccentColor` to `accentColor`

## 1.3.0 - 2022-05-25
### Added
- Add support for macOS' control accent color ([\#42](https://github.com/material-foundation/material-dynamic-color-flutter/pull/42))
  - Rename `DynamicColorTestingUtils.setMockDynamicColors`'s argument `colors` to `colorPalette`

## 1.2.3 - 2022-05-23
### Changed
- Tweak pubspec description

## 1.2.2 - 2022-04-25
### Changed
- Update lower Flutter SDK bound

## 1.2.0 - 2022-03-24
### Changed
- Improve examples: show how to create dynamic and fallback color schemes, and use harmonization for color schemes and custom colors

## 1.1.2 - 2022-02-15
### Changed
- Move samples to their own library

## 1.1.1 - 2022-02-14
### Changed
- Provide sample `CorePalette`s and corresponding `ColorScheme`s to test utils
- Make the extension method which converts a `CorePalette` to a `ColorScheme` public

## 1.1.0 - 2022-02-08
### Changed
- Qualify builder parameters (`light` => `lightDynamic`, `dark` => `darkDynamic`) for clarity

## 1.0.1 - 2022-02-02
### Changed
- Polish README and examples

## 1.0.0 - 2022-02-02
### Added
- Add missing semantic colors to harmonization from updated m3 color scheme

### Changed
- `DynamicColorBuilder`'s `builder` now provides a light and dark `ColorScheme` rather than a `CorePalette`
  - Advanced users can still obtain the palette with `DynamicColorPlugin.getCorePalette()`

## 0.1.0 - 2021-10-29
### Added
- Create `CorePalette` and `TonalPalette` classes
- Create `DynamicColorPlugin` plugin
- Create convenience `DynamicColorBuilder` widget
- Create `ColorHarmonization` and `ColorSchemeHarmonization` extensions
