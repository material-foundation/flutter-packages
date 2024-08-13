// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/material.dart';

import 'adaptive_container.dart';

/// The [AdaptiveColumn] follows the Material guideline for responsive grids.
///
/// https://material.io/design/layout/responsive-layout-grid.html#columns-gutters-and-margins
///
/// This widget intigrates with the [AdaptiveContainer] widget.
/// The [AdaptiveContainer] widget has a parameter called columns which represents
/// the amount of columns it should take according to the breakpoints package.
///
/// So if the user has 6 adaptive container and each container represents two columns
/// then the 6 adaptive container would all fit within one Row on a extra large screen
/// because extra large screens have 12 columns per row.
///
/// Learn more about the breakpoint system:
///
/// https://material.io/design/layout/responsive-layout-grid.html#breakpoints
class AdaptiveColumn extends StatelessWidget {
  /// Creates a vertical array of children. Going from left to right and then
  /// top to bottom.
  ///
  /// This class has a responsive layout that is based of the adaptive breakpoints
  /// package. The user puts in [AdaptiveContainer] widgets as children and each
  /// child has a columm parameter. This represents the amount of columns it takes
  /// up in its current row. So if the child has three [AdaptiveContainer] widgets
  /// with each column set to 4 than on an extra-small screen each container would use up
  /// the entire width of the device. On an extra-large screen the three containers
  /// would fit across the row. This is because extra large devices allow up to
  /// 12 columns to fit within the space.
  ///
  /// To see an example visit:
  /// https://adaptive-components.web.app/#/
  const AdaptiveColumn({
    this.gutter,
    this.margin,
    required this.children,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.adjustColumnSpan = false,
    this.rowTextBaseline,
    super.key,
  })  : assert(margin == null || margin >= 0),
        assert(gutter == null || gutter >= 0);

  /// MainAxisAlignment of the row
  final MainAxisAlignment rowMainAxisAlignment;

  /// CrossAxisAlignment of the row
  final CrossAxisAlignment rowCrossAxisAlignment;

  /// Automatically expand to fill the entire row
  ///
  /// If the row item column span is less than the break entry columns in the row.
  final bool adjustColumnSpan;

  /// Empty space at the left and right of this widget.
  ///
  /// By default the margins will be set differently on different devices. This
  /// double value will be dependent of the breakpoint entry of the current screen.
  ///
  /// Learn more at https://material.io/design/layout/responsive-layout-grid.html#breakpoints
  final double? margin;

  /// Represents the space between children.
  ///
  /// By default the gutter will be set differently on different devices. This
  /// double value will be dependent of the breakpoint entry of the current screen.
  ///
  /// Learn more at https://material.io/design/layout/responsive-layout-grid.html#breakpoints
  final double? gutter;

  /// The List of [AdaptiveContainer]. Adaptive container neeeds to be used
  /// because the widget has a columnSpan parameter. This parameter represents the
  /// amount of columns this widget should incompass.
  ///
  /// By default it is set to 1.
  final List<AdaptiveContainer> children;

  /// [Row.textBaseline] of the row.
  final TextBaseline? rowTextBaseline;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        BreakpointSystemEntry entry = getBreakpointEntry(context);
        final double effectiveMargin = margin ?? entry.margin;
        final double effectiveGutter = gutter ?? entry.gutter;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: effectiveMargin),
          constraints: BoxConstraints(
            minWidth: entry.adaptiveWindowType.widthRangeValues.start,
            maxWidth: entry.adaptiveWindowType.widthRangeValues.end,
          ),
          child: Wrap(
            runSpacing: 8.0,
            children: () {
              int currentColumns = 0;
              List<Widget> children = [];
              final List<AdaptiveContainer> row = [];

              // Periodic width is the width of 1 column + 1 gutter.
              double periodicWidth = (constraints.maxWidth -
                      effectiveMargin * 2 +
                      effectiveGutter) /
                  entry.columns;

              /// Handles the row by adding each row item to the child list.
              ///
              /// This method iterates over each item in the row and calculates the maximum
              /// width for each item based on its column span and the gutter. It then adds
              /// each item to the child list with the calculated constraints.
              ///
              /// If there are multiple gutters in the row, it also adds gutter children
              /// to the child list.
              ///
              /// After processing the row, it resets the total gutters and current columns
              /// and clears the row for the next iteration.
              addRowItemsToChildren() {
                var autoExpandSpan = 0.0;
                if (adjustColumnSpan) {
                  autoExpandSpan = ((entry.columns -
                              row.fold(0, (a, b) => a + b.columnSpan)) /
                          row.length);
                }
                final realRow = row.map((AdaptiveContainer rowItem) {
                  // For a row item with a column span of k, its width is
                  // k * column + (k - 1) * gutter, which equals
                  // k * (column + gutter) - gutter, which is
                  // k * periodicWidth - gutter.
                  double maxWidth = periodicWidth *
                          (rowItem.columnSpan + autoExpandSpan)
                              .clamp(0, entry.columns) -
                      effectiveGutter;

                  return Container(
                    margin: EdgeInsets.only(
                      left: rowMainAxisAlignment == MainAxisAlignment.end &&
                              row.indexOf(rowItem) != 0
                          ? effectiveGutter
                          : 0.0,
                      right: (rowMainAxisAlignment == MainAxisAlignment.start ||
                                  rowMainAxisAlignment == MainAxisAlignment.center) &&
                              row.lastIndexOf(rowItem) != row.length - 1
                          ? effectiveGutter
                          : 0.0,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: maxWidth,
                        maxWidth: maxWidth,
                      ),
                      child: rowItem,
                    ),
                  );
                }).toList(growable: false);

                children.add(Row(
                  textBaseline: rowTextBaseline,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: rowMainAxisAlignment,
                  crossAxisAlignment: rowCrossAxisAlignment,
                  children: realRow,
                ));

                // Reset the total gutters and current columns, and clear the row for the
                // next iteration.
                currentColumns = 0;
                row.clear();
              }

              /// Distributes child widgets into rows based on their constraints and column spans.
              ///
              /// This method iterates over each child widget in the `this.children` list.
              /// For each child, it checks if the child's constraints are within the adaptive
              /// constraints of the layout context. If the child can be added to the current
              /// row without exceeding the total number of columns allowed (`entry.columns`),
              /// it adds the child to the `row` list and increments `totalGutters`.
              ///
              /// If adding the child would exceed the column limit, it calls
              /// `addRowItemsToChildren()` to finalize the current row and start a new one.
              /// It then resets `currentColumns` to the `columnSpan` of the current child.
              ///
              /// After the loop, it calls `addRowItemsToChildren()` one last time to ensure
              /// that any remaining children in the last row are processed and added to the
              /// child list.
              for (AdaptiveContainer child in this.children) {
                if (child.constraints.withinAdaptiveConstraint(context)) {
                  int tempColumns = currentColumns + child.columnSpan;
                  if (tempColumns > entry.columns) {
                    addRowItemsToChildren();
                    currentColumns = child.columnSpan;
                  } else {
                    currentColumns = tempColumns;
                  }
                  row.add(child);
                }
              }
              // Process and add the last row's items to the child list.
              addRowItemsToChildren();
              return children;
            }(),
          ),
        );
      },
    );
  }
}
