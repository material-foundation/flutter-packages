## [2.1.0] - 2021-05-14

* Added the latest fonts from fonts.google.com.

## [2.0.0] - 2021-02-26

* Migrated the main library to null safety.
* Require Dart 2.12 or greater.

## [1.1.2] - 2021-01-25

* Bump dependency constraints for null safety.

## [1.1.1] - 2020-10-02

* Use conditional imports to separate out web from destkop + mobile file_io implementations.

## [1.1.0] - 2020-05-11

* Increase the flutter SDK dependency to version `1.17` (latest stable). This is needed for updated
  text theme names and a fix in the engine.
* Update text theme names.

## [1.0.0] - 2020-04-22

* Removed beta notice from README.
* Public API is now defined, as per [semantic versioning guidelines](https://semver.org/spec/v2.0.0-rc.1.html).

## [0.7.0] - 2020-04-22

* Added the following variable fonts:
  * Bellota
  * Bellota Text
  * Comic Neue
  * Crimson Pro
  * Fira Code
  * Gotu
  * Hepta Slab
  * Inria Sans
  * Inter
  * Literata
  * Manrope
  * Markazi Text
  * Public Sans
  * Sen
  * Spartan
  * Viaoda Libre

## [0.6.2] - 2020-04-17

* Clean up code.

## [0.6.1] - 2020-04-17

* Memoize asset manifest.

## [0.6.0] - 2020-04-16

* Rename `config.allowHttp` to `config.allowRuntimeFetching`.

## [0.5.0] - 2020-04-14

* Use more accurate naming algorithm for `GoogleFonts.foo` and `GoogleFonts.fooTextTheme`.

## [0.4.3] - 2020-04-14

* Add `GoogleFonts.getTextTheme(...)` method for dynamically getting a text theme from a font name.

## [0.4.2] - 2020-04-14

* Change loadFontIfNecessary to only follow through once per unique family when called in parallel.

## [0.4.1] - 2020-04-13

* Update README to include instructions for how to include licenses for fonts.

## [0.4.0] - 2020-03-20

* Added ability to load fonts dynamically through `getFont` method.
* Added `asMap` method which returns a map with font family names mapped to methods.

## [0.3.10] - 2020-03-18

Update Fonts API url in generator to add in missing fonts.

## [0.3.9] - 2020-02-13

* Fix path_provider usage for web

## [0.3.8] - 2020-02-10

* Add byte length and checksum verification for font files downloaded.

## [0.3.7] - 2020-02-03

* Fix asset font loading bug
* Update asset font README instructions

## [0.3.6] - 2020-01-31

* Add a config to the `GoogleFonts` class with an `allowHttp` option.

## [0.3.5] - 2020-01-23

* Update generator to get most up-to-date urls from fonts.google.com.
* Add `CONTRIBUTING.md`.

## [0.3.4] - 2020-01-23

* Store downloaded font files in device's support directory instead of documents directory.

## [0.3.3] - 2020-01-22

* Update font URLs to https to properly support web.

## [0.3.2] - 2019-01-07

* README image path fixes.

## [0.3.1] - 2019-01-07

* README fixes.

## [0.3.0] - 2019-01-07

* Added dartdocs to every public method in the google fonts package.

* Added the ability to include font files in pubspec assets (see README).

## [0.2.0] - 2019-12-12

* Updated to include all fonts currently on fonts.google.com.

## [0.1.1] - 2019-12-10

### Generated method names changed back to pre 0.1.0 (breaking change).

For example,

`GoogleFonts.latoTextStyle(...)` is now `GoogleFonts.lato(...)`.

### Text theme parameters are now optional positional parameters (breaking change).

For example,

`GoogleFonts.latoTextTheme(textTheme: TextTheme(...))` is now `GoogleFonts.latoTextTheme(TextTheme(...))`.


## [0.1.0] - 2019-12-06

### Generated method names changed (breaking change).

For example,

`GoogleFonts.lato(...)` is now `GoogleFonts.latoTextStyle(...)`.

### Text theme support

Every font family now _also_ has a `TextTheme` method.

For example, the `Lato` font now has `GoogleFonts.latoTextStyle()` and `GoogleFonts.latoTextTheme()`.

See README for more examples.

### Other cleanups

Refactored implementation, updated READMEs, and usage docs.


## [0.0.8] - 2019-12-04

Internal refactor and added tests.

## [0.0.7] - 2019-12-04

BETA support for Flutter web.

## [0.0.6] - 2019-12-04

Minor updates to README.

## [0.0.5] - 2019-11-20

Mark as experimental in more places.

## [0.0.4] - 2019-11-20

Add pubspec instructions to README.

## [0.0.3] - 2019-11-20

Fix homepage and main gif.

## [0.0.2] - 2019-11-20

Update README with import instructions.

## [0.0.1] - 2019-11-15

The initial release supports all 960 fonts and variants from fonts.google.com.

ttf files are downloaded via http on demand, and saved to local disk so that they can be loaded
without making another http request for future font requests. Fonts are loaded asynchronously
through the font loader and Text widgets that use them are refreshed when they are ready.
