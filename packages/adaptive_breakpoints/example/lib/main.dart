// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';

void main() {
  runApp(AdaptiveBreakpointsExample());
}

class AdaptiveBreakpointsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            _AdaptiveContainer(
              adaptiveConstraints: _AdaptiveConstraints(xs: true),
              color: Colors.red,
              child: Text('This is an extra small window'),
            ),
            _AdaptiveContainer(
              adaptiveConstraints: _AdaptiveConstraints(sm: true),
              color: Colors.orange,
              child: Text('This is a small window'),
            ),
            _AdaptiveContainer(
              adaptiveConstraints: _AdaptiveConstraints(md: true),
              color: Colors.yellow,
              child: Text('This is a medium window'),
            ),
            _AdaptiveContainer(
              adaptiveConstraints: _AdaptiveConstraints(lg: true),
              color: Colors.green,
              child: Text('This is a large window'),
            ),
            _AdaptiveContainer(
              adaptiveConstraints: _AdaptiveConstraints(xl: true),
              color: Colors.blue,
              child: Text('This is an extra large window'),
            ),
            _AdaptiveContainer(
              adaptiveConstraints: _AdaptiveConstraints(
                xs: true,
                sm: true,
              ),
              color: Colors.indigo,
              child: Text('This is a small or extra small window'),
            ),
            _AdaptiveContainer(
              adaptiveConstraints: _AdaptiveConstraints(
                md: true,
                lg: true,
                xl: true,
              ),
              color: Colors.pink,
              child: Text('This is a medium, large, or extra large window'),
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
class _AdaptiveContainer extends StatelessWidget {
  /// Creates a widget that combines common painting, positioning, and sizing widgets.
  ///
  /// The `color` and `decoration` arguments cannot both be supplied, since
  /// it would potentially result in the decoration drawing over the background
  /// color. To supply a decoration with a color, use `decoration:
  /// BoxDecoration(color: color)`.
  _AdaptiveContainer({
    Key key,
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
    @required this.adaptiveConstraints,
  })  : assert(adaptiveConstraints != null),
        assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(decoration == null || decoration.debugAssertIsValid()),
        assert(clipBehavior != null),
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
  final Widget child;

  /// Represents how height the container should be.
  final double height;

  /// Creates constraints for adaptive windows.
  ///
  /// This is used by the builder to see what type of screen the user wants this
  /// [AdaptiveContainer] to fit within.
  final _AdaptiveConstraints adaptiveConstraints;

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
  final AlignmentGeometry alignment;

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the [decoration];
  /// see [Decoration.padding].
  final EdgeInsetsGeometry padding;

  /// The color to paint behind the [child].
  ///
  /// This property should be preferred when the background is a simple color.
  /// For other cases, such as gradients or images, use the [decoration]
  /// property.
  ///
  /// If the [decoration] is used, this property must be null. A background
  /// color may still be painted by the [decoration] even if this property is
  /// null.
  final Color color;

  /// The decoration to paint behind the [child].
  ///
  /// Use the [color] property to specify a simple solid color.
  ///
  /// The [child] is not clipped to the decoration. To clip a child to the shape
  /// of a particular [ShapeDecoration], consider using a [ClipPath] widget.
  final Decoration decoration;

  /// The decoration to paint in front of the [child].
  final Decoration foregroundDecoration;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry margin;

  /// The transformation matrix to apply before painting the container.
  final Matrix4 transform;

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
            width: MediaQuery.of(context).size.width - (entry.margin * 2),
            height: height,
            margin: EdgeInsets.symmetric(horizontal: entry.margin),
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
class _AdaptiveConstraints {
  const _AdaptiveConstraints({
    this.xs = false,
    this.sm = false,
    this.md = false,
    this.lg = false,
    this.xl = false,
  });

  final bool xs;
  final bool sm;
  final bool md;
  final bool lg;
  final bool xl;

  bool withinAdaptiveConstraint(BuildContext context) {
    AdaptiveWindowType currentEntry = getWindowType(context);

    switch (currentEntry) {
      case AdaptiveWindowType.xsmall:
        return xs;
      case AdaptiveWindowType.small:
        return sm;
      case AdaptiveWindowType.medium:
        return md;
      case AdaptiveWindowType.large:
        return lg;
      case AdaptiveWindowType.xlarge:
        return xl;
      default:
        throw AssertionError('Unsupported AdaptiveWindowType');
    }
  }
}
