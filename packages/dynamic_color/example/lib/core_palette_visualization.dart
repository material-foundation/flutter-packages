import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

/// A sample [CorePalette], as obtained by the [DynamicColorPlugin] from the
/// Android OS.
final sampleCorePalette = CorePalette.fromList([
  // Primary
  0xFF000000,
  0xFF21005E,
  0xFF380094,
  0xFF5200CE,
  0xFF6D23F8,
  0xFF8752FF,
  0xFF9F79FF,
  0xFFB79BFF,
  0xFFD0BCFF,
  0xFFEADDFF,
  0xFFF6EEFF,
  0xFFFFFBFE,
  0xFFFFFFFF,
  // Secondary
  0xFF000000,
  0xFF1E1635,
  0xFF332B4B,
  0xFF4B4263,
  0xFF63597C,
  0xFF7C7296,
  0xFF968BB1,
  0xFFB1A5CD,
  0xFFCCC0E8,
  0xFFE9DDFF,
  0xFFF6EEFF,
  0xFFFFFBFE,
  0xFFFFFFFF,
  // Tertiary
  0xFF000000,
  0xFF31101D,
  0xFF492532,
  0xFF633b48,
  0xFF7D5260,
  0xFF996A79,
  0xFFB48392,
  0xFFD29DAD,
  0xFFEFB7C8,
  0xFFFFD8E4,
  0xFFFFECF1,
  0xFFFCFCFC,
  0xFFFFFFFF,
  // Neutral
  0xFF000000,
  0xFF1C1A22,
  0xFF322F38,
  0xFF48454E,
  0xFF615D67,
  0xFF79757F,
  0xFF948F99,
  0xFFAEA9B4,
  0xFFCAC4D0,
  0xFFE6E0EB,
  0xFFF5EEFA,
  0xFFFFFBFE,
  0xFFFFFFFF,
  // Neutral Variant
  0xFF000000,
  0xFF1C1B1E,
  0xFF313033,
  0xFF484649,
  0xFF605D62,
  0xFF79767A,
  0xFF938F94,
  0xFFAEAAAE,
  0xFFCAC5CA,
  0xFFE6E1E6,
  0xFFF4EFF3,
  0xFFFFFBFE,
  0xFFFFFFFF,
]);

class CorePaletteVisualization extends StatefulWidget {
  const CorePaletteVisualization({Key? key}) : super(key: key);

  static const title = 'CorePalette visualization';

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
                child: FutureBuilder<CorePalette?>(
                  future: DynamicColorPlugin.getCorePalette(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return _RenderCorePalette(showSystemDynamicColor
                          ? snapshot.data ?? sampleCorePalette
                          : sampleCorePalette);
                    } else {
                      return const CircularProgressIndicator();
                    }
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
    final captionStyle = Theme.of(context).textTheme.bodySmall;
    List<List<int>> colors = [
      corePalette.primary.asList,
      corePalette.secondary.asList,
      corePalette.tertiary.asList,
      corePalette.neutral.asList,
      corePalette.neutralVariant.asList,
    ];
    return Column(
      children: [
        for (final (int i, List<int> tones) in colors.indexed)
          Row(
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
              for (final (int i, int color) in tones.indexed)
                Container(
                  constraints: const BoxConstraints.tightFor(
                    height: 80,
                    width: 60,
                  ),
                  color: Color(color),
                  child: Center(
                    child: Text(
                      TonalPalette.commonTones[i].toString(),
                      style: captionStyle!.copyWith(
                        // For contrast
                        color: TonalPalette.commonTones[i] > 50
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
