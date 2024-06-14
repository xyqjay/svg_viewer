import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

enum ViewType { start, single, multi }

class SelectFileModel extends ChangeNotifier {
  final List<String> items = [];

  ViewType get viewType {
    if (items.isEmpty) {
      return ViewType.start;
    } else if (items.length == 1) {
      return ViewType.single;
    }
    return ViewType.multi;
  }

  void selectFile(String path) {
    items.clear();
    items.add(path);
    notifyListeners();
  }

  void selectFiles(List<String> files) {
    items.clear();
    items.addAll(files);
    notifyListeners();
  }

  void selectXFiles(List<XFile> files) {
    List<String> selectedFiles = [];
    for (final XFile file in files) {
      // _debugPrintXfile(file);
      selectedFiles.add(file.path);
    }
    selectFiles(selectedFiles);
  }

  void clearFiles() {
    items.clear();
    notifyListeners();
  }

  Future<void> _debugPrintXfile(XFile file) async {
    debugPrint(file.mimeType);
    final File f = File(file.path);

    debugPrint('exists: ${f.existsSync()}');
    debugPrint('file: ${f.statSync().type == FileSystemEntityType.file}');
    debugPrint(
        'directory: ${f.statSync().type == FileSystemEntityType.directory}');
    debugPrint('link: ${f.statSync().type == FileSystemEntityType.link}');
    debugPrint(
        'not found: ${f.statSync().type == FileSystemEntityType.notFound}');
    debugPrint('  ${file.path} ${file.name}'
        '  ${await file.lastModified()}'
        '  ${await file.length()}'
        '  ${file.mimeType}');
  }
}
