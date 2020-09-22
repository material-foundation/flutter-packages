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
  /// To see an example visit:
  /// https://adaptive-components.web.app/#/
  const AdaptiveColumn({
    this.gutter,
    this.margin,
    @required this.children,
  }) : assert(children != null);

  /// Empty space at the left and right of this widget.
  final double margin;

  /// Represents the space between children.
  final double gutter;
  final List<AdaptiveContainer> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        BreakpointSystemEntry _entry = getBreakpointEntry(context);
        final double _margin = margin ?? _entry.margin;
        final double _gutter = gutter ?? _entry.gutter;
        final int _totalColumns = _entry.columns;

        return Container(
          width: MediaQuery.of(context).size.width - (_margin * 2),
          margin: EdgeInsets.symmetric(horizontal: _margin),
          constraints: BoxConstraints(
            minWidth: _entry.adaptiveWindowType.widthRangeValues.start,
            maxWidth: _entry.adaptiveWindowType.widthRangeValues.end,
          ),
          child: Wrap(
            runSpacing: 8.0,
            children: () {
              int currentColumns = 0;
              int totalGutters = 0;
              List<Widget> children = [];
              List<AdaptiveContainer> row = [];

              for (AdaptiveContainer child in this.children) {
                // The if statement checks if the adaptiveContainer child fits
                // within the adaptive constraints.
                if (child.adaptiveConstraints
                    .withinAdaptiveConstraint(context)) {
                  row.add(child);
                  currentColumns += child.adaptiveColumn;

                  if (currentColumns < _totalColumns) {
                    totalGutters++;
                  } else {
                    int gutters = 0;
                    if (currentColumns > _totalColumns) {
                      totalGutters--;
                    }

                    for (AdaptiveContainer rowItem in row) {
                      // maxWidth equals column width without margin and gutters
                      // divided by the total number of adaptive containers.
                      double maxWidth = (MediaQuery.of(context).size.width -
                              _margin * 2 -
                              _gutter *
                                  (gutters == totalGutters &&
                                          currentColumns > _totalColumns
                                      ? 0
                                      : totalGutters)) /
                          _totalColumns *
                          rowItem.adaptiveColumn;
                      children.add(
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: maxWidth,
                            maxWidth: maxWidth,
                          ),
                          child: rowItem,
                        ),
                      );

                      if (gutters < totalGutters && 1 < row.length) {
                        children.add(
                          SizedBox(
                            width: _gutter,
                            child: Container(
                              color: Colors.grey,
                            ),
                          ),
                        );
                        gutters++;
                      }
                    }
                    totalGutters = 0;
                    currentColumns = 0;
                    row = [];
                  }
                }
              }
              return children;
            }(),
          ),
        );
      },
    );
  }
}

