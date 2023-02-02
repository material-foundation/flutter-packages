// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

void main() {
  runApp(const AdaptiveBreakpointsExample());
}

class AdaptiveBreakpointsExample extends StatelessWidget {
  const AdaptiveBreakpointsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            AdaptiveContainer(
              adaptiveConstraints: const AdaptiveConstraints(xs: true),
              color: Colors.red,
              child: const Text('This is an extra small window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: const AdaptiveConstraints(s: true),
              color: Colors.orange,
              child: const Text('This is a small window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: const AdaptiveConstraints(m: true),
              color: Colors.yellow,
              child: const Text('This is a medium window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: const AdaptiveConstraints(l: true),
              color: Colors.green,
              child: const Text('This is a large window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: const AdaptiveConstraints(xl: true),
              color: Colors.blue,
              child: const Text('This is an extra large window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: const AdaptiveConstraints(
                xs: true,
                s: true,
              ),
              color: Colors.indigo,
              child: const Text('This is a small or extra small window'),
            ),
            AdaptiveContainer(
              adaptiveConstraints: const AdaptiveConstraints(
                m: true,
                l: true,
                xl: true,
              ),
              color: Colors.pink,
              child:
                  const Text('This is a medium, large, or extra large window'),
            ),
          ],
        ),
      ),
    );
  }
}

/// [AdaptiveContainer] lets you create a [Container] with adaptive constraints.
///
/// The AdaptiveContainer does everything a normal container does but with
/// adaptive constraints. For more information go to one of the links below.
///
/// https://api.flutter.dev/flutter/widgets/Container-class.html
/// https://material.io/design/layout/responsive-layout-grid.html#breakpoints
///
/// This class is useful whenever you want a container to only be active in
/// certain [AdaptiveWindowType].
class AdaptiveContainer extends StatelessWidget {
  /// Creates a widget that combines common painting, positioning, and sizing widgets.
  ///
  /// The `color` and `decoration` arguments cannot both be supplied, since
  /// it would potentially result in the decoration drawing over the background
  /// color. To supply a decoration with a color, use `decoration:
  /// BoxDecoration(color: color)`.
  AdaptiveContainer({
    Key? key,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.margin,
    this.transform,
    this.height,
    this.child,
    this.clipBehavior = Clip.none,
    required this.adaptiveConstraints,
  })  : assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(decoration == null || decoration.debugAssertIsValid()),
        assert(
            color == null || decoration == null,
            'Cannot provide both a color and a decoration\n'
            'To provide both, use "decoration: BoxDecoration(color: color)".'),
        super(key: key);

  /// The [child] contained by the container.
  ///
  /// If null, and if the [constraints] are unbounded or also null, the
  /// container will expand to fill all available space in its parent, unless
  /// the parent provides unbounded constraints, in which case the container
  /// will attempt to be as small as possible.
  final Widget? child;

  /// Represents how height the container should be.
  final double? height;

  /// Creates constraints for adaptive windows.
  ///
  /// This is used by the builder to see what type of screen the user wants this
  /// [AdaptiveContainer] to fit within.
  final AdaptiveConstraints adaptiveConstraints;

  /// Align the [child] within the container.
  ///
  /// If non-null, the container will expand to fill its parent and position its
  /// child within itself according to the given value. If the incoming
  /// constraints are unbounded, then the child will be shrink-wrapped instead.
  ///
  /// Ignored if [child] is null.
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry? alignment;

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the [decoration];
  /// see [Decoration.padding].
  final EdgeInsetsGeometry? padding;

  /// The color to paint behind the [child].
  ///
  /// This property should be preferred when the background is a simple color.
  /// For other cases, such as gradients or images, use the [decoration]
  /// property.
  ///
  /// If the [decoration] is used, this property must be null. A background
  /// color may still be painted by the [decoration] even if this property is
  /// null.
  final Color? color;

