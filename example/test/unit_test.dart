import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

// Consider `flutter test --no-test-assets` if assets are not required.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // This has the side effect of setting up a mock HTTP client.
  // Disable this with HttpOverrides.global = null;

  late TextStyle expectedStyle;

  setUpAll(() {
    expectedStyle = GoogleFonts.getFontDynamically('ABeeZee').style();
  });

  test('Can test fonts', () {
    final textStyle = const ABeeZeeFont().style();
    expect(textStyle, equals(expectedStyle));
  });
}
