// @dart=2.9

import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<Directory> getApplicationSupportDirectory() {
  return path_provider.getApplicationSupportDirectory();
}
