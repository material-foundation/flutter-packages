import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/src/google_fonts_base.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

main() {
  tearDown(() {
    clearCache();
  });

  testWidgets('Text style with a direct match is used', (tester) async {
    final inputTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    );

    final outputTextStyle =
        GoogleFonts.robotoTextStyle(textStyle: inputTextStyle);

    expect(outputTextStyle.fontFamily, equals('Roboto_regular'));
  });

  testWidgets('Text style with an italics direct match is used',
      (tester) async {
    final inputTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
    );

    final outputTextStyle =
        GoogleFonts.robotoTextStyle(textStyle: inputTextStyle);

    expect(outputTextStyle.fontFamily, equals('Roboto_italic'));
  });

  testWidgets('Text style with no direct match picks closest font weight match',
      (tester) async {
    final inputTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    );

    final outputTextStyle =
        GoogleFonts.robotoTextStyle(textStyle: inputTextStyle);

    expect(outputTextStyle.fontFamily, equals('Roboto_500'));
  });

  testWidgets('Italic text style with no direct match picks closest match',
      (tester) async {
    final inputTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic,
    );

    final outputTextStyle =
        GoogleFonts.robotoTextStyle(textStyle: inputTextStyle);

    expect(outputTextStyle.fontFamily, equals('Roboto_500italic'));
  });

  testWidgets('Text style prefers matching italics to closer weight',
      (tester) async {
    // Cardo has 400regular, 400italic, and 700 regular. Even though 700 is
    // closer in weight, when we ask for 600italic, it will give us 400 italic
    // font family.
    final inputTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic,
    );

    final outputTextStyle =
        GoogleFonts.cardoTextStyle(textStyle: inputTextStyle);

    expect(outputTextStyle.fontFamily, equals('Cardo_italic'));
  });

  testWidgets('Font weight and font style params are preferred',
      (tester) async {
    final inputTextStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic,
    );

    final outputTextStyle = GoogleFonts.cardoTextStyle(
      textStyle: inputTextStyle,
      fontWeight: FontWeight.w200,
      fontStyle: FontStyle.normal,
    );

    expect(outputTextStyle.fontWeight, equals(FontWeight.w200));
    expect(outputTextStyle.fontStyle, equals(FontStyle.normal));
  });

  testWidgets('Defaults to regular when no Text style is passed',
      (tester) async {
    final outputTextStyle = GoogleFonts.latoTextStyle();

    expect(outputTextStyle.fontFamily, equals('Lato_regular'));
  });

  testWidgets(
      'Defaults to regular when a Text style with no weight or style is passed',
      (tester) async {
    final outputTextStyle = GoogleFonts.latoTextStyle(textStyle: TextStyle());

    expect(outputTextStyle.fontFamily, equals('Lato_regular'));
  });

  testWidgets('fontSize is honored when passed in via a TextStyle param',
      (tester) async {
    final textStyle = TextStyle(fontSize: 37);
    final outputTextStyle = GoogleFonts.ranchoTextStyle(textStyle: textStyle);

    expect(outputTextStyle.fontSize, equals(37));
  });

  testWidgets('fontSize is honored from a passed in the fontSize param',
      (tester) async {
    final outputTextStyle = GoogleFonts.ranchoTextStyle(fontSize: 31);

    expect(outputTextStyle.fontSize, equals(31));
  });

  testWidgets(
      'fontSize from top level fontSize param takes precedence over fontSize '
      'from TextStyle param', (tester) async {
    final textStyle = TextStyle(fontSize: 41);
    final outputTextStyle = GoogleFonts.ranchoTextStyle(
      textStyle: textStyle,
      fontSize: 47,
    );

    expect(outputTextStyle.fontSize, equals(47));
  });

  testWidgets('TextTheme method works in the default case', (tester) async {
    final textTheme = GoogleFonts.oswaldTextTheme();
    final expectedFamilyWithVariant = 'Oswald_regular';

    expect(textTheme.display4.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.display3.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.display2.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.display1.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.headline.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.title.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.subhead.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.body2.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.body1.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.caption.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.button.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.subtitle.fontFamily, equals(expectedFamilyWithVariant));
    expect(textTheme.overline.fontFamily, equals(expectedFamilyWithVariant));
  });

  testWidgets('TextTheme method works with a base textTheme', (tester) async {
    // In app this is usually obtained by Theme.of(context).textTheme.
    final baseTextTheme = TextTheme(
      display2: TextStyle(fontWeight: FontWeight.w700),
      body1: GoogleFonts.acmeTextStyle(),
      subtitle: TextStyle(fontStyle: FontStyle.italic),
    );

    final textTheme = GoogleFonts.oswaldTextTheme(baseTextTheme);
    final expectedFamilyWithVariant = 'Oswald_regular';

    // Default is preserved.
    expect(textTheme.display1.fontFamily, equals(expectedFamilyWithVariant));
    // Different font family gets overridden by oswald.
    expect(textTheme.body1.fontFamily, equals(expectedFamilyWithVariant));
    // Weight is preserved.
    expect(textTheme.display2.fontWeight, equals(FontWeight.w700));
    // Style is preserved.
    expect(textTheme.subtitle.fontStyle, equals(FontStyle.italic));
  });
}
