import 'package:flutter/material.dart';

/// Adaptive Window in Material has five different window sizes. Each one can be
/// broken into smaller bits.
///
/// Extra small represents phones and small tablets on portrait view.
/// Small represents tablets in portrait view and phones on landscape view.
/// Medium is going to represent large tablets in landscape view.
/// Large represents computer screens.
/// Extra large represents TVs.
enum AdaptiveWindow {
  xs,
  s,
  m,
  l,
  xl,
}

extension AdaptiveWindowExtension on AdaptiveWindow {
  String get name {
    switch (this) {
      case AdaptiveWindow.xs:
        return 'xsmall';
        break;
      case AdaptiveWindow.s:
        return 'small';
        break;
      case AdaptiveWindow.m:
        return 'medium';
        break;
      case AdaptiveWindow.l:
        return 'large';
        break;
      case AdaptiveWindow.xl:
        return 'xlarge';
        break;
      default:
        throw AssertionError('Error');
    }
  }

  double get longestWidth {
    switch (this) {
      case AdaptiveWindow.xs:
        return 599;
        break;
      case AdaptiveWindow.s:
        return 1023;
        break;
      case AdaptiveWindow.m:
        return 1439;
        break;
      case AdaptiveWindow.l:
        return 1919;
        break;
      case AdaptiveWindow.xl:
        return 10000000;
        break;
      default:
        throw AssertionError('Error');
    }
  }

  double get shortestWidth {
    switch (this) {
      case AdaptiveWindow.xs:
        return 0;
        break;
      case AdaptiveWindow.s:
        return 600;
        break;
      case AdaptiveWindow.m:
        return 1024;
        break;
      case AdaptiveWindow.l:
        return 1140;
        break;
      case AdaptiveWindow.xl:
        return 1920;
      default:
        throw AssertionError('Error');
    }
  }

  double get longestLandscapeHeight {
    switch (this) {
      case AdaptiveWindow.xs:
        return 359;
        break;
      case AdaptiveWindow.s:
        return 719;
        break;
      case AdaptiveWindow.m:
        return 959;
        break;
      case AdaptiveWindow.l:
        return 1279;
        break;
      case AdaptiveWindow.xl:
        return 10000000;
        break;
      default:
        throw AssertionError('Error');
    }
  }

  double get shortestLandscapeHeight {
    switch (this) {
      case AdaptiveWindow.xs:
        return 0;
        break;
      case AdaptiveWindow.s:
        return 360;
        break;
      case AdaptiveWindow.m:
        return 720;
        break;
      case AdaptiveWindow.l:
        return 960;
        break;
      case AdaptiveWindow.xl:
        return 1280;
      default:
        throw AssertionError('Error');
    }
  }

  double get longestPortraitHeight {
    switch (this) {
      case AdaptiveWindow.xs:
        return 959;
        break;
      case AdaptiveWindow.s:
        return 1599;
        break;
      case AdaptiveWindow.m:
        return 1919;
        break;
      case AdaptiveWindow.l:
        return 1279;
        break;
      case AdaptiveWindow.xl:
        return 10000000;
        break;
      default:
        throw AssertionError('Error');
    }
  }

  double get shortestPortraitHeight {
    switch (this) {
      case AdaptiveWindow.xs:
        return 0;
        break;
      case AdaptiveWindow.s:
        return 960;
        break;
      case AdaptiveWindow.m:
        return 1600;
        break;
      case AdaptiveWindow.l:
        return 960;
        break;
      case AdaptiveWindow.xl:
        return 1280;
      default:
        throw AssertionError('Error');
    }
  }
}

class AdaptiveWindowLimits {
  final int xs;
  final int s;
  final int m;
  final int l;
  final int xl;

  AdaptiveWindowLimits({
    @required this.xs,
    @required this.s,
    @required this.m,
    @required this.l,
    @required this.xl,
  })  : assert(xs != null),
        assert(s != null),
        assert(m != null),
        assert(l != null),
        assert(xl != null);
}

