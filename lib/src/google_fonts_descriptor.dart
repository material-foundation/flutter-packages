// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'google_fonts_family_with_variant.dart';

/// Describes a Google Fonts API font.
///
/// This class mostly serves a simple way to keep the connected font information
/// together.
class GoogleFontsDescriptor {
  const GoogleFontsDescriptor({
    this.familyWithVariant,
    this.file,
  })  : assert(familyWithVariant != null),
        assert(file != null);

  final GoogleFontsFamilyWithVariant familyWithVariant;
  final GoogleFontsFile file;
}

/// Describes a font file as it is _expected_ to be received form the server.
///
/// If a file is retrieved and its hash does not match [expectedFileHash], or it
/// is not of [expectedLength] bytes length, the font will not be loaded, and
/// the file will not be stored on the device.
class GoogleFontsFile {
  GoogleFontsFile(this.expectedFileHash, this.expectedLength);

  final String expectedFileHash;
  final int expectedLength;

  String get url => 'https://fonts.gstatic.com/s/a/$expectedFileHash.ttf';
}
