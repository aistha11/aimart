import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

class ImageUploader {
  static late firebase_storage.Reference ref;
  static Future<String> uploadImage(String imgPath, String folderName) async {
    String imgUrl = "";
    try {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('$folderName/${path.basename(imgPath)}');
      await ref.putFile(File(imgPath)).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgUrl = value;
        });
      });
    } catch (e) {
      Get.snackbar("Error!!!", "Can't upload image at the moment");
    }
    return imgUrl;
  }
}