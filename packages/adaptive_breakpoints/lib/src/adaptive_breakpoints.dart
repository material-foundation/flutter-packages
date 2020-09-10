// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:flutter/material.dart';

/// Adaptive Window in Material has five different window sizes. Each window size
/// represents a range of devices.
///
/// Extra small represents phones and small tablets in portrait view.
/// Small represents tablets in portrait view and phones in landscape view.
/// Medium represents large tablets in landscape view.
/// Large represents computer screens.
/// Extra large represents large computer screens.
///
/// https://material.io/design/layout/responsive-layout-grid.html#breakpoints
enum AdaptiveWindowType {
  xs,
  s,
  m,
  l,
  xl,
}

/// Used to set custom comparison operators for the [AdaptiveWindowType] enum.
final Map<AdaptiveWindowType, int> _operatorMap = {
  AdaptiveWindowType.xs: 0,
  AdaptiveWindowType.s: 1,
  AdaptiveWindowType.m: 2,
  AdaptiveWindowType.l: 3,
  AdaptiveWindowType.xl: 4,
};

/// This extension lets you access variables associated with each window type.
extension AdaptiveWindowTypeExtension on AdaptiveWindowType {
  String get name {
    switch (this) {
      case AdaptiveWindowType.xs:
        return 'xsmall';
      case AdaptiveWindowType.s:
        return 'small';
      case AdaptiveWindowType.m:
        return 'medium';
      case AdaptiveWindowType.l:
        return 'large';
      case AdaptiveWindowType.xl:
        return 'xlarge';
      default:
        throw AssertionError('Unsupported AdaptiveWindowType');
    }
  }

  RangeValues get widthRangeValues {
    switch (this) {
      case AdaptiveWindowType.xs:
        return RangeValues(0, 599);
      case AdaptiveWindowType.s:
        return RangeValues(600, 1023);
      case AdaptiveWindowType.m:
        return RangeValues(1024, 1439);
      case AdaptiveWindowType.l:
        return RangeValues(1440, 1919);
      case AdaptiveWindowType.xl:
        return RangeValues(1920, double.infinity);
      default:
        throw AssertionError('Unsupported AdaptiveWindowType');
    }
  }

  RangeValues get heightLandscapeRangeValues {
    switch (this) {
      case AdaptiveWindowType.xs:
        return RangeValues(0, 359);
      case AdaptiveWindowType.s:
        return RangeValues(360, 719);
      case AdaptiveWindowType.m:
        return RangeValues(720, 959);
      case AdaptiveWindowType.l:
        return RangeValues(960, 1279);
      case AdaptiveWindowType.xl:
        return RangeValues(1280, double.infinity);
      default:
        throw AssertionError('Unsupported AdaptiveWindowType');
    }
  }

  RangeValues get heightPortraitRangeValues {
    switch (this) {
      case AdaptiveWindowType.xs:
        return RangeValues(0, 959);
      case AdaptiveWindowType.s:
        return RangeValues(360, 1599);
      case AdaptiveWindowType.m:
        return RangeValues(720, 1919);
      case AdaptiveWindowType.l:
        return RangeValues(1920, double.infinity);
      case AdaptiveWindowType.xl:
        return RangeValues(1920, double.infinity);
      default:
        throw AssertionError('Unsupported AdaptiveWindowType');
    }
  }

  bool operator <=(Object other) => _operatorMap[this] <= _operatorMap[other];

  bool operator <(Object other) => _operatorMap[this] < _operatorMap[other];

  bool operator >=(Object other) => _operatorMap[this] >= _operatorMap[other];

  bool operator >(Object other) => _operatorMap[this] > _operatorMap[other];
}

/// This class represents the Material breakpoint system entry.
/// https://material.io/design/layout/responsive-layout-grid.html#breakpoints
class BreakpointSystemEntry {
  const BreakpointSystemEntry({
    @required this.range,
    this.portrait,
    this.landscape,
    @required this.adaptiveWindowType,
    @required this.columns,
    @required this.margin,
    @required this.gutter,
  })  : assert(range != null),
        assert(adaptiveWindowType != null),
        assert(columns != null),
        assert(margin != null),
        assert(gutter != null);

  /// The breakpoint range values represents a width range.
  final RangeValues range;

  /// Type of device which uses this breakpoint range in portrait view.
  final String portrait;

  /// Type of device which uses this breakpoint range in landscape view.
  final String landscape;

