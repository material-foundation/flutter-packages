// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<Directory> getApplicationSupportDirectory() {
  return path_provider.getApplicationSupportDirectory();
}
