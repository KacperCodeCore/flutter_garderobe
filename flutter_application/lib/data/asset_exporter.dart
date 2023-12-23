import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_application/data/boxes.dart';

class AssetExporter {
  String appDir = Boxes.appDir;

  Future<void> copyAssetToFile(String assetPath, String fileName) async {
    try {
      final ByteData data = await rootBundle.load('$assetPath/$fileName');
      final List<int> bytes = data.buffer.asUint8List();

      File targetFile = File('$appDir/$fileName');

      // czy plik istnieje przed zapisem
      if (await targetFile.exists()) {
        print('file exists: $fileName');
        return;
      }

      await targetFile.writeAsBytes(bytes);
    } catch (e) {
      print('AssetExporter copyAssetToFile error: $e');
    }
  }
}
