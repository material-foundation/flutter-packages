import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/src/google_fonts_descriptor.dart';

main() {
  testWidgets('familyWithVariant works for normal w400', (tester) async {
    final descriptor = GoogleFontsDescriptor(
      fontFamily: 'foo',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontUrl: 'fonts.google.com/foo',
    );

    expect(descriptor.familyWithVariant(), equals('foo_regular'));
  });

  testWidgets('familyWithVariant works for italic w100', (tester) async {
    final descriptor = GoogleFontsDescriptor(
      fontFamily: 'foo',
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w100,
      fontUrl: 'fonts.google.com/foo',
    );

    expect(descriptor.familyWithVariant(), equals('foo_100italic'));
  });
}
