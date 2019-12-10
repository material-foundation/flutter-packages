import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/src/google_fonts_variant.dart';

main() {
  testWidgets('toString() works for normal w400', (tester) async {
    final variant = GoogleFontsVariant(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    );

    expect(variant.toString(), equals('regular'));
  });

  testWidgets('toString() works for italic w400', (tester) async {
    final variant = GoogleFontsVariant(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
    );

    expect(variant.toString(), equals('italic'));
  });

  testWidgets('toString() works for normal w500', (tester) async {
    final variant = GoogleFontsVariant(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    );

    expect(variant.toString(), equals('500'));
  });

  testWidgets('toString() works for italic w500', (tester) async {
    final variant = GoogleFontsVariant(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
    );

    expect(variant.toString(), equals('500italic'));
  });

  testWidgets('fromString() works for regular', (tester) async {
    final variant = GoogleFontsVariant(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    );

    expect(GoogleFontsVariant.fromString('regular'), equals(variant));
  });

  testWidgets('fromString() works for italic', (tester) async {
    final variant = GoogleFontsVariant(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
    );

    expect(GoogleFontsVariant.fromString('italic'), equals(variant));
  });

  testWidgets('fromString() works for 500', (tester) async {
    final variant = GoogleFontsVariant(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    );

    expect(GoogleFontsVariant.fromString('500'), equals(variant));
  });

  testWidgets('fromString() works for 500italic', (tester) async {
    final variant = GoogleFontsVariant(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
    );

    expect(GoogleFontsVariant.fromString('500italic'), equals(variant));
  });

  testWidgets('== works for for identical variants', (tester) async {
    final variant = GoogleFontsVariant(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
    );
    final otherVariant = variant;

    expect(variant == otherVariant, isTrue);
  });

  testWidgets('== works for for clone variants', (tester) async {
    final variant = GoogleFontsVariant(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
    );
    final otherVariant = GoogleFontsVariant(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
    );
    expect(variant == otherVariant, isTrue);
  });

  testWidgets('== fails for different fontWeights', (tester) async {
    final variant = GoogleFontsVariant(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
    );
    final otherVariant = GoogleFontsVariant(
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.italic,
    );
    expect(variant == otherVariant, isFalse);
  });

  testWidgets('== fails for different fontStyles', (tester) async {
    final variant = GoogleFontsVariant(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
    );
    final otherVariant = GoogleFontsVariant(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    );
    expect(variant == otherVariant, isFalse);
  });

  testWidgets('== fails for different fontWeights and different fontStyles',
      (tester) async {
    final variant = GoogleFontsVariant(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
    );
    final otherVariant = GoogleFontsVariant(
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.normal,
    );
    expect(variant == otherVariant, isFalse);
  });
}
