// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/material.dart';

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
class AdaptiveContaine extends StatelessWidget {
  /// Creates a widget that combines common painting, positioning, and sizing widgets.
  ///
  /// The `color` and `decoration` arguments cannot both be supplied, since
  /// it would potentially result in the decoration drawing over the background
  /// color. To supply a decoration with a color, use `decoration:
  /// BoxDecoration(color: color)`.
  AdaptiveContaine({
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
    this.adaptiveConstraints,
    this.adaptiveColumn = 1,
  })  : assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(decoration == null || decoration.debugAssertIsValid()),
        assert(clipBehavior != null),
        assert(
            color == null || decoration == null,
            'Cannot provide both a color and a decoration\n'
            'To provide both, use "decoration: BoxDecoration(color: color)".'),
        super(key: key) {
    adaptiveConstraints ??= AdaptiveConstraints();
  }

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
  AdaptiveConstraints adaptiveConstraints;

  /// AdaptiveColumn is used with [AdaptiveColumn] to represent
  /// the amount of columns that this widget will fill up within a certain [Flex]
  /// range.
  ///
  /// By default the columns will only represent one column space. If you want
  /// this content of this widget to be shown increase it. There can be at most
  /// 12 columns per flex range.
  ///
  /// Learn more by visiting the Material website:
  /// https://material.io/design/layout/responsive-layout-grid.html#breakpoints
  final int adaptiveColumn;

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
          final double _margin = margin ?? 0.0;
          return Container(
            alignment: alignment,
            padding: padding,
            color: color,
            decoration: decoration,
            foregroundDecoration: foregroundDecoration,
            transform: transform,
            clipBehavior: clipBehavior,
            height: height,
            margin: EdgeInsets.symmetric(horizontal: _margin),
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
    this.xs = true,
    this.sm = true,
    this.md = true,
    this.lg = true,
    this.xl = true,
  });

  const AdaptiveConstraints.xs({
    this.xs = true,
    this.sm = false,
    this.md = false,
    this.lg = false,
    this.xl = false,
  });

  const AdaptiveConstraints.s({
    this.xs = false,
    this.sm = true,
    this.md = false,
    this.lg = false,
    this.xl = false,
  });

  const AdaptiveConstraints.m({
    this.xs = false,
    this.sm = false,
    this.md = true,
    this.lg = false,
    this.xl = false,
  });

  const AdaptiveConstraints.l({
    this.xs = false,
    this.sm = false,
    this.md = false,
    this.lg = true,
    this.xl = false,
  });

  const AdaptiveConstraints.xl({
    this.xs = false,
    this.sm = false,
    this.md = false,
    this.lg = false,
    this.xl = true,
  });

  final bool xs;
  final bool sm;
  final bool md;
  final bool lg;
  final bool xl;

  bool withinAdaptiveConstraint(BuildContext context) {
    AdaptiveWindowType currentEntry = getWindowType(context);

    switch (currentEntry) {
      case AdaptiveWindowType.xs:
        return xs;
      case AdaptiveWindowType.s:
        return sm;
      case AdaptiveWindowType.m:
        return md;
      case AdaptiveWindowType.l:
        return lg;
      case AdaptiveWindowType.xl:
        return xl;
      default:
        throw AssertionError('Unsupported AdaptiveWindowType');
    }
  }
}
