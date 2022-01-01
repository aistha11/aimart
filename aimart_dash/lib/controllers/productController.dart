import 'dart:io';

import 'package:aimart_dash/models/models.dart';
import 'package:aimart_dash/services/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class ProductController extends GetxController {
  final Rx<List<Product>> _productList = Rx<List<Product>>([]);

  List<Product> get productList => _productList.value;

  var name = TextEditingController().obs;
  var description = TextEditingController().obs;
  var price = TextEditingController().obs;
  var discount = TextEditingController().obs;
  var categoryId = "".obs;
  var subCategory = "".obs;
  var featured = false.obs;
  

  late firebase_storage.Reference ref;

  var productFormKey = GlobalKey<FormState>().obs;

  Rx<List<PickedFile>> pickedImages = Rx<List<PickedFile>>([]);

  var imageUrl = "".obs;

  final picker = ImagePicker();

  var uploading = false.obs;
  var submitting = false.obs;
  var progressVal = 0.0.obs;

  @override
  void onInit() {
    _productList.bindStream(FirebaseService.getProducts());
    super.onInit();
  }

  setCategoryId(String catId) {
    categoryId.value = catId;
    subCategory.value = "";
    update();
  }

  setFeatured(bool val){
    featured.value = val;
    update();
  }

  chooseImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      pickedImages.value.add(PickedFile(pickedFile!.path));
    } catch (e) {
      Get.snackbar("Ohh😮😮😮😮", "Image not selected😌😌😌😌");
    }

    update();
  }

  removeImageAt(int index) {
    pickedImages.value.removeAt(index);
    update();
  }

  removeImage(PickedFile file) {
    pickedImages.value.remove(file);
    update();
  }

  Future uploadFile() async {
    uploading.value = true;
    update();

    PickedFile img = pickedImages.value[0];

    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('product_images/${path.basename(img.path)}');
    await ref.putFile(File(img.path)).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        imageUrl.value = value;
      });
    });
    uploading.value = false;
    update();
  }

  Future<void> addProductToDb() async {
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      Get.snackbar("Check Your Internet Connection!", "Try again later");
    } else {
      if (productFormKey.value.currentState!.validate()) {
        submitting.value = true;
        if (pickedImages.value.isEmpty) {
          Get.snackbar("Sorry!", "Add at least one image for product.");
        } else {
          await uploadFile();
          update();
          Product product = Product(
            name: name.value.text,
            imageUrl: imageUrl.value,
            price: double.parse(price.value.text),
            categoryId: categoryId.value,
            discount: double.parse(discount.value.text),
            featured: featured.value,
            subCategory: subCategory.value,
            description: description.value.text,
            updateDate: DateTime.now()
          );
          

          await FirebaseService.createProduct(product).then(
            (value) {
              Get.snackbar(
                "Successfull!!",
                "Your Product is Created",
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          );
          onClear();
        }
      }
    }
    submitting.value = false;
    update();
    Get.back();
  }

  deleteProduct(String id) {
    FirebaseService.deleteProduct(id);
    update();
  }

  void onClear() {
    name.value.text = "";
    description.value.text = "";
    price.value.text = "";
    discount.value.text = "";
    imageUrl.value = "";
    pickedImages.value = [];
    progressVal.value = 0.0;
  }
}
