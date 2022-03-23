import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageDownloader {
  static Future<void> downloadImage(String url) async {
    try {
      var storageReference =
          firebase_storage.FirebaseStorage.instance.refFromURL(url);
      String imgName = storageReference.name.replaceFirst('image_picker', 'eka_down');
      log(imgName);
      var permission = await Permission.storage.request();
      if (permission.isGranted) {
        var response = await Dio()
            .get(url, options: Options(responseType: ResponseType.bytes));
        final result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(response.data),
            quality: 60,
            name: imgName);
        log(result);
        Get.snackbar("Success", "Image downloaded successfully.");
      }
    } catch (e) {
      Get.snackbar("Error!!!", "Sorry Cannot download image at the moment.");
    }
  }
}