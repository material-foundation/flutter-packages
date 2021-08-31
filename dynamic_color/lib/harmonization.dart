import 'dart:ui';

import 'package:flutter/material.dart';

/// Shifts color [from] towards color [to].
Color _harmonizeColor(Color from, Color to) {
  if (from == to) return from;
  return from;
  // TODO(guidezpl): enable when available
  // return monet.smartBlend(from.value, to.value, hueP: 0.25, chroma: 0);
}

extension ColorHarmonization on Color {
  /// Harmonizes this color with [color].
  ///
  /// Intended to be used with [ColorScheme.primary].
  Color harmonizeWith(Color color) => _harmonizeColor(this, color);
}

extension ColorSchemeHarmonization on ColorScheme {
  /// Harmonizes [color] with this [ColorScheme]'s [primary].
  Color _harmonizeWithPrimary(Color color) => _harmonizeColor(color, primary);

  /// Harmonizes semantic [ColorScheme] colors with its [primary] color.
  ///
  /// TODO(guidezpl): link to spec
  ///
  /// Semantic colors (i.e. colors with meaning) are [error] and [onError]. Not
  /// harmonizing them would cause semantic colors to look out of place next to
  /// dynamic colors.
  ///
  /// Subclasses of [ColorScheme] with additional semantic colors should
  /// re-implement [harmonized]. For example:
  /// import 'package:dynamic_colors/harmonization.dart';
  ///
  /// class CustomColorScheme extends ColorScheme {
  ///   const CustomColorScheme(this.customSemanticColor) : super(...);
  ///
  ///   final Color customSemanticColor;
  ///
  ///   CustomColorScheme copyWith({ ... }) {}
  ///
  ///   CustomColorScheme harmonized() {
  ///     return copyWith(
  ///       customSemanticColor: _harmonizeWithPrimary(customSemanticColor),
  ///       error: _harmonizeWithPrimary(error),
  ///       onError: _harmonizeWithPrimary(onError),
  ///     );
  ///   }
  /// }
  ///
  ColorScheme harmonized() {
    return copyWith(
      error: _harmonizeWithPrimary(error),
      onError: _harmonizeWithPrimary(onError),
    );
  }
}
