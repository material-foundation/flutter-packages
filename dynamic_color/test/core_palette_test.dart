import 'dart:ui';

import 'package:dynamic_color/src/core_palette.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CorePalette', () {
    test('fromList and asList', () {
      List<int> ints =
          List.generate(CorePalette.size * TonalPalette.size, (i) => i);
      CorePalette corePalette = CorePalette.fromList(ints);
      expect(corePalette.asList(), ints);
    });
  });

  group('TonalPalette', () {
    test('fromList and asList', () {
      List<int> ints = List.generate(TonalPalette.size, (i) => i);
      TonalPalette tonalPalette = TonalPalette.fromList(ints);
      expect(tonalPalette.allTones, ints.map((i) => Color(i)));
    });
  });
}
