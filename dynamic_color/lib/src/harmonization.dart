import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

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

  /// Harmonizes semantic and custom [ColorScheme] colors with its [primary] color.
  ///
  /// Harmonization makes adding and introducing new colors to your app more
  /// seamless by automatically shifting hue and chroma slightly so that a
  /// product's colors feel more cohesive with dynamic user colors.
  ///
  /// Semantic colors (i.e. colors with meaning) include colors such as [error].
  /// See https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization
  /// for more information.
  ///
  /// Subclasses of [ColorScheme] that add custom colors should re-implement
  /// [harmonized]. For example:
  /// import 'package:dynamic_color/dynamic_color.dart';
  ///
  /// class CustomColorScheme extends ColorScheme {
  ///   const CustomColorScheme(this.customYellow) : super(...);
  ///
  ///   final Color customYellow;
  ///
  ///   CustomColorScheme copyWith({ ... }) {}
  ///
  ///   CustomColorScheme harmonized() {
  ///     return copyWith(
  ///       customYellow: _harmonizeWithPrimary(customYellow),
  ///       error: _harmonizeWithPrimary(error),
  ///       onError: _harmonizeWithPrimary(onError),
  ///       errorContainer: _harmonizeWithPrimary(errorContainer),
  ///       onErrorContainer: _harmonizeWithPrimary(onErrorContainer),
  ///     );
  ///   }
  /// }
  ///
  ColorScheme harmonized() {
    return copyWith(
      error: _harmonizeWithPrimary(error),
      onError: _harmonizeWithPrimary(onError),
      errorContainer: _harmonizeWithPrimary(errorContainer),
      onErrorContainer: _harmonizeWithPrimary(onErrorContainer),
    );
  }
}
