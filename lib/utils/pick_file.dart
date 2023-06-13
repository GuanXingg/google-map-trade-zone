import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<String> pickStorageFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result == null || result.files.single.extension != 'kml') return Future.error('Can not get KML file');
  File file = File(result.files.single.path!);
  String fileContent = await file.readAsString();

  return fileContent;
}
