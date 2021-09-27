import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dynamic_color_tools/dynamic_color_tools.dart';

/// Shifts color [from] towards color [to].
Color _harmonizeColor(Color from, Color to) {
  if (from == to) return from;
  return Color(Blend.harmonize(from.value, to.value));
}

extension ColorHarmonization on Color {
  /// Harmonizes this color with [color].
  ///
  /// [color] will typically be a dynamic [ColorScheme.primary] color.
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
  /// import 'package:dynamic_color/harmonization.dart';
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
