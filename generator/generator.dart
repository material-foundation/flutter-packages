// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:mustache/mustache.dart';
import 'fonts.pb.dart';
import 'package:crypto/crypto.dart';

void main() async {
  await readFontsProtoData();

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

Future<void> readFontsProtoData() async {
  final fontsProtoFile = await http.get('http://fonts.gstatic.com/s/a/directory017.pb');
  final directory = Directory.fromBuffer(fontsProtoFile.bodyBytes);

  for (final family in directory.family) {
    for (final font in family.fonts) {
      var fileName = '';
      for (final byte in font.file.hash) {
        final convertedByte = byte.toRadixString(16);
//        print('byte: $byte');
//        print('signed: ${byte.toSigned(8)}');
//        print('convertedByte: $convertedByte');
        fileName += convertedByte;
      }
      final urlString = 'https://fonts.gstatic.com/s/a/$fileName.ttf';
      print("${family.name} font's url is: $urlString");
    }
  }

//  var urlString = '';
//  for(final byte in urlHashBytes) {
//    final convertedByte = byte.toRadixString(16);
//    print('byte: $byte');
//    print('signed: ${byte.toSigned(8)}');
//    print('convertedByte: $convertedByte');
//    urlString += convertedByte;
//  }
//  print(urlString);
}
