import 'dart:ui';

import 'package:flutter/foundation.dart';

/// Respresents a Material You tonal palette, consisting of 5 tonal
/// ranges.
///
/// TODO(guidezpl): expand explanation, add screenshot, link to spec
class TonalPalette {
  const TonalPalette({
    required this.neutral,
    required this.neutralVariant,
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });

  /// The neutral tonal range (N).
  final _TonalRange neutral;

  /// The neutral variant tonal range (NV).
  final _TonalRange neutralVariant;

  /// The primary tonal range (P).
  final _TonalRange primary;

  /// The secondary tonal range (S).
  final _TonalRange secondary;

  /// The tertiary tonal range (T).
  final _TonalRange tertiary;

  /// Turns a [List] of color [int]s representing concatenated tonal ranges into
  /// a [TonalPalette] object.
  ///
  /// This is the reverse of [asList].
  TonalPalette.fromList(List<int> palettes)
      : neutral = _TonalRange._fromList(
          palettes.getPartition(0, _TonalRange.tonalRangeSize),
        ),
        neutralVariant = _TonalRange._fromList(
          palettes.getPartition(1, _TonalRange.tonalRangeSize),
        ),
        primary = _TonalRange._fromList(
          palettes.getPartition(2, _TonalRange.tonalRangeSize),
        ),
        secondary = _TonalRange._fromList(
          palettes.getPartition(3, _TonalRange.tonalRangeSize),
        ),
        tertiary = _TonalRange._fromList(
          palettes.getPartition(4, _TonalRange.tonalRangeSize),
        );

  /// Returns all of the colors in each tonal range in one long [List] of color [int]s.
  ///
  /// This is the reverse of [TonalPalette.fromList].
  List<int> asList() => [
        ...neutral.allShades,
        ...neutralVariant.allShades,
        ...primary.allShades,
        ...secondary.allShades,
        ...tertiary.allShades,
      ].map((color) => color.value).toList();

  @override
  String toString() {
    return 'Neutral: $neutral\n'
        'Neutral variant: $neutralVariant\n'
        'Primary: $primary\n'
        'Secondary: $secondary\n'
        'Tertiary: $tertiary\n';
  }

  @override
  bool operator ==(Object other) {
    return other is TonalPalette &&
        neutral == other.neutral &&
        neutralVariant == other.neutralVariant &&
        primary == other.primary &&
        secondary == other.secondary &&
        tertiary == other.tertiary;
  }

  @override
  int get hashCode =>
      hashValues(neutral, neutralVariant, primary, secondary, tertiary);
}

/// Each tonal range contains 13 color shades.
///
/// The shades range from 0 to 1000, from most luminant to the least luminant.
/// In other words, the 0 shade is always white and the 1000 shade is always
/// black.
class _TonalRange {
  const _TonalRange({
    required this.shade0,
    required this.shade10,
    required this.shade50,
    required this.shade100,
    required this.shade200,
    required this.shade300,
    required this.shade400,
    required this.shade500,
    required this.shade600,
    required this.shade700,
    required this.shade800,
    required this.shade900,
    required this.shade1000,
  });

  _TonalRange._fromList(List<int> colors)
      : shade0 = Color(colors[0]),
        shade10 = Color(colors[1]),
        shade50 = Color(colors[2]),
        shade100 = Color(colors[3]),
        shade200 = Color(colors[4]),
        shade300 = Color(colors[5]),
        shade400 = Color(colors[6]),
        shade500 = Color(colors[7]),
        shade600 = Color(colors[8]),
        shade700 = Color(colors[9]),
        shade800 = Color(colors[10]),
        shade900 = Color(colors[11]),
        shade1000 = Color(colors[12]);

  final Color shade0; // Always 100% white
  final Color shade10;
  final Color shade50;
  final Color shade100;
  final Color shade200;
  final Color shade300;
  final Color shade400;
  final Color shade500;
  final Color shade600;
  final Color shade700;
  final Color shade800;
  final Color shade900;
  final Color shade1000; // Always 100% black

  // How many shades there are in a tonal range.
  static const tonalRangeSize = 13;

  /// Returns all the shades in this tonal range as a list from shade 0 to 1000.
  List<Color> get allShades => [
        shade0,
        shade10,
        shade50,
        shade100,
        shade200,
        shade300,
        shade400,
        shade500,
        shade600,
        shade700,
        shade800,
        shade900,
        shade1000,
      ];

  @override
  String toString() {
    return '{0: $shade0 '
        '50: $shade50 '
        '100: $shade100 '
        '200: $shade200 '
        '300: $shade300 '
        '400: $shade400 '
        '500: $shade500 '
        '600: $shade600 '
        '700: $shade700 '
        '800: $shade800 '
        '900: $shade900 '
        '1000: $shade1000}';
  }

  @override
  bool operator ==(Object other) {
    return other is _TonalRange && listEquals(allShades, other.allShades);
  }

  @override
  int get hashCode => hashList(allShades);
}

extension _PartitionHelper on List<int> {
  // Returns a partition from a list.
  //
  // For example, given a list with 2 partitions of size 3.
  // range = [1, 2, 3, 4, 5, 6];
  //
  // range.getPartition(0, 3) // [1, 2, 3]
  // range.getPartition(1, 3) // [4, 5, 6]
  List<int> getPartition(int partitionNumber, int partitionSize) {
    return sublist(
      partitionNumber * partitionSize,
      (partitionNumber + 1) * partitionSize,
    );
  }
}
