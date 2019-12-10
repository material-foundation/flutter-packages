import 'dart:ui';

import 'package:flutter/foundation.dart';

/// Represents a Google Fonts API variant in Flutter-specific types.
class GoogleFontsVariant {
  const GoogleFontsVariant({
    @required this.fontWeight,
    @required this.fontStyle,
  })  : assert(fontWeight != null),
        assert(fontStyle != null);

  GoogleFontsVariant.fromString(String variantString)
      : this.fontWeight = FontWeight.values[variantString == _regular ||
                variantString == _italic
            ? 3
            : (int.parse(variantString.replaceAll(_italic, '')) ~/ 100) - 1],
        this.fontStyle = variantString.contains(_italic)
            ? FontStyle.italic
            : FontStyle.normal;

  final FontWeight fontWeight;
  final FontStyle fontStyle;

  @override
  String toString() {
    final fontWeightString =
        fontWeight.index == 3 ? '' : (fontWeight.index + 1) * 100;
    final fontStyleString = fontStyle
        .toString()
        .replaceAll('FontStyle.', '')
        .replaceFirst(_normal, fontWeight.index == 3 ? _regular : '');
    return '$fontWeightString$fontStyleString';
  }

  @override
  int get hashCode => hashValues(fontWeight, fontStyle);

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    final GoogleFontsVariant typedOther = other;
    return typedOther.fontWeight == fontWeight &&
        typedOther.fontStyle == fontStyle;
  }
}

// What the Flutter API calls a font style of normal/regular.
const _normal = 'normal';
// What the Google Fonts API calls a font style of normal/regular.
const _regular = 'regular';
// Both the Flutter API and the Google API have the same name for a font style
// of italic.
const _italic = 'italic';
