import 'dart:typed_data' show ByteData;

/// By default, file IO is stubbed out.
///
/// If the path provider library is available (on mobile or desktop), then the
/// implementation in `file_io_desktop_and_mobile.dart` is used.

/// Stubbed out version of saveFontToDeviceFileSystem from
/// `file_io_desktop_and_mobile.dart`.
Future<void> saveFontToDeviceFileSystem(String name, List<int> bytes) =>
    Future.value(null);

/// Stubbed out version of loadFontFromDeviceFileSystem from
/// `file_io_desktop_and_mobile.dart`.
Future<ByteData> loadFontFromDeviceFileSystem(String name) =>
    Future.value(null);
