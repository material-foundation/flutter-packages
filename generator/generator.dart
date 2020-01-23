// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:mustache/mustache.dart';
import 'fonts.pb.dart';
import 'package:console/console.dart';

void main() async {
  final fontDirectory = await _readFontsProtoData();
//  await _verifyUrls(fontDirectory);

  final outFile = File('lib/google_fonts.dart');
  final outFileWriteSink = outFile.openWrite();

  final methods = [];

  for (final item in fontDirectory.family) {
    final family = item.name.replaceAll(' ', '');
    final lowerFamily = family[0].toLowerCase() + family.substring(1);

    const themeParams = [
      'display4',
      'display3',
      'display2',
      'display1',
      'headline',
      'title',
      'subhead',
      'body2',
      'body1',
      'caption',
      'button',
      'subtitle',
      'overline',
    ];

    methods.add({
      'methodName': '$lowerFamily',
      'fontFamily': family,
      'fontUrls': [
        for (final variant in item.fonts)
          {
            'variantWeight': variant.weight.start,
            'variantStyle':
                variant.italic.start.round() == 1 ? 'italic' : 'normal',
            'url': _hashToUrl(variant.file.hash),
          }
      ],
      'themeParams': [
        for (final themeParam in themeParams) {'value': themeParam}
      ]
    });
  }

  final template = Template(
    File('generator/google_fonts.tmpl').readAsStringSync(),
    htmlEscapeValues: false,
  );
  final result = template.renderString({'method': methods});

  outFileWriteSink.write(result);
  outFileWriteSink.close();
}

Future<Directory> _readFontsProtoData() async {
  const protoUrl = 'http://fonts.gstatic.com/s/a/directory017.pb';
  final fontsProtoFile = await http.get(protoUrl);
  return Directory.fromBuffer(fontsProtoFile.bodyBytes);
}

Future<void> _verifyUrls(Directory fontDirectory) async {
  final totalFonts =
      fontDirectory.family.map((f) => f.fonts.length).reduce((a, b) => a + b);
  final progressBar = ProgressBar(complete: totalFonts);

  final client = http.Client();
  print('Validating font URLs...');
  for (final family in fontDirectory.family) {
    for (final font in family.fonts) {
      final urlString = _hashToUrl(font.file.hash);
      await _tryUrl(client, urlString);
      progressBar.update(progressBar.current + 1);
    }
  }
  print('Success!');
  client.close();
}

Future<void> _tryUrl(http.Client client, String url) async {
  try {
    await client.read(url);
  } catch (e) {
    print('Failed to load font from url: $url');
    rethrow;
  }
}

String _hashToUrl(List<int> bytes) {
  var fileName = '';
  for (final byte in bytes) {
    final convertedByte = byte.toRadixString(16).padLeft(2, '0');
    fileName += convertedByte;
  }
  return 'https://fonts.gstatic.com/s/a/$fileName.ttf';
}
