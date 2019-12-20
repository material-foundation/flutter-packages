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

  GoogleFontsVariant.fromFontJson(Map<String, dynamic> fontJson)
      : this.fontWeight = FontWeight.values[
  (fontJson['weight'] == null ? 400 : fontJson['weight']) ~/ 100 - 1],
        this.fontStyle =
        fontJson['style'] == null ? FontStyle.normal : FontStyle.italic;

  /// 'Regular' -> weight: 400, style: normal
  /// 'Italic' -> weight: 400, style: italic
  /// 'Bold' -> weight: 700, style: normal
  /// 'BoldItalic' -> weight: 700, style: italic
  GoogleFontsVariant.fromApiFilenamePart(String filenamePart)
  : this.fontWeight = _extractFontWeightFromApiFilenamePart(filenamePart),
        this.fontStyle = _extractFontStyleFromApiFilenamePart(filenamePart);

  final FontWeight fontWeight;
  final FontStyle fontStyle;

  static FontWeight _extractFontWeightFromApiFilenamePart(String filenamePart) {
    if (filenamePart.contains('Thin')) return FontWeight.w100;

    // ExtraLight must be checked before Light because of the substring match.
    if (filenamePart.contains('ExtraLight')) return FontWeight.w200;
    if (filenamePart.contains('Light')) return FontWeight.w300;

    if (filenamePart.contains('Medium')) return FontWeight.w500;

    // SemiBold and ExtraBold must be checked before Bold because of the
    // substring match.
    if (filenamePart.contains('SemiBold')) return FontWeight.w600;
    if (filenamePart.contains('ExtraBold')) return FontWeight.w800;
    if (filenamePart.contains('Bold')) return FontWeight.w700;

    if (filenamePart.contains('Black')) return FontWeight.w900;
    return FontWeight.w400;
  }

  static FontStyle _extractFontStyleFromApiFilenamePart(String filenamePart) {
    if (filenamePart.contains('Italic')) return FontStyle.italic;
    return FontStyle.normal;
  }

  String toApiFilenamePart() {
    var weightPrefix;
    if (fontWeight == FontWeight.w100) weightPrefix = 'Thin';
    if (fontWeight == FontWeight.w200) weightPrefix = 'ExtraLight';
    if (fontWeight == FontWeight.w300) weightPrefix = 'Light';
    if (fontWeight == FontWeight.w400) weightPrefix = 'Regular';
    if (fontWeight == FontWeight.w500) weightPrefix = 'Medium';
    if (fontWeight == FontWeight.w600) weightPrefix = 'SemiBold';
    if (fontWeight == FontWeight.w700) weightPrefix = 'Bold';
    if (fontWeight == FontWeight.w800) weightPrefix = 'ExtraBold';
    if (fontWeight == FontWeight.w900) weightPrefix = 'Black';
    if (weightPrefix == null) weightPrefix = 'Regular';
    final italicSuffix = fontStyle == FontStyle.italic ? 'Italic' : '';
    if (weightPrefix == 'Regular') return italicSuffix == '' ? weightPrefix : italicSuffix;
    return '$weightPrefix$italicSuffix';
  }

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
