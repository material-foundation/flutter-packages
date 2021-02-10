import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

Future<void> saveFontToDeviceFileSystem(String name, List<int> bytes) async {
  final file = await _localFile(name);
  await file.writeAsBytes(bytes);
}

Future<ByteData?> loadFontFromDeviceFileSystem(String name) async {
  try {
    final file = await _localFile(name);
    final fileExists = file.existsSync();
    if (fileExists) {
      List<int> contents = await file.readAsBytes();
      if (contents.isNotEmpty) {
        return ByteData.view(Uint8List.fromList(contents).buffer);
      }
    }
  } catch (e) {
    return null;
  }
  return null;
}

Future<String> get _localPath async {
  final directory = await getApplicationSupportDirectory();
  return directory!.path;
}

Future<File> _localFile(String name) async {
  final path = await _localPath;
  // We expect only ttf files to be provided to us by the Google Fonts API.
  // That's why we can be sure a previously saved Google Font is in the ttf
  // format instead of, for example, otf.
  return File('$path/$name.ttf');
}
