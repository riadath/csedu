import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

class StorageImage {
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    try {
      await storage.ref('profile_pictures/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String> downloadURL(String imageName) async {
    String url =
        await storage.ref('profile_pictures/$imageName').getDownloadURL();
    return url;
  }
}