  /// Material generalizes the device size into five different windows: extra
  /// small, small, medium, large, and extra large.
  ///
  /// The adaptive window represents a set of similar devices. For example, if
  /// you want to create an adaptive layout for phones and small tablets you
  /// would check if your window width is within the range of xs and s. If your
  /// user has a bigger window size than you would create a different layout for
  /// larger screens.
  final AdaptiveWindowType adaptiveWindowType;

  /// The number of columns in this breakpoint system entry.
  /// https://material.io/design/layout/responsive-layout-grid.html#columns-gutters-and-margins
  final int columns;

  /// The size of margins in pixels in this breakpoint system entry.
  /// Typically the same as gutters.
  /// https://material.io/design/layout/responsive-layout-grid.html#columns-gutters-and-margins
  final double margin;

  /// The size of gutters in pixels in this breakpoint system entry. Typically
  /// the same as margins.
  ///
  /// Gutters represents the space between the columns.
  ///
  /// https://material.io/design/layout/responsive-layout-grid.html#columns-gutters-and-margins
  final double gutter;
}

/// This list represents the material breakpoint system.
/// https://material.io/design/layout/responsive-layout-grid.html#breakpoints
///
/// This list is in sequential order.
List<BreakpointSystemEntry> breakpointSystem = [
  BreakpointSystemEntry(
    range: RangeValues(0, 359),
    portrait: 'small handset',
    adaptiveWindowType: AdaptiveWindowType.xs,
    columns: 4,
    margin: 16.0,
    gutter: 16.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(360, 399),
    portrait: 'medium handset',
    adaptiveWindowType: AdaptiveWindowType.xs,
    columns: 4,
    margin: 16.0,
    gutter: 16.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(400, 479),
    portrait: 'large handset',
    adaptiveWindowType: AdaptiveWindowType.xs,
    columns: 4,
    margin: 16.0,
    gutter: 16.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(480, 599),
    portrait: 'large handset',
    landscape: 'small handset',
    adaptiveWindowType: AdaptiveWindowType.xs,
    columns: 4,
    margin: 16.0,
    gutter: 16.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(600, 719),
    portrait: 'small tablet',
    landscape: 'medium handset',
    adaptiveWindowType: AdaptiveWindowType.s,
    columns: 8,
    margin: 16.0,
    gutter: 16.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(720, 839),
    portrait: 'large tablet',
    landscape: 'large handset',
    adaptiveWindowType: AdaptiveWindowType.s,
    columns: 8,
    margin: 24.0,
    gutter: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(840, 959),
    portrait: 'large tablet',
    landscape: 'large handset',
    adaptiveWindowType: AdaptiveWindowType.s,
    columns: 12,
    margin: 24.0,
    gutter: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(960, 1023),
    landscape: 'small tablet',
    adaptiveWindowType: AdaptiveWindowType.s,
    columns: 12,
    margin: 24.0,
    gutter: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(1024, 1279),
    landscape: 'large tablet',
    adaptiveWindowType: AdaptiveWindowType.m,
    columns: 12,
    margin: 24.0,
    gutter: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(1280, 1439),
    landscape: 'large tablet',
    adaptiveWindowType: AdaptiveWindowType.m,
    columns: 12,
    margin: 24.0,
    gutter: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(1440, 1599),
    portrait: 'small handset',
    adaptiveWindowType: AdaptiveWindowType.l,
    columns: 12,
    margin: 24.0,
    gutter: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(1600, 1919),
    portrait: 'small handset',
    adaptiveWindowType: AdaptiveWindowType.l,
    columns: 12,
    margin: 24.0,
    gutter: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(1920, double.infinity),
    portrait: 'small handset',
    adaptiveWindowType: AdaptiveWindowType.xl,
    columns: 12,
    margin: 24.0,
    gutter: 24.0,
  ),
];

/// Returns the [AdaptiveWindowType] to the user.
///
/// This is useful when the user wants to compare the MediaQuery to the current
/// window size.
AdaptiveWindowType getWindowType(BuildContext context) {
  return getBreakpointEntry(context).adaptiveWindowType;
}

/// Returns the [BreakpointSystemEntry] to the user.
///
/// Typically the developer will use the getWindowType function. Using this
/// function gives the developer access to the specific breakpoint entry and
/// it's variables.
BreakpointSystemEntry getBreakpointEntry(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  for (BreakpointSystemEntry entry in breakpointSystem) {
    if (entry.range.start <= width && width < entry.range.end + 1) {
      return entry;
    }
  }
  throw AssertionError('Something unexpected happened');
}
