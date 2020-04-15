// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:console/console.dart';
import 'package:mustache/mustache.dart';

import 'fonts.pb.dart';

Future<void> main() async {
  print('Getting latest font directory...');
  final protoUrl = await _getProtoUrl();
  print('Success! Using $protoUrl');

  final fontDirectory = await _readFontsProtoData(protoUrl);
  print('\nValidating font URLs and file contents...');
  await _verifyUrls(fontDirectory);
  print(_success);

  print('\nGenerating $_generatedFilePath...');
  _generateDartFile(fontDirectory);
  print(_success);

  print('\nFormatting $_generatedFilePath...');
  await Process.run('flutter', ['format', _generatedFilePath]);
  print(_success);
}

const _generatedFilePath = 'lib/google_fonts.dart';
const _success = 'Success!';

void _generateDartFile(Directory fontDirectory) {
  final outFile = File(_generatedFilePath);
  final outFileWriteSink = outFile.openWrite();

  final methods = <Map<String, dynamic>>[];

  for (final item in fontDirectory.family) {
    final family = item.name;
    final familyNoSpaces = family.replaceAll(' ', '');
    final familyWithPlusSigns = family.replaceAll(' ', '+');
    final methodName = _familyToMethodName(family);

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

    methods.add(<String, dynamic>{
      'methodName': methodName,
      'fontFamily': familyNoSpaces,
      'fontFamilyDisplay': family,
      'docsUrl': 'https://fonts.google.com/specimen/$familyWithPlusSigns',
      'fontUrls': [
        for (final variant in item.fonts)
          {
            'variantWeight': variant.weight.start,
            'variantStyle':
                variant.italic.start.round() == 1 ? 'italic' : 'normal',
            'hash': _hashToString(variant.file.hash),
            'length': variant.file.fileSize,
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

String _familyToMethodName(String family) {
  final words = family.split(' ');
  for (var i = 0; i < words.length; i++) {
    final word = words[i];
    final isFirst = i == 0;
    final isUpperCase = word == word.toUpperCase();
    words[i] = (isFirst ? word[0].toLowerCase() : word[0].toUpperCase()) +
        (isUpperCase ? word.substring(1).toLowerCase() : word.substring(1));
  }
  return words.join();
}

Future<String> _getProtoUrl() async {
  var directoryNumber = 1;

  String url(int directoryNumber) {
    final paddedNumber = directoryNumber.toString().padLeft(3, '0');
    return 'http://fonts.gstatic.com/s/f/directory$paddedNumber.pb';
  }

  var didReachLatestUrl = false;
  final httpClient = http.Client();
  while (!didReachLatestUrl) {
    try {
      await httpClient.read(url(directoryNumber));
      directoryNumber += 1;
    } catch (e) {
      didReachLatestUrl = true;
      directoryNumber -= 1;
    }
  }
  httpClient.close();

  return url(directoryNumber);
}

Future<Directory> _readFontsProtoData(String protoUrl) async {
  final fontsProtoFile = await http.get(protoUrl);
  return Directory.fromBuffer(fontsProtoFile.bodyBytes);
}

Future<void> _verifyUrls(Directory fontDirectory) async {
  final totalFonts =
      fontDirectory.family.map((f) => f.fonts.length).reduce((a, b) => a + b);
  final progressBar = ProgressBar(complete: totalFonts);

  final client = http.Client();
  for (final family in fontDirectory.family) {
    for (final font in family.fonts) {
      final urlString =
          'https://fonts.gstatic.com/s/a/${_hashToString(font.file.hash)}.ttf';
      await _tryUrl(client, urlString, font);
      progressBar.update(progressBar.current + 1);
    }
  }
  client.close();
}

Future<void> _tryUrl(http.Client client, String url, Font font) async {
  try {
    final fileContents = await client.get(url);
    final actualFileLength = fileContents.bodyBytes.length;
    final actualFileHash = sha256.convert(fileContents.bodyBytes).toString();
    if (font.file.fileSize != actualFileLength ||
        _hashToString(font.file.hash) != actualFileHash) {
      throw Exception('Font from $url did not match length of or checksum.');
    }
  } catch (e) {
    print('Failed to load font from url: $url');
    rethrow;
  }
}

String _hashToString(List<int> bytes) {
  var fileName = '';
  for (final byte in bytes) {
    final convertedByte = byte.toRadixString(16).padLeft(2, '0');
    fileName += convertedByte;
  }
  return fileName;
}