  /// The decoration to paint behind the [child].
  ///
  /// Use the [color] property to specify a simple solid color.
  ///
  /// The [child] is not clipped to the decoration. To clip a child to the shape
  /// of a particular [ShapeDecoration], consider using a [ClipPath] widget.
  final Decoration? decoration;

  /// The decoration to paint in front of the [child].
  final Decoration? foregroundDecoration;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry? margin;

  /// The transformation matrix to apply before painting the container.
  final Matrix4? transform;

  /// The clip behavior when [Container.decoration] has a clipPath.
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (adaptiveConstraints.withinAdaptiveConstraint(context)) {
          BreakpointSystemEntry entry = getBreakpointEntry(context);
          return Container(
            alignment: alignment,
            padding: padding,
            color: color,
            decoration: decoration,
            foregroundDecoration: foregroundDecoration,
            width: MediaQuery.of(context).size.width - (entry.margins * 2),
            height: height,
            margin: EdgeInsets.symmetric(horizontal: entry.margins),
            transform: transform,
            clipBehavior: clipBehavior,
            constraints: BoxConstraints(
              minWidth: entry.adaptiveWindowType.widthRangeValues.start,
              maxWidth: entry.adaptiveWindowType.widthRangeValues.end,
            ),
            child: child,
          );
        } else {
          return LimitedBox(
            maxWidth: 0.0,
            maxHeight: 0.0,
            child: ConstrainedBox(constraints: const BoxConstraints.expand()),
          );
        }
      },
    );
  }
}

/// Used to see if a range of [AdaptiveWindowType] should be shown in the window.
/// If the user sets one of the variables below to true than that window type
/// should be shown within the [AdaptiveContainer].
class AdaptiveConstraints {
  const AdaptiveConstraints({
    this.xs = false,
    this.s = false,
    this.m = false,
    this.l = false,
    this.xl = false,
  });

  final bool xs;
  final bool s;
  final bool m;
  final bool l;
  final bool xl;

  bool withinAdaptiveConstraint(BuildContext context) {
    AdaptiveWindowType currentEntry = getWindowType(context);

    switch (currentEntry) {
      case AdaptiveWindowType.xs:
        return xs;
      case AdaptiveWindowType.s:
        return s;
      case AdaptiveWindowType.m:
        return m;
      case AdaptiveWindowType.l:
        return l;
      case AdaptiveWindowType.xl:
        return xl;
      default:
        throw AssertionError('Unsupported AdaptiveWindowType');
    }
  }
}

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
        return const RangeValues(0, 599);
      case AdaptiveWindowType.s:
        return const RangeValues(600, 1023);
      case AdaptiveWindowType.m:
        return const RangeValues(1024, 1439);
      case AdaptiveWindowType.l:
        return const RangeValues(1440, 1919);
      case AdaptiveWindowType.xl:
        return const RangeValues(1920, double.infinity);
      default:
        throw AssertionError('Unsupported AdaptiveWindowType');
    }
  }

  RangeValues get heightLandscapeRangeValues {
    switch (this) {
      case AdaptiveWindowType.xs:
        return const RangeValues(0, 359);
      case AdaptiveWindowType.s:
        return const RangeValues(360, 719);
      case AdaptiveWindowType.m:
        return const RangeValues(720, 959);
      case AdaptiveWindowType.l:
        return const RangeValues(960, 1279);
      case AdaptiveWindowType.xl:
        return const RangeValues(1280, double.infinity);
      default:
        throw AssertionError('Unsupported AdaptiveWindowType');
    }
  }

  RangeValues get heightPortraitRangeValues {
    switch (this) {
      case AdaptiveWindowType.xs:
        return const RangeValues(0, 959);
      case AdaptiveWindowType.s:
        return const RangeValues(360, 1599);
      case AdaptiveWindowType.m:
        return const RangeValues(720, 1919);
      case AdaptiveWindowType.l:
        return const RangeValues(1920, double.infinity);
      case AdaptiveWindowType.xl:
        return const RangeValues(1920, double.infinity);
      default:
        throw AssertionError('Unsupported AdaptiveWindowType');
    }
  }
}

