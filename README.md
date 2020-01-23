# google_fonts

NOTE: This package is in Beta. The API is subject to change.

The `google_fonts` package for Flutter allows you to easily use any of the 977 fonts
(and their variants) from [fonts.google.com](https://fonts.google.com/) in your Flutter app.

## Getting Started

![](https://raw.githubusercontent.com/material-foundation/google-fonts-flutter/master/readme_images/main.gif)

With the `google_fonts` package, `.ttf` or `.otf` files do not need to be stored in your assets folder and mapped in
the pubspec. Instead, they can be fetched once via http at runtime, and cached in the app's file system. This is ideal for development, and can be the preferred behavior for production apps that
are looking to reduce the app bundle size. Still, you may at any time choose to include the font file in the assets, and the Google Fonts package will prioritize pre-bundled files over http fetching. 
Because of this, the Google Fonts package allows developers to choose between pre-bundling the fonts and loading them over http, while using the same API.

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
  style: GoogleFonts.lato(textStyle: Theme.of(context).textTheme.display1),
),
```

To override the `fontSize`, `fontWeight`, or `fontStyle`:

```dart
Text(
  'This is Google Fonts',
  style: GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.display1,
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
      Theme.of(context).textTheme,
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

### Choosing to include a font without having to http fetch it

If you want the Google Fonts package to use font files that you have included in your pubspec's
assets (rather than fetching at runtime via http), first download the font files from 
[https://fonts.google.com](https://fonts.google.com). Then, create a folder at the top level of 
your app directory named `google_fonts`, and copy the font files that you want to be used into that folder.

![](https://raw.githubusercontent.com/material-foundation/google-fonts-flutter/master/readme_images/google_fonts_folder.png)

You only need to copy the files in for the font weight and font styles that you are using for any
given family. Italic styles will include `Italic` in the filename, and the font weights map to 
filenames as follows:

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

Finally, make sure you have listed the `google_fonts` folder in your `pubspec.yaml`.

![](https://raw.githubusercontent.com/material-foundation/google-fonts-flutter/master/readme_images/google_fonts_pubspec_assets.png)

Note: Since these files are listed as assets, there is no need to list them in the fonts section
of the `pubspec.yaml`. This can be done because the files are consistently named from the Google Fonts API
(so be sure not to rename them!)