import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

// Consider `flutter test --no-test-assets` if assets are not required.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // This has the side effect of setting up a mock HTTP client.
  // Disable this with HttpOverrides.global = null;

  test('Can test fonts', () {
    final styleFunc = GoogleFonts.asMap()['ABeeZee']!;
    final expectedStyle = GoogleFonts.getFont('ABeeZee');
    expect(styleFunc(), equals(expectedStyle));
  });
}
