// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/material.dart';
import 'adaptive_container.dart';

class AdaptiveColumn extends StatelessWidget {
  const AdaptiveColumn({
    this.gutter,
    this.margin,
    this.columns,
    @required this.children,
  }) : assert(children != null);

  final double margin;
  final double gutter;
  final AdaptiveConstraintsColumn columns;
  final List<AdaptiveContaine> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        BreakpointSystemEntry _entry = getBreakpointEntry(context);
        final double _margin = margin ?? _entry.margin;
        final double _gutter = gutter ?? _entry.gutter;
        final int _columns = columns?.getAdaptiveConstraintsColumn(context) == 0
            ? columns.getAdaptiveConstraintsColumn(context)
            : _entry.columns;

        return Container(
          color: Colors.grey,
          width: MediaQuery.of(context).size.width - (_margin * 2),
          margin: EdgeInsets.symmetric(horizontal: _margin),
          constraints: BoxConstraints(
            minWidth: _entry.adaptiveWindowType.widthRangeValues.start,
            maxWidth: _entry.adaptiveWindowType.widthRangeValues.end,
          ),
          child: Wrap(
//            spacing: _gutter,
            runSpacing: 8.0,
            children: () {
              int totalColumns = 0;
              List<Widget> childs = [];
                print(_columns);
              for (int counter = 0; counter < children.length; counter++) {
                if (children[counter]
                    .adaptiveConstraints
                    .withinAdaptiveConstraint(context)) {
                  double maxWidth = MediaQuery.of(context).size.width /
                      _columns *
                      children[counter].adaptiveColumn;
                  childs.add(
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: maxWidth,
                        maxWidth: maxWidth,
                      ),
                      child: children[counter],
                    ),
                  );
                  if (totalColumns < _columns) {
                    print(totalColumns);
                    childs.add(
                      SizedBox(
                        width: _gutter,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                    );
                    totalColumns += _columns;
                  }
                  else {
                    totalColumns = 0;
                  }
                }
              }

              return childs;
            }(),
          ),
        );
      },
    );
  }
}

/// Used to see if a range of [AdaptiveWindowType] should be shown in the window.
/// If the user sets one of the variables below to true than that window type
/// should be shown within the [AdaptiveContainer].
class AdaptiveConstraintsColumn {
  AdaptiveConstraintsColumn({
    this.xs = 0,
    this.s = 0,
    this.m = 0,
    this.l = 0,
    this.xl = 0,
  });

  AdaptiveConstraintsColumn.adaptive(int column) {
    xs = column;
    s = column;
    m = column;
    l = column;
    xl = column;
  }

  int xs;
  int s;
  int m;
  int l;
  int xl;

