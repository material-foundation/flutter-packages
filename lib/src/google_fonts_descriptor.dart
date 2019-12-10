import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'google_fonts_variant.dart';

/// Describes a Google Fonts API font.
///
/// This class mostly serves a simple way to keep the connected font information
/// together, but it also has a [familyWithVariant] method to obtain a string
/// that is used throughout the package as a key.
class GoogleFontsDescriptor {
  const GoogleFontsDescriptor({
    @required this.fontFamily,
    @required this.fontWeight,
    @required this.fontStyle,
    @required this.fontUrl,
  })  : assert(fontFamily != null),
        assert(fontWeight != null),
        assert(fontStyle != null),
        assert(fontUrl != null);

  final String fontFamily;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final String fontUrl;

  /// Returns a font family name that is modified with additional [fontWeight]
  /// and [fontStyle] descriptions.
  ///
  /// This string is used as a key to the loaded or stored fonts that come
  /// from the Google Fonts API.
  String familyWithVariant() {
    final variantString =
        GoogleFontsVariant(fontWeight: fontWeight, fontStyle: fontStyle)
            .toString();
    return '${fontFamily}_$variantString';
  }
}
