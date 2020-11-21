import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/src/google_fonts_variant.dart';

void main() {
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

  testWidgets('toApiFilenamePart() works for all normal combintaions',
      (tester) async {
    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w100,
        fontStyle: FontStyle.normal,
      ).toApiFilenamePart(),
      equals('Thin'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w200,
        fontStyle: FontStyle.normal,
      ).toApiFilenamePart(),
      equals('ExtraLight'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
      ).toApiFilenamePart(),
      equals('Light'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ).toApiFilenamePart(),
      equals('Regular'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ).toApiFilenamePart(),
      equals('Medium'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      ).toApiFilenamePart(),
      equals('SemiBold'),
    );

    expect(
        GoogleFontsVariant(
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
        ).toApiFilenamePart(),
        equals('Bold'));

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.normal,
      ).toApiFilenamePart(),
      equals('ExtraBold'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.normal,
      ).toApiFilenamePart(),
      equals('Black'),
    );
  });

  testWidgets('toApiFilenamePart() works for all italic combintaions',
      (tester) async {
    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w100,
        fontStyle: FontStyle.italic,
      ).toApiFilenamePart(),
      equals('ThinItalic'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w200,
        fontStyle: FontStyle.italic,
      ).toApiFilenamePart(),
      equals('ExtraLightItalic'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.italic,
      ).toApiFilenamePart(),
      equals('LightItalic'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
      ).toApiFilenamePart(),
      equals('Italic'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
      ).toApiFilenamePart(),
      equals('MediumItalic'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
      ).toApiFilenamePart(),
      equals('SemiBoldItalic'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ).toApiFilenamePart(),
      equals('BoldItalic'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w800,
        fontStyle: FontStyle.italic,
      ).toApiFilenamePart(),
      equals('ExtraBoldItalic'),
    );

    expect(
      GoogleFontsVariant(
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
      ).toApiFilenamePart(),
      equals('BlackItalic'),
    );
  });

  testWidgets('fromApiFilenamePart() works for all normal combintaions',
      (tester) async {
    expect(
      GoogleFontsVariant.fromApiFilenamePart('Thin'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.normal,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('ExtraLight'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w200,
          fontStyle: FontStyle.normal,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('Light'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('Regular'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('Medium'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('SemiBold'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('Bold'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('ExtraBold'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.normal,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('Black'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  });

  testWidgets('fromApiFilenamePart() works for all italic combintaions',
      (tester) async {
    expect(
      GoogleFontsVariant.fromApiFilenamePart('ThinItalic'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.italic,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('ExtraLightItalic'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w200,
          fontStyle: FontStyle.italic,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('LightItalic'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.italic,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('Italic'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('MediumItalic'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('SemiBoldItalic'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('BoldItalic'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('ExtraBoldItalic'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.italic,
        ),
      ),
    );

    expect(
      GoogleFontsVariant.fromApiFilenamePart('BlackItalic'),
      equals(
        GoogleFontsVariant(
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
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