  int getAdaptiveConstraintsColumn(BuildContext context) {
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
//class AdaptiveFlex extends MultiChildRenderObjectWidget {
//  /// Creates a wrap layout.
//  ///
//  /// By default, the wrap layout is horizontal and both the children and the
//  /// runs are aligned to the start.
//  ///
//  /// The [textDirection] argument defaults to the ambient [Directionality], if
//  /// any. If there is no ambient directionality, and a text direction is going
//  /// to be necessary to decide which direction to lay the children in or to
//  /// disambiguate `start` or `end` values for the main or cross axis
//  /// directions, the [textDirection] must not be null.
//  Wrap({
//    Key key,
//    this.direction = Axis.horizontal,
//    this.alignment = WrapAlignment.start,
//    this.spacing = 0.0,
//    this.runAlignment = WrapAlignment.start,
//    this.runSpacing = 0.0,
//    this.crossAxisAlignment = WrapCrossAlignment.start,
//    this.textDirection,
//    this.verticalDirection = VerticalDirection.down,
//    this.clipBehavior = Clip.hardEdge,
//    List<Widget> children = const <Widget>[],
//  }) : assert(clipBehavior != null), super(key: key, children: children);
//
//  /// The direction to use as the main axis.
//  ///
//  /// For example, if [direction] is [Axis.horizontal], the default, the
//  /// children are placed adjacent to one another in a horizontal run until the
//  /// available horizontal space is consumed, at which point a subsequent
//  /// children are placed in a new run vertically adjacent to the previous run.
//  final Axis direction;
//
//  /// How the children within a run should be placed in the main axis.
//  ///
//  /// For example, if [alignment] is [WrapAlignment.center], the children in
//  /// each run are grouped together in the center of their run in the main axis.
//  ///
//  /// Defaults to [WrapAlignment.start].
//  ///
//  /// See also:
//  ///
//  ///  * [runAlignment], which controls how the runs are placed relative to each
//  ///    other in the cross axis.
//  ///  * [crossAxisAlignment], which controls how the children within each run
//  ///    are placed relative to each other in the cross axis.
//  final WrapAlignment alignment;
//
//  /// How much space to place between children in a run in the main axis.
//  ///
//  /// For example, if [spacing] is 10.0, the children will be spaced at least
//  /// 10.0 logical pixels apart in the main axis.
//  ///
//  /// If there is additional free space in a run (e.g., because the wrap has a
//  /// minimum size that is not filled or because some runs are longer than
//  /// others), the additional free space will be allocated according to the
//  /// [alignment].
//  ///
//  /// Defaults to 0.0.
//  final double spacing;
//
//  /// How the runs themselves should be placed in the cross axis.
//  ///
//  /// For example, if [runAlignment] is [WrapAlignment.center], the runs are
//  /// grouped together in the center of the overall [Wrap] in the cross axis.
//  ///
//  /// Defaults to [WrapAlignment.start].
//  ///
//  /// See also:
//  ///
//  ///  * [alignment], which controls how the children within each run are placed
//  ///    relative to each other in the main axis.
//  ///  * [crossAxisAlignment], which controls how the children within each run
//  ///    are placed relative to each other in the cross axis.
//  final WrapAlignment runAlignment;
//
//  /// How much space to place between the runs themselves in the cross axis.
//  ///
//  /// For example, if [runSpacing] is 10.0, the runs will be spaced at least
//  /// 10.0 logical pixels apart in the cross axis.
//  ///
//  /// If there is additional free space in the overall [Wrap] (e.g., because
//  /// the wrap has a minimum size that is not filled), the additional free space
//  /// will be allocated according to the [runAlignment].
//  ///
//  /// Defaults to 0.0.
//  final double runSpacing;
//
//  /// How the children within a run should be aligned relative to each other in
//  /// the cross axis.
//  ///
//  /// For example, if this is set to [WrapCrossAlignment.end], and the
//  /// [direction] is [Axis.horizontal], then the children within each
//  /// run will have their bottom edges aligned to the bottom edge of the run.
//  ///
//  /// Defaults to [WrapCrossAlignment.start].
//  ///
//  /// See also:
//  ///
//  ///  * [alignment], which controls how the children within each run are placed
//  ///    relative to each other in the main axis.
//  ///  * [runAlignment], which controls how the runs are placed relative to each
//  ///    other in the cross axis.
//  final WrapCrossAlignment crossAxisAlignment;
//
//  /// Determines the order to lay children out horizontally and how to interpret
//  /// `start` and `end` in the horizontal direction.
//  ///
//  /// Defaults to the ambient [Directionality].
//  ///
//  /// If the [direction] is [Axis.horizontal], this controls order in which the
//  /// children are positioned (left-to-right or right-to-left), and the meaning
//  /// of the [alignment] property's [WrapAlignment.start] and
//  /// [WrapAlignment.end] values.
//  ///
//  /// If the [direction] is [Axis.horizontal], and either the
//  /// [alignment] is either [WrapAlignment.start] or [WrapAlignment.end], or
//  /// there's more than one child, then the [textDirection] (or the ambient
//  /// [Directionality]) must not be null.
//  ///
//  /// If the [direction] is [Axis.vertical], this controls the order in which
//  /// runs are positioned, the meaning of the [runAlignment] property's
//  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
//  /// [crossAxisAlignment] property's [WrapCrossAlignment.start] and
//  /// [WrapCrossAlignment.end] values.
//  ///
//  /// If the [direction] is [Axis.vertical], and either the
//  /// [runAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
//  /// [crossAxisAlignment] is either [WrapCrossAlignment.start] or
//  /// [WrapCrossAlignment.end], or there's more than one child, then the
//  /// [textDirection] (or the ambient [Directionality]) must not be null.
//  final TextDirection textDirection;
//
//  /// Determines the order to lay children out vertically and how to interpret
//  /// `start` and `end` in the vertical direction.
//  ///
//  /// If the [direction] is [Axis.vertical], this controls which order children
//  /// are painted in (down or up), the meaning of the [alignment] property's
//  /// [WrapAlignment.start] and [WrapAlignment.end] values.
//  ///
//  /// If the [direction] is [Axis.vertical], and either the [alignment]
//  /// is either [WrapAlignment.start] or [WrapAlignment.end], or there's
//  /// more than one child, then the [verticalDirection] must not be null.
//  ///
//  /// If the [direction] is [Axis.horizontal], this controls the order in which
//  /// runs are positioned, the meaning of the [runAlignment] property's
//  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
//  /// [crossAxisAlignment] property's [WrapCrossAlignment.start] and
//  /// [WrapCrossAlignment.end] values.
//  ///
//  /// If the [direction] is [Axis.horizontal], and either the
//  /// [runAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
//  /// [crossAxisAlignment] is either [WrapCrossAlignment.start] or
//  /// [WrapCrossAlignment.end], or there's more than one child, then the
//  /// [verticalDirection] must not be null.
//  final VerticalDirection verticalDirection;
//
//  // TODO(liyuqian): defaults to [Clip.none] once Google references are updated.
//  /// {@macro flutter.widgets.Clip}
//  ///
//  /// Defaults to [Clip.hardEdge].
//  final Clip clipBehavior;
//
//  @override
//  RenderWrap createRenderObject(BuildContext context) {
//    return RenderWrap(
//      direction: direction,
//      alignment: alignment,
//      spacing: spacing,
//      runAlignment: runAlignment,
//      runSpacing: runSpacing,
//      crossAxisAlignment: crossAxisAlignment,
//      textDirection: textDirection ?? Directionality.of(context),
//      verticalDirection: verticalDirection,
//      clipBehavior: clipBehavior,
//    );
//  }
//
//  @override
//  void updateRenderObject(BuildContext context, RenderWrap renderObject) {
//    renderObject
//      ..direction = direction
//      ..alignment = alignment
//      ..spacing = spacing
//      ..runAlignment = runAlignment
//      ..runSpacing = runSpacing
//      ..crossAxisAlignment = crossAxisAlignment
//      ..textDirection = textDirection ?? Directionality.of(context)
//      ..verticalDirection = verticalDirection
//      ..clipBehavior = clipBehavior;
//  }
//
//  @override
//  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//    super.debugFillProperties(properties);
//    properties.add(EnumProperty<Axis>('direction', direction));
//    properties.add(EnumProperty<WrapAlignment>('alignment', alignment));
//    properties.add(DoubleProperty('spacing', spacing));
//    properties.add(EnumProperty<WrapAlignment>('runAlignment', runAlignment));
//    properties.add(DoubleProperty('runSpacing', runSpacing));
//    properties.add(DoubleProperty('crossAxisAlignment', runSpacing));
//    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
//    properties.add(EnumProperty<VerticalDirection>('verticalDirection', verticalDirection, defaultValue: VerticalDirection.down));
//  }
//}