/// This class represents the Material breakpoint system entry.
/// https://material.io/design/layout/responsive-layout-grid.html#breakpoints
class BreakpointSystemEntry {
  BreakpointSystemEntry({
    required this.range,
    this.portrait,
    this.landscape,
    required this.adaptiveWindowType,
    required this.columns,
    required this.margins,
    required this.gutters,
  });

  /// The breakpoint range values represents a width range.
  final RangeValues range;

  /// Type of device which uses this breakpoint range in portrait view.
  String? portrait;

  /// Type of device which uses this breakpoint range in landscape view.
  String? landscape;

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
  final double margins;

  /// The size of gutters in pixels in this breakpoint system entry. Typically
  /// the same as margins.
  ///
  /// Gutters represents the space between the columns.
  ///
  /// https://material.io/design/layout/responsive-layout-grid.html#columns-gutters-and-margins
  final double gutters;
}

/// This list represents the material breakpoint system.
/// https://material.io/design/layout/responsive-layout-grid.html#breakpoints
///
/// This list is in sequential order.
List<BreakpointSystemEntry> breakpointSystem = [
  BreakpointSystemEntry(
    range: const RangeValues(0, 359),
    portrait: 'small handset',
    adaptiveWindowType: AdaptiveWindowType.xs,
    columns: 4,
    margins: 16.0,
    gutters: 16.0,
  ),
  BreakpointSystemEntry(
    range: const RangeValues(360, 399),
    portrait: 'medium handset',
    adaptiveWindowType: AdaptiveWindowType.xs,
    columns: 4,
    margins: 16.0,
    gutters: 16.0,
  ),
  BreakpointSystemEntry(
    range: const RangeValues(400, 479),
    portrait: 'large handset',
    adaptiveWindowType: AdaptiveWindowType.xs,
    columns: 4,
    margins: 16.0,
    gutters: 16.0,
  ),
  BreakpointSystemEntry(
    range: const RangeValues(480, 599),
    portrait: 'large handset',
    landscape: 'small handset',
    adaptiveWindowType: AdaptiveWindowType.xs,
    columns: 4,
    margins: 16.0,
    gutters: 16.0,
  ),
  BreakpointSystemEntry(
    range: const RangeValues(600, 719),
    portrait: 'small tablet',
    landscape: 'medium handset',
    adaptiveWindowType: AdaptiveWindowType.s,
    columns: 8,
    margins: 16.0,
    gutters: 16.0,
  ),
  BreakpointSystemEntry(
    range: const RangeValues(720, 839),
    portrait: 'large tablet',
    landscape: 'large handset',
    adaptiveWindowType: AdaptiveWindowType.s,
    columns: 8,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: const RangeValues(840, 959),
    portrait: 'large tablet',
    landscape: 'large handset',
    adaptiveWindowType: AdaptiveWindowType.s,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: const RangeValues(960, 1023),
    landscape: 'small tablet',
    adaptiveWindowType: AdaptiveWindowType.s,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: const RangeValues(1024, 1279),
    landscape: 'large tablet',
    adaptiveWindowType: AdaptiveWindowType.m,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: const RangeValues(1280, 1439),
    landscape: 'large tablet',
    adaptiveWindowType: AdaptiveWindowType.m,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: const RangeValues(1440, 1599),
    portrait: 'small handset',
    adaptiveWindowType: AdaptiveWindowType.l,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: const RangeValues(1600, 1919),
    portrait: 'small handset',
    adaptiveWindowType: AdaptiveWindowType.l,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
  ),
  BreakpointSystemEntry(
    range: const RangeValues(1920, double.infinity),
    portrait: 'small handset',
    adaptiveWindowType: AdaptiveWindowType.xl,
    columns: 12,
    margins: 24.0,
    gutters: 24.0,
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
