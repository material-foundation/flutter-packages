import 'package:flutter/foundation.dart';

import 'google_fonts_family_with_variant.dart';

/// Describes a Google Fonts API font.
///
/// This class mostly serves a simple way to keep the connected font information
/// together.
class GoogleFontsDescriptor {
  const GoogleFontsDescriptor({
    @required this.familyWithVariant,
    @required this.file,
  })  : assert(familyWithVariant != null),
        assert(file != null);

  final GoogleFontsFamilyWithVariant familyWithVariant;
  final GoogleFontsFile file;
}

// TODO: Document this
class GoogleFontsFile {
  GoogleFontsFile(this.expectedFileHash, this.expectedLength);

  final String expectedFileHash;
  final int expectedLength;

  String get url => 'https://fonts.gstatic.com/s/a/$expectedFileHash.ttf';
}
