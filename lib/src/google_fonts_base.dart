// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'google_fonts_descriptor.dart';
import 'google_fonts_variant.dart';

// Keep track of the loaded fonts in FontLoader for the life of the app
// instance.
final Set<String> _loadedFonts = {};

@visibleForTesting
http.Client httpClient = http.Client();

@visibleForTesting
void clearCache() => _loadedFonts.clear();

/// Creates a [TextStyle] that either uses the font family for the requested
/// GoogleFont, or falls back to the pre-bundled font family.
///
/// This function has a side effect of loading the font into the [FontLoader],
/// either by network or from the file system.
TextStyle googleFontsTextStyle({
  @required String fontFamily,
  double fontSize,
  FontWeight fontWeight,
  TextStyle textStyle,
  FontStyle fontStyle,
  @required Map<GoogleFontsVariant, String> fonts,
}) {
  assert(fontFamily != null);
  assert(fonts != null);

  textStyle ??= TextStyle();
  textStyle = textStyle.copyWith(
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
  );

  final variant = _closestMatch(
    GoogleFontsVariant(
      fontWeight: textStyle.fontWeight ?? FontWeight.w400,
      fontStyle: textStyle.fontStyle ?? FontStyle.normal,
    ),
    fonts.keys,
  );
  final descriptor = GoogleFontsDescriptor(
    fontFamily: fontFamily,
    fontWeight: variant.fontWeight,
    fontStyle: variant.fontStyle,
    fontUrl: fonts[variant],
  );

  loadFontIfNecessary(descriptor);

  return textStyle.copyWith(
    fontFamily: descriptor.familyWithVariant(),
    fontFamilyFallback: [fontFamily],
  );
}

/// Loads a font into the [FontLoader] with [googleFontsFamilyName] for the
/// matching [fontUrl].
///
/// If a font with the [fontName] has already been loaded into memory, then
/// this method does nothing as there is no need to load it a second time.
///
/// Otherwise, this method will first check to see if the font is available on
/// disk. If it is, then it loads it into the [FontLoader]. If it is not on
/// disk, then it fetches it via the [fontUrl], stores it on disk, and loads it
/// into the [FontLoader].
Future<void> loadFontIfNecessary(GoogleFontsDescriptor descriptor) async {
  final familyWithVariant = descriptor.familyWithVariant();
  // If this font has already been loaded, then there is no need to load it
  // again.
  if (_loadedFonts.contains(familyWithVariant)) {
    return;
  }

  _loadedFonts.add(familyWithVariant);
  final fontLoader = FontLoader(familyWithVariant);

  Future<ByteData> byteData;
  if (!kIsWeb) {
    byteData = _readLocalFont(familyWithVariant);
  }
  final localFontFound = byteData != null && await byteData != null;
  if (!localFontFound) {
    byteData = _httpFetchFont(familyWithVariant, descriptor.fontUrl);
  }
  fontLoader.addFont(byteData);
  await fontLoader.load();
  // TODO: Remove this once it is done automatically after loading a font.
  // https://github.com/flutter/flutter/issues/44460
  PaintingBinding.instance.handleSystemMessage({'type': 'fontsChange'});
}

// Returns [GoogleFontsVariant] from [variantsToCompare] that most closely
// matches [sourceVariant] according to the [_computeMatch] scoring function.
//
// This logic is derived from the following section of the minikin library,
// which is ultimately how flutter handles matching fonts.
// https://github.com/flutter/engine/blob/master/third_party/txt/src/minikin/FontFamily.cpp#L149
GoogleFontsVariant _closestMatch(
  GoogleFontsVariant sourceVariant,
  Iterable<GoogleFontsVariant> variantsToCompare,
) {
  int bestScore;
  GoogleFontsVariant bestMatch;
  for (final variantToCompare in variantsToCompare) {
    final score = _computeMatch(sourceVariant, variantToCompare);
    if (bestScore == null || score < bestScore) {
      bestScore = score;
      bestMatch = variantToCompare;
    }
  }
  return bestMatch;
}

/// Fetches a font with [fontName] from the [fontUrl] and saves it locally if
/// it is the first time it is being loaded.
///
/// This function can return null if the font fails to load from the URL.
Future<ByteData> _httpFetchFont(String fontName, String fontUrl) async {
  final uri = Uri.tryParse(fontUrl);
  if (uri == null) {
    throw Exception('Invalid fontUrl: $fontUrl');
  }

  final response = await httpClient.get(uri);
  if (response.statusCode == 200) {
    _writeLocalFont(fontName, response.bodyBytes);
    return ByteData.view(response.bodyBytes.buffer);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load font with url: $fontUrl');
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> _localFile(String name) async {
  final path = await _localPath;
  return File('$path/$name.ttf');
}

Future<File> _writeLocalFont(String name, List<int> bytes) async {
  final file = await _localFile(name);
  return file.writeAsBytes(bytes);
}

Future<ByteData> _readLocalFont(String name) async {
  try {
    final file = await _localFile(name);
    final fileExists = file.existsSync();
    if (fileExists) {
      List<int> contents = await file.readAsBytes();
      if (contents != null && contents.isNotEmpty) {
        return ByteData.view(Uint8List.fromList(contents).buffer);
      }
    }
  } catch (e) {
    return null;
  }
  return null;
}

// This logic is taken from the following section of the minikin library, which
// is ultimately how flutter handles matching fonts.
// * https://github.com/flutter/engine/blob/master/third_party/txt/src/minikin/FontFamily.cpp#L128
int _computeMatch(GoogleFontsVariant a, GoogleFontsVariant b) {
  if (a == b) {
    return 0;
  }
  int score = (a.fontWeight.index - b.fontWeight.index).abs();
  if (a.fontStyle != b.fontStyle) {
    score += 2;
  }
  return score;
}
