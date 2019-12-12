# google_fonts

NOTE: This package is in Beta. The API is subject to change.

The `google_fonts` package for Flutter allows you to easily use any of the 960 fonts
(and their variants) from [fonts.google.com](https://fonts.google.com/) in your Flutter app.

## Getting Started

![](https://raw.githubusercontent.com/material-components/material-components-flutter-experimental/master/google_fonts/main.gif)

With the `google_fonts` package, `.ttf` files do not need to be stored in your assets folder and mapped in
the pubspec. Instead, they are fetched once via http at runtime, and cached in the app's file system. This is ideal for development, and can be the preferred behavior for production apps that
are looking to reduce the app bundle size.

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
      body1: GoogleFonts.oswaldTextStyle(textStyle: textTheme.body1),
    ),
  ),
);
```

## What's Next?

In a future release, this package will defer to `.ttf` files you specify in the pubspec before fetching them via http. This means you can get the best of both worlds by having access to all [fonts.google.com](https://fonts.google.com/) fonts and their variants during development, while also ensuring your production app has an optimal offline/slow connection experience.
