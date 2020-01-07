// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/src/google_fonts_family_with_variant.dart';
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
  TextStyle textStyle,
  Color color,
  Color backgroundColor,
  double fontSize,
  FontWeight fontWeight,
  FontStyle fontStyle,
  double letterSpacing,
  double wordSpacing,
  TextBaseline textBaseline,
  double height,
  Locale locale,
  Paint foreground,
  Paint background,
  List<Shadow> shadows,
  List<FontFeature> fontFeatures,
  TextDecoration decoration,
  Color decorationColor,
  TextDecorationStyle decorationStyle,
  double decorationThickness,
  @required Map<GoogleFontsVariant, String> fonts,
}) {
  assert(fontFamily != null);
  assert(fonts != null);

  textStyle ??= TextStyle();
  textStyle = textStyle.copyWith(
    color: color,
    backgroundColor: backgroundColor,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    letterSpacing: letterSpacing,
    wordSpacing: wordSpacing,
    textBaseline: textBaseline,
    height: height,
    locale: locale,
    foreground: foreground,
    background: background,
    shadows: shadows,
    fontFeatures: fontFeatures,
    decoration: decoration,
    decorationColor: decorationColor,
    decorationStyle: decorationStyle,
    decorationThickness: decorationThickness,
  );

  final variant = GoogleFontsVariant(
    fontWeight: textStyle.fontWeight ?? FontWeight.w400,
    fontStyle: textStyle.fontStyle ?? FontStyle.normal,
  );
  final matchedVariant = _closestMatch(variant, fonts.keys);
  final familyWithVariant = GoogleFontsFamilyWithVariant(
    family: fontFamily,
    googleFontsVariant: matchedVariant,
  );

  final descriptor = GoogleFontsDescriptor(
    familyWithVariant: familyWithVariant,
    fontUrl: fonts[matchedVariant],
  );

  loadFontIfNecessary(descriptor);

  return textStyle.copyWith(
    fontFamily: familyWithVariant.toString(),
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
  final familyWithVariantString = descriptor.familyWithVariant.toString();
  // If this font has already been loaded, then there is no need to load it
  // again.
  if (_loadedFonts.contains(familyWithVariantString)) {
    return;
  }

  // If this font can be loaded by the pre-bundled assets, then there is no
  // need to load it at all.
  final assetManifestJson = await _loadAssetManifestJson();

  if (_isFamilyWithVariantInManifest(
    descriptor.familyWithVariant,
    assetManifestJson,
  )) {
    return;
  }

  _loadedFonts.add(familyWithVariantString);
  final fontLoader = FontLoader(familyWithVariantString);

  Future<ByteData> byteData;
  if (!kIsWeb) {
    byteData = _loadFontFromDeviceFileSystem(familyWithVariantString);
  }
  final localFontFound = byteData != null && await byteData != null;
  if (!localFontFound) {
    byteData = _httpFetchFontAndSaveToDevice(
      familyWithVariantString,
      descriptor.fontUrl,
    );
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
Future<ByteData> _httpFetchFontAndSaveToDevice(
  String fontName,
  String fontUrl,
) async {
  final uri = Uri.tryParse(fontUrl);
  if (uri == null) {
    throw Exception('Invalid fontUrl: $fontUrl');
  }

  final response = await httpClient.get(uri);
  if (response.statusCode == 200) {
    _saveFontToDeviceFileSystem(fontName, response.bodyBytes);
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
  // TODO(clocksmith): what if this file is an otf?
  return File('$path/$name.ttf');
}

Future<File> _saveFontToDeviceFileSystem(String name, List<int> bytes) async {
  final file = await _localFile(name);
  return file.writeAsBytes(bytes);
}

Future<ByteData> _loadFontFromDeviceFileSystem(String name) async {
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

Future<Map<String, dynamic>> _loadAssetManifestJson() async {
  try {
    final jsonString = await rootBundle.loadString('AssetManifest.json');
    return json.decode(jsonString) as Map<String, dynamic>;
  } catch (e) {
    rootBundle.evict('AssetManifest.json');
    return null;
  }
}

bool _isFamilyWithVariantInManifest(
  GoogleFontsFamilyWithVariant familyWithVariant,
  Map<String, dynamic> manifestJson,
) {
  if (manifestJson == null) return false;

  for (final assetList in manifestJson.values) {
    for (final String asset in assetList) {
      String matchingFontSuffix;
      for (final suffix in ['.ttf', '.otf']) {
        if (asset.endsWith(suffix)) {
          matchingFontSuffix = suffix;
          break;
        }
      }

      if (matchingFontSuffix != null) {
        final assetWithRemovedExtension =
            asset.substring(0, asset.length - matchingFontSuffix.length);
        if (assetWithRemovedExtension
            .endsWith(familyWithVariant.toApiFilenamePrefix())) {
          return true;
        }
      }
    }
  }

  return false;
}
