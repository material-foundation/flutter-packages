import 'dart:typed_data';

import 'package:flutter/services.dart' show FontLoader;

/// Abstract base class for implementations that load font data into the Flutter
/// engine.
abstract class GoogleFontsLoader {
  /// Loads the given font family and its font data into the Flutter engine,
  /// making the font available for use.
  Future<void> loadFont(String familyName, Future<ByteData> bytes);
}

/// The default font loader, using the Flutter default [FontLoader].
class DefaultGoogleFontsLoader implements GoogleFontsLoader {
  @override
  Future<void> loadFont(String familyName, Future<ByteData> bytes) async {
    final loader = FontLoader(familyName);
    loader.addFont(bytes);
    await loader.load();
  }
}