/// This class represents the Material breakpoint system entry.
/// https://material.io/design/layout/responsive-layout-grid.html#breakpoints
class BreakpointSystemEntry {
  /// The breakpoint range values use the height of the device if the user is
  /// using their device on portrait view or the width of the device if the user
  /// is using their device in landscape view.
  /// By using this logic we can compare the breakpoint range values to the longer
  /// length of the MediaQuery.
  /// This is typical done by using: MediaQuery.of(context).size.longestSide
  final RangeValues range;

  /// String of device name that use this breakpoint range in portrait view.
  final String portrait;

  /// String of device name that use this breakpoint range in landscape view.
  final String landscape;

  /// Material generalizes the Device Size into five different windows: extra
  /// small, small, medium, large, and extra large.
  final AdaptiveWindow window;

  /// The columns in this breakpoint system entry.
  /// https://material.io/design/layout/responsive-layout-grid.html#columns-gutters-and-margins
  final int columns;

  /// The margins in this breakpoint system entry. Margins is typically going to
  /// be the same length as gutters.
  /// https://material.io/design/layout/responsive-layout-grid.html#columns-gutters-and-margins
  final double margins;

  /// The gutters in this breakpoint system entry. Margins is typically going to
  /// be the same length as margins.
  /// https://material.io/design/layout/responsive-layout-grid.html#columns-gutters-and-margins
  final double gutters;

  const BreakpointSystemEntry({
    @required this.range,
    this.portrait,
    this.landscape,
    @required this.window,
    @required this.columns,
    @required this.margins,
    @required this.gutters,
  })  : assert(range != null),
        assert(window != null),
        assert(columns != null),
        assert(margins != null),
        assert(gutters != null);
}

/// This class represents the material breakpoint system.
/// https://material.io/design/layout/responsive-layout-grid.html#breakpoints
///
/// This list is in sequential order.
List<BreakpointSystemEntry> breakpointSystem = [
  BreakpointSystemEntry(
    range: RangeValues(0, 359),
    portrait: 'small handset',
    window: AdaptiveWindow.xs,
    columns: 4,
    margins: 16.0,
    gutters: 16.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(360, 399),
    portrait: 'medium handset',
    window: AdaptiveWindow.xs,
    columns: 4,
    margins: 16.0,
    gutters: 16.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(400, 479),
    portrait: 'large handset',
    window: AdaptiveWindow.xs,
    columns: 4,
    margins: 16.0,
    gutters: 16.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(480, 599),
    portrait: 'large handset',
    landscape: 'small handset',
    window: AdaptiveWindow.xs,
    columns: 4,
    margins: 16.0,
    gutters: 16.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(600, 719),
    portrait: 'small tablet',
    landscape: 'medium handset',
    window: AdaptiveWindow.s,
    columns: 8,
    margins: 16.0,
    gutters: 16.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(720, 839),
    portrait: 'large tablet',
    landscape: 'large handset',
    window: AdaptiveWindow.s,
    columns: 8,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(840, 959),
    portrait: 'large tablet',
    landscape: 'large handset',
    window: AdaptiveWindow.s,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(960, 1023),
    landscape: 'small tablet',
    window: AdaptiveWindow.s,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(1024, 1279),
    landscape: 'large tablet',
    window: AdaptiveWindow.m,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(1280, 1439),
    landscape: 'large tablet',
    window: AdaptiveWindow.m,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(1440, 1599),
    portrait: 'small handset',
    window: AdaptiveWindow.l,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(1600, 1919),
    portrait: 'small handset',
    window: AdaptiveWindow.l,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: RangeValues(1920, 10000000),
    portrait: 'small handset',
    window: AdaptiveWindow.xl,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
  ),
];

/// Returns ths Window Size to the user. This is useful when the user wants to
/// compare the MediaQuery to the current window size.
AdaptiveWindow getWindowSize(Size size) {
  double width = size.width;
  for (BreakpointSystemEntry entry in breakpointSystem) {
    if (entry.range.start <= width && width <= entry.range.end) {
      return entry.window;
    }
  }
  throw AssertionError('WindowSize is too big');
}

BreakpointSystemEntry getBreakpointEntry(Size size) {
  double width = size.width;
  for (BreakpointSystemEntry entry in breakpointSystem) {
    if (entry.range.start <= width && width <= entry.range.end) {
      return entry;
    }
  }
  throw AssertionError('WindowSize is too big');
}
