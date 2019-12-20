import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/src/google_fonts_descriptor.dart';
import 'package:google_fonts/src/google_fonts_family_with_variant.dart';
import 'package:google_fonts/src/google_fonts_variant.dart';

main() {
  testWidgets('toString() works for normal w400', (tester) async {
    final familyWithVariant = GoogleFontsFamilyWithVariant(
      family: 'Foo',
      googleFontsVariant: GoogleFontsVariant(
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
      ),
    );

    expect(familyWithVariant.toString(), equals('Foo_regular'));
  });

  testWidgets('toString() works for italic w100', (tester) async {
    final familyWithVariant = GoogleFontsFamilyWithVariant(
      family: 'Foo',
      googleFontsVariant: GoogleFontsVariant(
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w100,
      ),
    );

    expect(familyWithVariant.toString(), equals('Foo_100italic'));
  });

  testWidgets('fromApiFilenamePrefix() works for italic w100', (tester) async {
    final familyWithVariant =
        GoogleFontsFamilyWithVariant.fromApiFilenamePrefix('Foo-ThinItalic');

    expect(familyWithVariant.family, equals('Foo'));
    expect(
      familyWithVariant.googleFontsVariant,
      equals(GoogleFontsVariant(
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w100,
      )),
    );
  });

  testWidgets('fromApiFilenamePrefix() works for regular', (tester) async {
    final familyWithVariant =
        GoogleFontsFamilyWithVariant.fromApiFilenamePrefix('Foo-Regular');

    expect(familyWithVariant.family, equals('Foo'));
    expect(
      familyWithVariant.googleFontsVariant,
      equals(GoogleFontsVariant(
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
      )),
    );
  });

  testWidgets('toApiFilenamePrefix() works for italic w100', (tester) async {
    final familyWithVariant = GoogleFontsFamilyWithVariant(
      family: 'Foo',
      googleFontsVariant: GoogleFontsVariant(
        fontWeight: FontWeight.w100,
        fontStyle: FontStyle.italic,
      ),
    );

    expect(familyWithVariant.toApiFilenamePrefix(), equals('Foo-ThinItalic'));
  });

  testWidgets('toApiFilenamePrefix() works for regular', (tester) async {
    final familyWithVariant = GoogleFontsFamilyWithVariant(
      family: 'Foo',
      googleFontsVariant: GoogleFontsVariant(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    );

    expect(familyWithVariant.toApiFilenamePrefix(), equals('Foo-Regular'));
  });
}
