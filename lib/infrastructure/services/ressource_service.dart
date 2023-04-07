import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:http/http.dart' as http;

@singleton
class RessourceService {
  RessourceService._();

  @factoryMethod
  static RessourceService inject() {
    return RessourceService._();
  }

  Future<File> loadRessource(String path, String extension) async {
    final appDocDir = await path_provider.getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;

    print("loadRessource: $appDocPath/$path.$extension");
    return File('$appDocPath/$path.$extension');
  }

  //saveRessource in local storage
  Future<Map<String, String>> saveRessource(
      String path, String extension, Uint8List networkUrl) async {
    final appDocDir = await path_provider.getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;

    File file = File('$appDocPath/$path.$extension');
    file.writeAsBytesSync(networkUrl);

    print("saveRessource: $appDocPath/$path.$extension");
    return {"path": '$appDocPath/$path', "extension": extension};
  }

  //get image from network
  Future<Uint8List> getImage(String path) async {
    final response = await http.get(Uri.parse(path));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }
}