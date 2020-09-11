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
  final int columns;
  final List<AdaptiveContaine> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        BreakpointSystemEntry _entry = getBreakpointEntry(context);
        final double _margin = margin ?? _entry.margin;
        final double _gutter = gutter ?? _entry.gutter;
        final int _columns = columns ?? _entry.columns;

        return Container(
          color: Colors.pink,
          width: MediaQuery.of(context).size.width - (_margin * 2),
          margin: EdgeInsets.symmetric(horizontal: _margin),
          constraints: BoxConstraints(
            minWidth: _entry.adaptiveWindowType.widthRangeValues.start,
            maxWidth: _entry.adaptiveWindowType.widthRangeValues.end,
          ),
          child: Wrap(
            spacing: _entry.gutter,
            children: [
              children[0],
              children[1],
              children[2],
              children[3],
              children[4],
            ],
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

  int withinAdaptiveConstraint(BuildContext context) {
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
