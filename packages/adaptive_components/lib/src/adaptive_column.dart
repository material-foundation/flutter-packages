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
  final List<AdaptiveContainer> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        BreakpointSystemEntry _entry = getBreakpointEntry(context);
        final double _margin = margin ?? _entry.margin;
        final double _gutter = gutter ?? _entry.gutter;
        final int _adaptiveConstraintsColumn =
            columns?.getAdaptiveConstraintsColumn(context);
        final int _totalColumns = _adaptiveConstraintsColumn != null
            ? _adaptiveConstraintsColumn != 0
                ? _adaptiveConstraintsColumn
                : _entry.columns
            : _entry.columns;

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

/// Used to see if a range of [AdaptiveWindowType] should be shown in the window.
/// If the user sets one of the variables below to true then that window type
/// should be shown within the [AdaptiveContainer].
class AdaptiveConstraintsColumn {
  AdaptiveConstraintsColumn({
    this.xsmall = 0,
    this.small = 0,
    this.medium = 0,
    this.large = 0,
    this.xlarge = 0,
  });

  AdaptiveConstraintsColumn.adaptive(int column) {
    xsmall = column;
    small = column;
    medium = column;
    large = column;
    xlarge = column;
  }

  int xsmall;
  int small;
  int medium;
  int large;
  int xlarge;

  int getAdaptiveConstraintsColumn(BuildContext context) {
    AdaptiveWindowType currentEntry = getWindowType(context);

    switch (currentEntry) {
      case AdaptiveWindowType.xsmall:
        return xsmall;
      case AdaptiveWindowType.small:
        return small;
      case AdaptiveWindowType.medium:
        return medium;
      case AdaptiveWindowType.large:
        return large;
      case AdaptiveWindowType.xlarge:
        return xlarge;
      default:
        throw AssertionError('Unsupported AdaptiveWindowType');
    }
  }
}
