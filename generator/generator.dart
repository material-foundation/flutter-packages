// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:mustache/mustache.dart';

void main() {
  // TODO(clocksmith): Integrate with package:build to automate generation.
  final fontsJsonData = readFontsJsonData();

  final outFile = File('lib/google_fonts.dart');
  final outFileWriteSink = outFile.openWrite();

  final methods = [];

  for (final item in fontsJsonData['items']) {
    final family = item['family'].toString().replaceAll(' ', '');
    final lowerFamily = family[0].toLowerCase() + family.substring(1);

    final themeParams = [
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
        for (final variant in item['variants'])
          {'variant': variant, 'url': item['files'][variant]}
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

Map readFontsJsonData() {
  final fontsJsonFile = File('data/fonts_data.json');
  final fontsJsonString = fontsJsonFile.readAsStringSync();
  return jsonDecode(fontsJsonString);
}
