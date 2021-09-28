import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A sample [CorePalette], as obtained by the [DynamicColorPlugin] from the
/// Android OS.
const sampleCorePalette = CorePalette(
  primary: TonalPalette(
    Color(0xFF000000),
    Color(0xFF21005E),
    Color(0xFF380094),
    Color(0xFF5200CE),
    Color(0xFF6D23F8),
    Color(0xFF8752FF),
    Color(0xFF9F79FF),
    Color(0xFFB79BFF),
    Color(0xFFD0BCFF),
    Color(0xFFEADDFF),
    Color(0xFFF6EEFF),
    Color(0xFFFFFBFE),
    Color(0xFFFFFFFF),
  ),
  secondary: TonalPalette(
    Color(0xFF000000),
    Color(0xFF1E1635),
    Color(0xFF332B4B),
    Color(0xFF4B4263),
    Color(0xFF63597C),
    Color(0xFF7C7296),
    Color(0xFF968BB1),
    Color(0xFFB1A5CD),
    Color(0xFFCCC0E8),
    Color(0xFFE9DDFF),
    Color(0xFFF6EEFF),
    Color(0xFFFFFBFE),
    Color(0xFFFFFFFF),
  ),
  tertiary: TonalPalette(
    Color(0xFF000000),
    Color(0xFF31101D),
    Color(0xFF492532),
    Color(0xFF633b48),
    Color(0xFF7D5260),
    Color(0xFF996A79),
    Color(0xFFB48392),
    Color(0xFFD29DAD),
    Color(0xFFEFB7C8),
    Color(0xFFFFD8E4),
    Color(0xFFFFECF1),
    Color(0xFFFCFCFC),
    Color(0xFFFFFFFF),
  ),
  neutral: TonalPalette(
    Color(0xFF000000),
    Color(0xFF1C1A22),
    Color(0xFF322F38),
    Color(0xFF48454E),
    Color(0xFF615D67),
    Color(0xFF79757F),
    Color(0xFF948F99),
    Color(0xFFAEA9B4),
    Color(0xFFCAC4D0),
    Color(0xFFE6E0EB),
    Color(0xFFF5EEFA),
    Color(0xFFFFFBFE),
    Color(0xFFFFFFFF),
  ),
  neutralVariant: TonalPalette(
    Color(0xFF000000),
    Color(0xFF1C1B1E),
    Color(0xFF313033),
    Color(0xFF484649),
    Color(0xFF605D62),
    Color(0xFF79767A),
    Color(0xFF938F94),
    Color(0xFFAEAAAE),
    Color(0xFFCAC5CA),
    Color(0xFFE6E1E6),
    Color(0xFFF4EFF3),
    Color(0xFFFFFBFE),
    Color(0xFFFFFFFF),
  ),
);

class CorePaletteVisualization extends StatefulWidget {
  const CorePaletteVisualization({Key? key}) : super(key: key);

  static const title = 'Sample CorePalette';

  @override
  State<CorePaletteVisualization> createState() =>
      _CorePaletteVisualizationState();
}

class _CorePaletteVisualizationState extends State<CorePaletteVisualization> {
  bool showSystemDynamicColor = false;

  @override
  Widget build(BuildContext context) {
    final canShowSystemDynamicColor = !kIsWeb && Platform.isAndroid;

    return Column(
      children: [
        SwitchListTile(
          title: const Text('Show Android OS dynamic CorePalette'),
          subtitle: const Text('Available on Android S+'),
          onChanged: canShowSystemDynamicColor
              ? (bool value) => setState(() => showSystemDynamicColor = value)
              : null,
          value: showSystemDynamicColor,
        ),
        Expanded(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: DynamicColorBuilder(
                  builder: (CorePalette? corePalette) {
                    return _RenderCorePalette(showSystemDynamicColor
                        ? corePalette ?? sampleCorePalette
                        : sampleCorePalette);
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _RenderCorePalette extends StatelessWidget {
  const _RenderCorePalette(this.corePalette, {Key? key}) : super(key: key);

  final CorePalette corePalette;

  static const corePaletteLabels = [
    'Primary',
    'Secondary',
    'Tertiary',
    'Neutral',
    'Neutral Variant',
  ];

  @override
  Widget build(BuildContext context) {
    final captionStyle = Theme.of(context).textTheme.caption;
    List<List<Color>> tones = [
      corePalette.primary.allTones,
      corePalette.secondary.allTones,
      corePalette.tertiary.allTones,
      corePalette.neutral.allTones,
      corePalette.neutralVariant.allTones,
    ];
    return Column(
      children: tones.mapIndexed(
        (List<Color> tones, int i) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 70,
                child: Text(
                  corePaletteLabels[i],
                  style: captionStyle,
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(width: 16),
              ...tones.mapIndexed((Color color, int i) {
                final toneValue = TonalPalette.toneValues[i];
                return Container(
                  constraints: const BoxConstraints.tightFor(
                    height: 80,
                    width: 60,
                  ),
                  color: color,
                  child: Center(
                    child: Text(
                      toneValue.toString(),
                      style: captionStyle!.copyWith(
                        // For contrast
                        color: toneValue > 50 ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ).toList(),
    );
  }
}

extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but the callback has index as second argument.
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndexed(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}
