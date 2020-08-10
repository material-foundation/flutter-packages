import 'package:flutter/material.dart';

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
}

class BreakPointSystem {
  final RangeValues range;
  final String portrait;
  final String landscape;
  final AdaptiveWindow window;
  final int columns;
  final int margins;
  final int gutters;

  BreakPointSystem({
    Key key,
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

List<BreakPointSystem> breakpointSystems = [
  BreakPointSystem(
    range: RangeValues(0, 359),
    portrait: 'small handset',
    window: AdaptiveWindow.xs,
    columns: 4,
    margins: 16,
    gutters: 16,
  ),
  BreakPointSystem(
    range: RangeValues(360, 399),
    portrait: 'medium handset',
    window: AdaptiveWindow.xs,
    columns: 4,
    margins: 16,
    gutters: 16,
  ),
  BreakPointSystem(
    range: RangeValues(400, 479),
    portrait: 'large handset',
    window: AdaptiveWindow.xs,
    columns: 4,
    margins: 16,
    gutters: 16,
  ),
  BreakPointSystem(
    range: RangeValues(480, 599),
    portrait: 'large handset',
    landscape: 'small handset',
    window: AdaptiveWindow.xs,
    columns: 4,
    margins: 16,
    gutters: 16,
  ),
  BreakPointSystem(
    range: RangeValues(600, 719),
    portrait: 'small tablet',
    landscape: 'medium handset',
    window: AdaptiveWindow.s,
    columns: 8,
    margins: 16,
    gutters: 16,
  ),
  BreakPointSystem(
    range: RangeValues(720, 839),
    portrait: 'large tablet',
    landscape: 'large handset',
    window: AdaptiveWindow.s,
    columns: 8,
    margins: 24,
    gutters: 24,
  ),
  BreakPointSystem(
    range: RangeValues(840, 959),
    portrait: 'large tablet',
    landscape: 'large handset',
    window: AdaptiveWindow.s,
    columns: 12,
    margins: 24,
    gutters: 24,
  ),
  BreakPointSystem(
    range: RangeValues(960, 1023),
    landscape: 'small tablet',
    window: AdaptiveWindow.s,
    columns: 12,
    margins: 24,
    gutters: 24,
  ),
  BreakPointSystem(
    range: RangeValues(1024, 1279),
    landscape: 'large tablet',
    window: AdaptiveWindow.m,
    columns: 12,
    margins: 24,
    gutters: 24,
  ),
  BreakPointSystem(
    range: RangeValues(1280, 1439),
    landscape: 'large tablet',
    window: AdaptiveWindow.m,
    columns: 12,
    margins: 24,
    gutters: 24,
  ),
  BreakPointSystem(
    range: RangeValues(1440, 1599),
    portrait: 'small handset',
    window: AdaptiveWindow.l,
    columns: 12,
    margins: 24,
    gutters: 24,
  ),
  BreakPointSystem(
    range: RangeValues(1600, 1919),
    portrait: 'small handset',
    window: AdaptiveWindow.l,
    columns: 12,
    margins: 24,
    gutters: 24,
  ),
  BreakPointSystem(
    range: RangeValues(1920, 100000),
    portrait: 'small handset',
    window: AdaptiveWindow.xl,
    columns: 12,
    margins: 24,
    gutters: 24,
  ),
];

/// Returns ths Window Size to the user. This is useful when the user wants to
/// compare the MediaQuery to the current window size.
AdaptiveWindow getWindowSize(double width) {
  for (BreakPointSystem breakPointSystem in breakpointSystems) {
    if (breakPointSystem.range.start <= width && width <= breakPointSystem.range.end) {
      return breakPointSystem.window;
    }
  }
  throw AssertionError('WindowSize is too big');
}