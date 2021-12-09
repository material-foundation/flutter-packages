# google_fonts

The `google_fonts` package for Flutter allows you to easily use any of the thousands of fonts
available from [fonts.google.com](https://fonts.google.com/) in your Flutter app.

## Getting Started

![](https://raw.githubusercontent.com/material-foundation/google-fonts-flutter/main/readme_images/main.gif)

With the `google_fonts` package, `.ttf` or `.otf` files do not need to be stored in your assets folder and mapped in
the pubspec. Instead, they can be fetched via HTTP at runtime and cached in the app's file system. This is ideal for development and can be the preferred behaviour for production apps looking to reduce the app bundle size. Still, you may choose to include the font file in the assets, and the Google Fonts package will prioritize pre-bundled files over HTTP fetching. 
Because of this, the Google Fonts package allows developers to choose between pre-bundling the fonts and loading them over HTTP while using the same API. See the [API docs](https://pub.dev/documentation/google_fonts/latest/google_fonts/GoogleFonts/config.html) to disable HTTP fetching.

For example, say you want to use the [Lato](https://fonts.google.com/specimen/Lato) font from Google Fonts in your Flutter app.

First, add the `google_fonts` package to your [pubspec dependencies](https://pub.dev/packages/google_fonts#-installing-tab-).

To import `GoogleFonts`:

```dart
import 'package:google_fonts/google_fonts.dart';
```

To use `GoogleFonts` with the default TextStyle:

```dart
Text(
  'This is Google Fonts',
  style: GoogleFonts.lato(),
),
```

Or, if you want to load the font dynamically:

```dart
Text(
  'This is Google Fonts',
  style: GoogleFonts.getFont('Lato'),
),
```

To use `GoogleFonts` with an existing `TextStyle`:

```dart
Text(
  'This is Google Fonts',
  style: GoogleFonts.lato(
    textStyle: TextStyle(color: Colors.blue, letterSpacing: .5),
  ),
),
```

or

```dart
Text(
  'This is Google Fonts',
  style: GoogleFonts.lato(textStyle: Theme.of(context).textTheme.headline4),
),
```

To override the `fontSize`, `fontWeight`, or `fontStyle`:

```dart
Text(
  'This is Google Fonts',
  style: GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.headline4,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  ),
),
```

You can also use `GoogleFonts.latoTextTheme()` to make or modify an entire text theme to use the "Lato" font.

```dart
MaterialApp(
  theme: ThemeData(
    textTheme: GoogleFonts.latoTextTheme(
      Theme.of(context).textTheme, // If this is not set, then ThemeData.light().textTheme is used.
    ),
  ),
);
```

Or, if you want a `TextTheme` where a couple of styles should use a different font:

```dart
final textTheme = Theme.of(context).textTheme;

MaterialApp(
  theme: ThemeData(
    textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
      body1: GoogleFonts.oswald(textStyle: textTheme.body1),
    ),
  ),
);
```

Please note that for macOS network fetching, the following must be present in the relevant .entitlements file:

```
<key>com.apple.security.network.client</key>
<true/>
```

### Bundling font files in your application's assets

The `google_fonts` package will automatically use matching font files in your `pubspec.yaml`'s
`assets` (rather than fetching them at runtime via HTTP). Once you've settled on the fonts
you want to use:

1. Download the font files from [https://fonts.google.com](https://fonts.google.com).
   You only need to download the weights and styles you are using for any given family.
   Italic styles will include `Italic` in the filename. Font weights map to file names as follows:

```dart
{
  FontWeight.w100: 'Thin',
  FontWeight.w200: 'ExtraLight',
  FontWeight.w300: 'Light',
  FontWeight.w400: 'Regular',
  FontWeight.w500: 'Medium',
  FontWeight.w600: 'SemiBold',
  FontWeight.w700: 'Bold',
  FontWeight.w800: 'ExtraBold',
  FontWeight.w900: 'Black',
}
```

2. Move those fonts to a top-level app directory (e.g. `google_fonts`).

![](https://raw.githubusercontent.com/material-foundation/google-fonts-flutter/main/readme_images/google_fonts_folder.png)

3. Ensure that you have listed the folder (e.g. `google_fonts/`) in your `pubspec.yaml` under `assets`.

![](https://raw.githubusercontent.com/material-foundation/google-fonts-flutter/main/readme_images/google_fonts_pubspec_assets.png)

Note: Since these files are listed as assets, there is no need to list them in the `fonts` section
of the `pubspec.yaml`. This can be done because the files are consistently named from the Google Fonts API
(so be sure not to rename them!)

### Licensing Fonts

The fonts on [fonts.google.com](https://fonts.google.com/) include license files for each font. For
example, the [Lato](https://fonts.google.com/specimen/Lato) font comes with an `OFL.txt` file.

Once you've decided on the fonts you want in your published app, you should add the appropriate
licenses to your flutter app's [LicenseRegistry](https://api.flutter.dev/flutter/foundation/LicenseRegistry-class.html).

For example:

```dart
void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(...);
}
```
