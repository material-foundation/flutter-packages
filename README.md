# google_fonts

NOTE: This package is in Beta. The API is subject to change.

The `google_fonts` package for Flutter allows you to easily use any of the 960 fonts
(and their variants) from [fonts.google.com](https://fonts.google.com/) in your Flutter app.

## Getting Started

![](https://raw.githubusercontent.com/material-components/material-components-flutter-experimental/master/google_fonts/main.gif)

With the `google_fonts` package, `.ttf` or `.otf` files do not need to be stored in your assets folder and mapped in
the pubspec. Instead, they can be fetched once via http at runtime, and cached in the app's file system. This is ideal for development, and can be the preferred behavior for production apps that
are looking to reduce the app bundle size. Still, the app can at any time choose to include the font file in the assets, and the Google Fonts package will prioritize pre-bundled files over http fetching. 
Because of this, the Google Fonts package allows developers to choose between pre-bundling the fonts and loading them over http while using the same API.

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